<?php

namespace App\Http\Controllers;

use App\Models\Doctor;
use App\Models\Patient;
use App\Models\Appointment;
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
            "doctor" => $doctor,

            "requestedAppointment" => Appointment::where('doctor_id', $doctor['id'])->where('status', "Pending")->paginate(2),
            "requestedAppointmentAll" => Appointment::where('doctor_id', $doctor['id'])->where('status', "Pending")->get(),

            "cancelledAppointment" => Appointment::where('doctor_id', $doctor['id'])->where('status', '=', 'Not Approved')->paginate(2),
            "cancelledAppointmentAll" => Appointment::where('doctor_id', $doctor['id'])->where('status', '=', 'Not Approved')->get(),


            "todayAppointment" => Appointment::where('doctor_id', $doctor['id'])->where('date', '=', $today)->where('status', '=', 'Approved')->paginate(2),
            "todayAppointmentAll" => Appointment::where('doctor_id', $doctor['id'])->where('date', '=', $today)->where('status', '=', 'Approved')->get(),
        ]);
    }
    public function showDetails()
    {
        echo json_encode(Appointment::join('patients', 'patients.id', '=', 'appointments.patient_id')->where('appointments.id', $_POST['id'])->get()[0]);
        // echo json_encode(Appointment::where('id', $_POST['id'])->get()[0]);
    }
    public function editDoctor(Doctor $doctor)
    {
        return view('dashboard.editDoctor', [
            "title" => "edit Page",
            "container" => "",
            "doctor" => $doctor,

        ]);
    }
    public function updateDoctor(Request $request, Doctor $doctor)
    {
        $rules = [
            'mobile_number' => 'required',
            'location' => 'required',
            'experience' => 'required',
            'specialization_id' => 'required',
            'status' => 'required',
            'img' => 'image|file|max:5000'
        ];
        if ($request->email != $doctor->email) {
            $rules['email'] = 'required|email:dns|unique:doctors|';
        }
        if ($request->user_name != $doctor->user_name) {
            $rules['user_name'] = 'required|unique:doctors|';
        }
        $validatedData = $request->validate($rules);
        if ($request->oldImg) {
            Storage::delete($request->oldImg);
        }
        if ($request->file('img')) {
            $validatedData['img'] = $request->file('img')->store('doctor-img');
        }

        Doctor::where('id', $doctor->id)->update($validatedData);

        return redirect('/dashboard/' . $request->user_name . '/edit')->with('success', 'Data succesfully Updated');
    }
    public function showAppointmentRequest()
    {
        $doctor =  Auth::guard('doctor')->user();

        return view('dashboard.request', [
            "title" => "Request Appointment Page",
            "container" => "generalContainer",
            "doctor" => $doctor,
            "doctorAppointments" => Appointment::where('doctor_id', $doctor['id'])->where('status', "Pending")->paginate(7),
        ]);
    }
    public function showAppointmentCancel()
    {
        $doctor =  Auth::guard('doctor')->user();

        return view('dashboard.cancel', [
            "title" => "Cancel Appointment Page",
            "container" => "generalContainer",
            "doctor" => $doctor,
            "doctorAppointments" => Appointment::where('doctor_id', $doctor['id'])->where('status', '=', 'Not Approved')->paginate(7),
        ]);
    }
    public function showAppointmentApprove()
    {
        $doctor =  Auth::guard('doctor')->user();

        return view('dashboard.approve', [
            "title" => "Approve Appointment Page",
            "container" => "generalContainer",
            "doctor" => $doctor,
            "doctorAppointments" => Appointment::where('doctor_id', $doctor['id'])->where('status', '=', 'Approved')->paginate(7),
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
            "doctor" => $doctor,
            "doctorAppointments" => Appointment::where('doctor_id', $doctor['id'])->where('date', '=', $today)->paginate(7),
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
            "patient" => $patient->where('doctor_id', $doctor->id)->get(),
            "doctor" => $doctor
            // "doctorAppointments" => Appointment::where('doctor_id', $patient['id'])->where('date', '=', $today)->paginate(7),
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
            "patient" => $patient->where('doctor_id', $doctor->id)->get(),
            "doctor" => $doctor
            // "doctorAppointments" => Appointment::where('doctor_id', $patient['id'])->where('date', '=', $today)->paginate(7),
        ]);
    }
}

// add edit button to all table then navigate to form that has (time and date, approval and doctor also can delete them) -> doctor can edit this