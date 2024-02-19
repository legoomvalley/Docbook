<?php

namespace App\Http\Controllers;

use App\Models\Doctor;
use App\Models\Patient;
use App\Models\Appointment;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use SebastianBergmann\CodeCoverage\Report\Html\Dashboard;

class DashboardController extends Controller
{
    public function index()
    {
        $doctor =  Auth::guard('doctor')->user();

        $today =  today();
        $today = date('Y-m-d');

        return view('dashboard.index', [
            "title" => "Dashboard Page",
            "container" => "generalContainer",
            "doctor" => Doctor::where('doctors.id', $doctor->id)->join('users', 'users.id', '=', 'doctors.doc_id')->first(),

            "requestedAppointment" => Appointment::where('doctor_id', $doctor['doc_id'])->where('status', "pending")->join('patients', 'patients.patient_id' ,'=', 'appointments.patient_id' )->select('appointments.*', 'patients.phone_no', 'patients.user_name AS patient_user_name', 'patients.phone_no AS patient_phone_no')->paginate(2),
            "requestedAppointmentAll" => Appointment::where('doctor_id', $doctor['doc_id'])->where('status', "pending")->join('patients', 'patients.patient_id' ,'=', 'appointments.patient_id' )->select('appointments.*', 'patients.phone_no', 'patients.user_name AS patient_user_name', 'patients.phone_no AS patient_phone_no')->latest()->get(),

            "cancelledAppointment" => Appointment::where('doctor_id', $doctor['doc_id'])->where('status', '=', 'not approved')->join('patients', 'patients.patient_id' ,'=', 'appointments.patient_id' )->select('appointments.*', 'patients.phone_no', 'patients.user_name AS patient_user_name', 'patients.phone_no AS patient_phone_no')->paginate(2),
            "cancelledAppointmentAll" => Appointment::where('doctor_id', $doctor['doc_id'])->where('status', '=', 'not approved')->join('patients', 'patients.patient_id' ,'=', 'appointments.patient_id' )->select('appointments.*', 'patients.phone_no', 'patients.user_name AS patient_user_name', 'patients.phone_no AS patient_phone_no')->latest()->get(),


            "todayAppointment" => Appointment::where('doctor_id', $doctor['doc_id'])->where('date', '=', $today)->where('status', '=', 'approved')->join('patients', 'patients.patient_id' ,'=', 'appointments.patient_id' )->select('appointments.*', 'patients.phone_no', 'patients.user_name AS patient_user_name', 'patients.phone_no AS patient_phone_no')->paginate(2),
            "todayAppointmentAll" => Appointment::where('doctor_id', $doctor['doc_id'])->where('date', '=', $today)->where('status', '=', 'approved')->join('patients', 'patients.patient_id' ,'=', 'appointments.patient_id' )->select('appointments.*', 'patients.phone_no', 'patients.user_name AS patient_user_name', 'patients.phone_no AS patient_phone_no')->latest()->get(),
        ]);
    }
    public function showDetails()
    {
        echo json_encode(Appointment::join('patients', 'patients.patient_id', '=', 'appointments.patient_id')->join('users', 'users.id', '=', 'appointments.patient_id')->where('appointments.id', $_POST['id'])->get()[0]);
        // echo json_encode(Appointment::where('id', $_POST['id'])->get()[0]);
    }
    public function editDoctor(Doctor $doctor)
    {
        $doctorData = Doctor::where('doctors.id', $doctor->id)->join('users', 'users.id', '=', 'doctors.doc_id')->first();
        return view('dashboard.editDoctor', [
            "title" => "edit Page",
            "container" => "",
            "doctor" => $doctorData,

        ]);
    }
    public function updateDoctor(Request $request, Doctor $doctor)
    {
        $rules = [
            'mobile_number' => 'required',
            'full_name' => 'required',
            'experience' => 'required',
            'bio_data' => 'required',
            'specialization' => 'required',
            'image' => 'image|file|max:5000',
            'email' => 'required|email:dns|unique:users,email,' . $doctor->doc_id,
            'user_name' => 'required|unique:doctors,user_name,' . $doctor->id,
        ];
        $validatedData = $request->validate($rules);

        // Update the user record in the users table
        $user = User::find($doctor->doc_id);
        $user->name = $validatedData['full_name'];
        $user->email = $validatedData['email'];

        if ($request->oldImg) {
            Storage::delete($request->oldImg);
        }
        if ($request->file('image')) {
            $validatedData['image'] = $request->file('image')->store('profile_photos');

            $user->profile_photo_path = $validatedData['image'];
        }
        $user->save();



        Doctor::where('id', $doctor->id)->update([
            'user_name' => $validatedData['user_name'],
            'mobile_number' => $validatedData['mobile_number'],
            'specialization_id' => $validatedData['specialization'],
            'bio_data' => $validatedData['bio_data'],
            'experience_year' => $validatedData['experience'],
            'status' => $request->input('status')
        ]);
        return redirect('/dashboard/' . $request->user_name . '/edit')->with('success', 'Data succesfully Updated');
    }
    public function showAppointmentRequest()
    {
        $doctor =  Auth::guard('doctor')->user();

        return view('dashboard.request', [
            "title" => "Request Appointment Page",
            "container" => "generalContainer",
            "doctor" => Doctor::where('doctors.id', $doctor->id)->join('users', 'users.id', '=', 'doctors.doc_id')->first(),
            "doctorAppointments" => Appointment::where('doctor_id', $doctor['doc_id'])->where('status', "Pending")->join('patients', 'patients.patient_id' ,'=', 'appointments.patient_id' )->select('appointments.*', 'patients.user_name AS patient_user_name' ,'patients.phone_no AS patient_phone_no')->paginate(7),
        ]);
    }
    public function showAppointmentCancel()
    {
        $doctor =  Auth::guard('doctor')->user();

        return view('dashboard.cancel', [
            "title" => "Cancel Appointment Page",
            "container" => "generalContainer",
            "doctor" => Doctor::where('doctors.id', $doctor->id)->join('users', 'users.id', '=', 'doctors.doc_id')->first(),
            "doctorAppointments" => Appointment::where('doctor_id', $doctor['doc_id'])->where('status', '=', 'Not Approved')->join('patients', 'patients.patient_id' ,'=', 'appointments.patient_id' )->select('appointments.*', 'patients.user_name AS patient_user_name','patients.phone_no AS patient_phone_no')->paginate(7),
        ]);
    }
    public function showAppointmentApprove()
    {
        $doctor =  Auth::guard('doctor')->user();

        return view('dashboard.approve', [
            "title" => "Approve Appointment Page",
            "container" => "generalContainer",
            "doctor" => Doctor::where('doctors.id', $doctor->id)->join('users', 'users.id', '=', 'doctors.doc_id')->first(),
            "doctorAppointments" => Appointment::where('doctor_id', $doctor['doc_id'])->where('status', '=', 'Approved')->join('patients', 'patients.patient_id' ,'=', 'appointments.patient_id' )->select('appointments.*', 'patients.user_name AS patient_user_name','patients.phone_no AS patient_phone_no')->paginate(7),
        ]);
    }
    public function showAppointmentToday()
    {
        $doctor =  Auth::guard('doctor')->user();
        $today =  today();
        $today = date('Y-m-d');

        return view('dashboard.today', [
            "title" => "today Appointment Page",
            "container" => "generalContainer",
            "doctor" => Doctor::where('doctors.id', $doctor->id)->join('users', 'users.id', '=', 'doctors.doc_id')->first(),
            "doctorAppointments" => Appointment::where('doctor_id', $doctor['id'])->where('date', '=', $today)->join('patients', 'patients.patient_id' ,'=', 'appointments.patient_id' )->select('appointments.*', 'patients.user_name AS patient_user_name','patients.phone_no AS patient_phone_no')->paginate(7),
        ]);
    }
    public function showAppointmentName()
    {
        $doctor =  Auth::guard('doctor')->user();

        // $patient =  $doctor->appointments;
        $patient =  Appointment::latest();

        if (request('search')) {
            // foreach ($patient as $p) {
            $patient->where('full_name', 'like', '%' . request('search') . '%');
            // }
        }
        // dd($patient);
        return view('dashboard.name', [
            "title" => "Search Page",
            "container" => "generalContainer",
            "patient" => $patient->where('doctor_id', $doctor->doc_id)
            ->join('patients', 'patients.patient_id', '=', 'appointments.patient_id')
            ->join('users', 'users.id', '=', 'appointments.patient_id')
            ->select('appointments.*','patients.phone_no', 'users.email')->get(),
            "doctor" => Doctor::where('doctors.id', $doctor->id)->join('users', 'users.id', '=', 'doctors.doc_id')->first(),
        ]);
    }

    public function showAppointmentDate()
    {
        $doctor =  Auth::guard('doctor')->user();

        // $patient =  $doctor->appointments;
        $patient =  Appointment::latest();
        $search1 = Carbon::parse(request('search1'))->format('Y-m-d');
        $search2 = Carbon::parse(request('search2'))->format('Y-m-d');

        if (request('search1') && request('search2')) {
            // foreach ($patient as $p) {
            $patient->whereBetween('date', [$search1, $search2]);
            // }
        }
        // dd($patient);
        return view('dashboard.date', [
            "title" => "Search Page",
            "container" => "generalContainer",
            "patient" => $patient->where('doctor_id', $doctor->doc_id)
            ->join('patients', 'patients.patient_id', '=', 'appointments.patient_id')
            ->join('users', 'users.id', '=', 'appointments.patient_id')
            ->select('appointments.*','patients.phone_no', 'users.email')->get(),
            "doctor" => Doctor::where('doctors.id', $doctor->id)->join('users', 'users.id', '=', 'doctors.doc_id')->first(),
            // "doctorAppointments" => Appointment::where('doctor_id', $patient['id'])->where('date', '=', $today)->paginate(7),
        ]);
    }
}

// add edit button to all table then navigate to form that has (time and date, approval and doctor also can delete them) -> doctor can edit this