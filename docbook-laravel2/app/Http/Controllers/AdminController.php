<?php

namespace App\Http\Controllers;


use App\Models\Admin;
use App\Models\Doctor;
use App\Models\Patient;
use App\Models\TmpDoctor;
use App\Models\TmpComment;
use Illuminate\Http\Request;
use App\Models\Specialization;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;


class AdminController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return view('login.admin-login', [
            "title" => "Login Page",
        ]);
    }
    public function showDashboard()
    {
        $patients = DB::table('patients')->get();
        $doctors = DB::table('doctors')->get();
        $tmpDoctors = TmpDoctor::latest();
        return view('admin.dashboard', [
            "title" => "Dashboard Page",
            "doctors" => $doctors,
            "patients" => $patients,
            "tmpDoctors" => $tmpDoctors->get()
        ]);
    }
    public function showDetailTmpDoctor()
    {
        echo json_encode(TmpDoctor::join('specializations', 'specializations.id', '=', 'tmp_doctors.specialization_id')->where('tmp_doctors.id', $_POST['id'])->get()[0]);
    }
    public function showDetailDoctor()
    {
        echo json_encode(Doctor::join('specializations', 'specializations.id', '=', 'doctors.specialization_id')
            ->join('users', 'users.id', '=', 'doctors.doc_id')
            ->where('doctors.id', $_POST['id'])->get()[0]);
    }
    public function destroyRejectDoctor(TmpDoctor $tmpDoctor)
    {
        TmpDoctor::destroy($tmpDoctor->id);
        return redirect('/admin/dashboard')->with('success', 'Doctor has been deleted');
    }
    public function storeApproveDoctor(TmpDoctor $tmpDoctor)
    {
        $user = User::create([
            'name' => $tmpDoctor->full_name,
            'email' => $tmpDoctor->email,
            'password' => bcrypt($tmpDoctor->password),
            'type' => 'doctor',
        ]);

        $doctor = new Doctor([
            'doc_id' => $user->id,
            'user_name' => $tmpDoctor->user_name,
            'email' => $tmpDoctor->email,
            'mobile_number' => $tmpDoctor->mobile_number,
            'specialization_id' => $tmpDoctor->specialization_id,
            'bio_data' => $tmpDoctor->bio_data,
            'experience_year' => $tmpDoctor->experience_year,
            'status' => $tmpDoctor->status,
            'password' => bcrypt($tmpDoctor->password),
        ]);
        $doctor->save();
        TmpDoctor::destroy($tmpDoctor->id);
        return redirect('/admin/dashboard')->with('success', 'Doctor has been added');
    }

    public function showDoctor()
    {
        $doctors = Doctor::paginate(8);
        return view('admin.doctor.allDoctor', [
            "title" => "All Doctor",
            "doctors" => $doctors
        ]);
    }
    /**
     * Show the form for creating a new resource.
     */
    public function createDoctor()
    {
        return view('admin.doctor.addDoctor', [
            "title" => "Add Doctor"
        ]);
    }
    public function storeDoctor(Request $request)
    {
        $validatedData = $request->validate([
            'full_name' => 'required',
            'user_name' => 'required|unique:doctors',
            'email' => 'required|email:dns|unique:users|',
            'mobile_number' => 'required',
            'specialization_id' => 'required',
            'status' => 'required',
            'password' => 'required|min:3',
            'experience' => 'required',
            'bio_data' => 'required',
            'image' => 'image|file|max:5000'
        ]);
        if ($request->file('image')) {
            $validatedData['image'] = $request->file('image')->store('profile_photos');
        }

        $validatedData['password'] = Hash::make($validatedData['password']);
        $user = User::create([
            'name' => $validatedData['full_name'],
            'email' => $validatedData['email'],
            'password' => Hash::make($validatedData['password']),
            'type' => 'doctor',
            'profile_photo_path' => $validatedData['image'],
        ]);

        Doctor::create([
            'user_name' => $validatedData['user_name'],
            'mobile_number' => $validatedData['mobile_number'],
            'specialization_id' => $validatedData['specialization_id'],
            'bio_data' => $validatedData['bio_data'],
            'status' => $validatedData['status'],
            'experience' => $validatedData['experience'],
            'doc_id' => $user->id,
        ]);

        return redirect('admin/dashboard/addDoctor')->with('success', 'doctor successfully added');
    }

    /**
     * Store a newly created resource in storage.
     */

    /**
     * Display the specified resource.
     */
    public function show(Admin $admin)
    {
        //
    }
    public function showAllDoctorCategory()
    {
        $doctors = Doctor::latest()->get();
        $users = User::latest()->get();
        $specializations = Specialization::get();
        foreach ($doctors as $doctor) {
            foreach ($users as $user) {
                if ($user->id == $doctor->doc_id) {
                    $doctor->email = $user->email;
                    $doctor->name = $user->name;
                }
            }
        }

        return view('admin.doctor.category', [
            "title" => "Category Page",
            "container" => "generalContainer",
            "doctors" => $doctors,
            "specializations" => $specializations,
        ]);
    }
    public function fetchAllDoctorCategory(Request $request)
    {
        $specializations = Specialization::get();
        if ($request->ajax()) {
            $data = DB::table('doctors')->join('specializations', 'specializations.id', 'doctors.specialization_id')->paginate(10);
            return view('admin.doctor.DoctorsCategoryPage', [
                "doctors" => $data,
                "specializations" => $specializations
            ]);
        }
    }

    public function getDoctorByCategory(Request $request)
    {
        $spec_id = $request->id;
        $data = Doctor::latest()->where('doctors.specialization_id', $spec_id)->get();
        $users = User::latest()->get();
        $specializations = Specialization::get();
        foreach ($data as $doctor) {
            foreach ($users as $user) {
                if ($user->id == $doctor->doc_id) {
                    $doctor->email = $user->email;
                    $doctor->name = $user->name;
                }
            }
        }

        // return $data;
        return view('admin.doctor.DoctorsCategoryPage', [
            'doctors' => $data,
        ]);
    }
    public function showDoctorBySearch(Request $request)
    {
        $data = DB::table('doctors')
            ->join('specializations', 'specializations.id', 'doctors.specialization_id')
            ->join('users', 'users.id', 'doctors.doc_id')
            ->select('doctors.*', 'users.*', 'users.name as full_name', 'specializations.name as specialization_name', 'doctors.id as doctor_id');

        if (request('searchDoctor')) {
            $data->where('user_name', 'like', '%' . request('searchDoctor') . '%')->orWhere('users.name', 'like', '%' . request('searchDoctor') . '%');
        }
        return view('admin.doctor.search', [
            "title" => "Search Page",
            "container" => "generalContainer",
            "doctors" => $data->get()
        ]);
    }
    public function destroyRejectDoctor2(Doctor $doctor)
    {
        Doctor::destroy($doctor->id);
        return redirect('admin/dashboard/showDoctorBySearch')->with('success', 'Doctor has been deleted');
    }
    public function showPatientBySearch(Request $request)
    {
        $data = User::latest()->where('type', 'patient');
        if (request('searchPatient')) {
            $data = User::where('name', 'like', '%' . request('searchPatient') . '%');
        }
        return view('admin.patient.search', [
            "title" => "Search Page",
            "container" => "generalContainer",
            "patients" => $data->get()
        ]);
    }
    public function destroyRejectPatient(Patient $patient)
    {
        Patient::destroy($patient->id);
        User::destroy($patient->patient_id);
        return redirect('admin/dashboard/showPatientBySearch')->with('success', 'Patient has been deleted');
    }

    public function showComment()
    {
        // $data = DB::table('doctors')
        //     ->join('specializations', 'specializations.id', 'doctors.specialization_id')
        //     ->join('users', 'users.id', 'doctors.doc_id')
        //     ->select('doctors.*', 'users.*', 'users.name as full_name', 'specializations.name as specialization_name', 'doctors.id as doctor_id');
        $tmpComment = TmpComment::latest();
        return view('admin.patient.comment', [
            "title" => "Comment Page",
            "container" => "generalContainer",
            "tmpComment" => $tmpComment->get()
        ]);
    }
    public function showDetailTmpComment()
    {
        echo json_encode(TmpComment::where('id', $_POST['id'])->get()[0]);
    }

    public function destroyRejectComment(TmpComment $tmpComment)
    {
        Tmpcomment::destroy($tmpComment->id);
        return redirect('/admin/dashboard/comment')->with('success', 'comment has been deleted');
    }
    public function storeApproveComment(TmpComment $tmpComment)
    {
        // dd($tmpcomment);
        $comment = $tmpComment::find($tmpComment->id);
        $comment->replicate()->setTable('comments')->save();
        TmpComment::destroy($tmpComment->id);
        return redirect('/admin/dashboard/comment')->with('success', 'Comment has been added');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Admin $admin)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Admin $admin)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Admin $admin)
    {
        //
    }
}

// add doctor and patient, delete doctor and patient, update doctor and patient



// approve pending doctor



// display total patient and doctor 


// search doctor by date and name and category and add pagination

// update admin data

// doctors.id : ajax detail