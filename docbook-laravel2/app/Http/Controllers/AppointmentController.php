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
use App\Models\Comment;
use App\Models\Specialization;
use App\Models\User;

class AppointmentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $appointment = Appointment::where('patient_id', Auth::user()->id)->latest()->get();
        $doctor_experience = Doctor::all();
        $comment = Comment::all();
        $doctor = User::where('type', 'doctor')->get();
        $specializations = Specialization::all();


        // sorting appointment and doctor details 
        foreach ($appointment as $data) {
            foreach ($specializations as $specialization) {
                foreach ($doctor_experience as $de) {
                    foreach ($doctor as $info) {
                        $details = $info->doctor;
                        if ($data['doctor_id'] == $info['id'] && $details['specialization_id'] == $specialization['id'] && $data['doctor_id'] == $de['doc_id']) {
                            $data['doctor_name'] = $info['name'];
                            $data['doctor_profile'] = $info['profile_photo_path'];
                            $data['specialization_name'] = $specialization['name'];
                            $data['experience_year'] = $de['experience_year'];
                        }
                    }
                }
            }
        }

        return $appointment;
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
        $doctor = Doctor::where('specialization_id', $request->get('specialization_id'))->where('status', 'available')
            ->latest()->first();
        $user = User::where('id', Auth::guard('patient')->user()->patient_id)->first();

        $validatedData = $request->validate([
            'date' => 'required',
            'time' => 'required',
            'disease' => 'required'
        ]);
        // var_dump($validatedData['disease']);
        Appointment::create([
            'full_name' => $user->name,
            'date' => Carbon::parse($validatedData['date'])->format('Y-m-d'),
            'time' => $validatedData['time'],
            'disease' => $validatedData['disease'],
            'specialization_id' => $request->get('specialization_id'),
            'remark' => 'not updated yet',
            'status' => 'pending',
            'doctor_id' => $doctor->doc_id,
            'patient_id' => $user->id
        ]);

        return redirect('/')->with('success', 'successfully sent, check your appointment status <a href="/patient-record/' . Auth::guard('patient')->user()->user_name  . '">here</a>');
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
        $user = User::where('id', Auth::guard('patient')->user()->patient_id)->first();
        $validatedData = Validator::make($request->all(), [
            'date' => 'required',
            'time' => 'required',
            'disease' => 'required',
        ]);
        if (!$validatedData->passes()) {
            return response()->json(['status' => 0, 'error' => $validatedData->errors()->toArray()]);
        } else {
            $values = [
                'date' => Carbon::parse($request->date)->format('Y-m-d'),
                'time' => $request->time,
                'disease' => $request->disease,
                'full_name' => $user->name,
                'patient_id' => $user->id,
                'doctor_id' => $doctor->doc_id,
                'status' => "Pending",
                'specialization_id' => $request->specialization_id,
                'remark' => 'not updated yet'
            ];

            $appointment = new Appointment($values);
            $appointment->save();
            if ($appointment) {
                return response()->json(['status' => 1, 'msg' => 'successfully sent, check your appointment status <a href="/patient-record/' . Auth::guard('patient')->user()->user_name  . '">here</a>']);
            }
        }
    }

    public function editActionAppointment(Patient $patient, Appointment $appointment)
    {

        $doctor =  Auth::guard('doctor')->user();
        return view('dashboard.editAction', [
            "title" => "Edit Appointment Page",
            "container" => "generalContainer",
            "appointment" => $appointment,
            "doctor" => Doctor::where('doctors.id', $doctor->id)->join('users', 'users.id', '=', 'doctors.doc_id')->first(),
            'patient' => $patient,
            'action' => 'update appointment'
        ]);
    }

    public function updateActionAppointment(Request $request, Patient $patient, Appointment $appointment)
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

        return redirect('/dashboard')->with('success', 'your message successfully sent');
    }
    public function deleteAppointmentApprove(Request $request, Appointment $appointment)
    {
        // status, time, date, additionalMessage or remark
        $appointment->delete();
        return redirect('/dashboard/appointment-cancel/')->with('success', 'Appointment deleted successfully');
    }



    // mobile 

    // patient
    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Appointment $appointment)
    {
        //
    }

    public function storeDoctorMobile(Request $request)
    {
        $appointment = new Appointment();
        $appointment->patient_id = Auth::user()->id;
        $appointment->full_name = Auth::user()->name;
        $appointment->doctor_id = $request->get('doctor_id');
        $appointment->date = $request->get('date');
        $appointment->time = $request->get('time');
        $appointment->disease = $request->get('disease');
        $appointment->remark = 'not updated yet';
        $appointment->specialization_id = $request->get('specialization');
        $appointment->status = 'pending';
        $appointment->save();

        // $jsonPatientId = 

        return response()->json([
            'success' => 'New Appointment has been made successfully!',
        ], 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function updatePatientAppointment(Request $request, Appointment $appointment)
    {
        $appointment = Appointment::find($appointment->id);

        if (!$appointment) {
            return response()->json([
                'error' => 'Appointment not found',
            ], 404);
        }

        $appointment->update([
            'disease' => $request->input('disease'),
            'date' => Carbon::parse($request->input('date'))->format('Y-m-d'),
            'time' => $request->input('time'),
        ]);

        return response()->json([
            'success' => 'Appointment updated successfully!',
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroyPatientAppointment(Appointment $appointment)
    {
        // Check if the authenticated user is the owner of the appointment
        // if (Auth::user()->id !== $appointment->patient_id) {
        //     return response()->json(['error' => 'Unauthorized'], 403);
        // }

        try {
            $appointment->delete();
            return response()->json(['success' => 'Appointment deleted successfully'], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to delete appointment'], 500);
        }
    }
    public function updatePatientAppointmentStatus($id)
    {

        $appointment = Appointment::find($id);
        $appointment->update([
            'status' => 'completed',
        ]);
        return response()->json([
            'success' => 'Appointment updated successfully!',
        ], 200);
    }

    // Doctor
    public function updateAppointment(Request $request, $id)
    {
        // status, time, date, additionalMessage or remark
        $appointment = Appointment::find($id);

        $appointment->update([
            'status' => $request->status,
            'date' => \Carbon\Carbon::parse($request->date),
            'time' => $request->time,
            'remark' => $request->additional_message,
        ]);

        return $appointment;
    }
    public function destroyAppointment(Request $request, Appointment $appointment)
    {
        try {
            $appointment->delete();
            return response()->json(['success' => 'Appointment deleted successfully'], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to delete appointment'], 500);
        }
    }
}
