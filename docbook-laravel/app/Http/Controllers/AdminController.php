<?php

namespace App\Http\Controllers;


use App\Models\Admin;
use App\Models\Doctor;
use App\Models\Patient;
use App\Models\TmpDoctor;
use Laravel\Dusk\Browser;
use App\Models\TmpComment;
use Illuminate\Http\Request;
use App\Models\Specialization;
use Illuminate\Support\Carbon;
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
        echo json_encode(Doctor::join('specializations', 'specializations.id', '=', 'doctors.specialization_id')->where('doctors.first_name', $_POST['id'])->get()[0]);
    }
    public function destroyRejectDoctor(TmpDoctor $tmpDoctor)
    {
        TmpDoctor::destroy($tmpDoctor->id);
        return redirect('/admin/dashboard')->with('success', 'Doctor has been deleted');
    }
    public function storeApproveDoctor(TmpDoctor $tmpDoctor)
    {
        // dd($tmpDoctor);
        $doctor = $tmpDoctor::find($tmpDoctor->id);
        $doctor->replicate()->setTable('doctors')->save();
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
            'first_name' => 'required',
            'last_name' => 'required',
            'user_name' => 'required|unique:doctors',
            'email' => 'required|email:dns|unique:doctors|',
            'mobile_number' => 'required',
            'specialization_id' => 'required',
            'status' => 'required',
            'password' => 'required|min:3',
            'location' => 'required',
            'experience' => 'required',
            'img' => 'required|image|file|max:5000'
            // 'img' => 'required',
        ]);
        if ($request->file('img')) {
            $validatedData['img'] = $request->file('img')->store('doctor-img');
        }

        $validatedData['password'] = Hash::make($validatedData['password']);
        Doctor::create($validatedData);

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
        $doctors = Doctor::latest();
        $specializations = Specialization::get();

        return view('admin.doctor.category', [
            "title" => "Category Page",
            "container" => "generalContainer",
            "doctors" => $doctors->paginate(100),
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
        $data = DB::table('doctors')->join('specializations', 'specializations.id', 'doctors.specialization_id')->where('doctors.specialization_id', $spec_id);
        return view('admin.doctor.DoctorsCategoryPage', [
            'doctors' => $data->paginate(100),
        ]);
    }
    public function showDoctorBySearch(Request $request)
    {
        $data = DB::table('doctors')->join('specializations', 'specializations.id', 'doctors.specialization_id');
        if (request('searchDoctor')) {
            $data->where('first_name', 'like', '%' . request('searchDoctor') . '%')->orWhere('last_name', 'like', '%' . request('searchDoctor') . '%');
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


    public function createPatient()
    {
        return view('admin.patient.addPatient', [
            "title" => "Add Patient"
        ]);
    }
    public function storePatient(Request $request)
    {
        $validatedData = $request->validate([
            'full_name' => 'required',
            'user_name' => 'required|unique:doctors',
            'email' => 'required|email:dns|unique:patients|',
            'phone_no' => 'required',
            'password' => 'required|min:3',
        ]);

        $validatedData['password'] = Hash::make($validatedData['password']);
        Patient::create($validatedData);

        return redirect('admin/dashboard/addPatient')->with('success', 'patient successfully added');
    }

    public function showPatientBySearch(Request $request)
    {
        $data = Patient::latest();
        if (request('searchPatient')) {
            $data = Patient::where('full_name', 'like', '%' . request('searchPatient') . '%');
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
        return redirect('admin/dashboard/showPatientBySearch')->with('success', 'Patient has been deleted');
    }

    public function showComment()
    {
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