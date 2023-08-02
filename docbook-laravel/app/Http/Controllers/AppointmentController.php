<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\Doctor;
use App\Models\Patient;
use App\Models\Appointment;
use Illuminate\Http\Request;
use Laravel\Ui\Presets\React;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Http\Requests\StoreAppointmentRequest;
use App\Http\Requests\UpdateAppointmentRequest;
use App\Models\Specialization;

class AppointmentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'date' => 'required',
            'time' => 'required',
            'disease' => 'required',
            'specialization_id' => 'required',
            'additional_message' => 'required'

        ]);
        //
        $validatedData['patient_id'] = Auth::guard('patient')->user()->id;
        $validatedData['full_name'] = Auth::guard('patient')->user()->full_name;
        $doctorId = Doctor::where('specialization_id', $validatedData['specialization_id'])->where('status', 'available')->pluck('id')[0];
        $validatedData['doctor_id'] = $doctorId;
        $validatedData['status'] = "Pending";
        $validatedData['remark'] = "not updated yet";
        $validatedData['date'] = Carbon::parse($validatedData['date'])->format('Y-m-d');
        DB::table('appointments')->insert($validatedData);

        return redirect('/')->with('success', 'New Appointment has been added! just wait and check your appointment at
        ');
    }
    public function storeBookDoctor(Request $request)
    {
        $validatedData = $request->validate([
            'date' => 'required',
            'time' => 'required',
            'disease' => 'required',
            'specialization_id' => 'required',
            'additional_message' => 'required'

        ]);
        //
        $validatedData['patient_id'] = Auth::guard('patient')->user()->id;
        $validatedData['full_name'] = Auth::guard('patient')->user()->full_name;
        $doctorId = Doctor::where('specialization_id', $validatedData['specialization_id'])->where('status', 'available')->pluck('id')[0];
        $validatedData['doctor_id'] = $doctorId;
        $validatedData['status'] = "Pending";
        $validatedData['remark'] = "not updated yet";
        $validatedData['date'] = Carbon::parse($validatedData['date'])->format('Y-m-d');
        DB::table('appointments')->insert($validatedData);

        return redirect()->back()->with('success', 'New Appointment has been added, wait and check your appointment at
        ');
    }

    /**
     * Display the specified resource.
     */
    public function storeByDoctor(Request $request, Doctor $doctor)
    {
        $validatedData = Validator::make($request->all(), [
            'date' => 'required',
            'time' => 'required',
            'disease' => 'required',
            'additional_message' => 'required'

        ]);
        if (!$validatedData->passes()) {
            return response()->json(['status' => 0, 'error' => $validatedData->errors()->toArray()]);
        } else {
            $values = [
                'date' => Carbon::parse($request->date)->format('Y-m-d'),
                'time' => $request->time,
                'disease' => $request->disease,
                'additional_message' => $request->additional_message,
                'full_name' => Auth::guard('patient')->user()->full_name,
                'patient_id' => Auth::guard('patient')->user()->id,
                'doctor_id' => $doctor->id,
                'status' => "Pending",
                'remark' => 'not updated yet'
            ];
            // dd($values);

            $query = DB::table('appointments')->insert($values);
            if ($query) {
                return response()->json(['status' => 1, 'msg' => 'successfully sent, check your appointment status <a href="/check-appointment/' . Auth::guard('patient')->user()->user_name  . '">here</a>']);
            }
        }
    }


    public function editActionAppointmentRequest(Patient $patient, Appointment $appointment)
    {

        $doctor =  Auth::guard('doctor')->user();
        return view('dashboard.editAction', [
            "title" => "Edit Appointment Page",
            "container" => "generalContainer",
            "appointment" => $appointment,
            "doctor" => $doctor,
            'patient' => $patient,
        ]);
    }
    public function updateActionAppointmentRequest(Request $request, Patient $patient, Appointment $appointment)
    {
        // $appointment = Appointment::where('patient_id', $patient->id);
        $validatedData = $request->validate([
            'status' => 'required',
            'remark' => 'required',
            'date' => 'required',
            'time' => 'required',
        ]);
        $validatedData['date'] = Carbon::parse($validatedData['date'])->format('Y-m-d');

        Appointment::where('id', $appointment->id)->update($validatedData);

        return redirect('/dashboard/appointment-request/')->with('success', 'your message successfully sent');
    }
    public function editActionAppointmentApprove(Patient $patient, Appointment $appointment)
    {

        $doctor =  Auth::guard('doctor')->user();
        return view('dashboard.editAction', [
            "title" => "Edit Appointment Page",
            "container" => "generalContainer",
            "appointment" => $appointment,
            "doctor" => $doctor,
            'patient' => $patient,
            'action' => 'appointment-approve'
        ]);
    }

    public function updateActionAppointmentApprove(Request $request, Patient $patient, Appointment $appointment)
    {
        // $appointment = Appointment::where('patient_id', $patient->id);
        $validatedData = $request->validate([
            'status' => 'required',
            'remark' => 'required',
            'date' => 'required',
            'time' => 'required',
            'action' => 'appointment-approve'

        ]);
        $validatedData['date'] = Carbon::parse($validatedData['date'])->format('Y-m-d');

        Appointment::where('id', $appointment->id)->update($validatedData);

        return redirect('/dashboard/appointment-approve/')->with('success', 'your message successfully sent');
    }
    public function editActionAppointmentCancel(Patient $patient, Appointment $appointment)
    {

        $doctor =  Auth::guard('doctor')->user();
        return view('dashboard.editAction', [
            "title" => "Edit Appointment Page",
            "container" => "generalContainer",
            "appointment" => $appointment,
            "doctor" => $doctor,
            'patient' => $patient,
            'action' => 'appointment-cancel'
        ]);
    }

    public function updateActionAppointmentCancel(Request $request, Patient $patient, Appointment $appointment)
    {
        // $appointment = Appointment::where('patient_id', $patient->id);
        $validatedData = $request->validate([
            'status' => 'required',
            'remark' => 'required',
            'date' => 'required',
            'time' => 'required',
            'action' => 'appointment-cancel'

        ]);
        $validatedData['date'] = Carbon::parse($validatedData['date'])->format('Y-m-d');

        Appointment::where('id', $appointment->id)->update($validatedData);

        return redirect('/dashboard/appointment-cancel/')->with('success', 'your message successfully sent');
    }
    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Appointment $appointment)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateAppointmentRequest $request, Appointment $appointment)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Appointment $appointment)
    {
        //
    }
}
