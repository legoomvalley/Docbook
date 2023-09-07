<?php

namespace App\Http\Controllers;

use App\Models\Doctor;
use App\Models\TmpComment;
use App\Models\Appointment;
use App\Models\Comment;
use Illuminate\Http\Request;
use App\Models\Specialization;
use App\Models\User;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class DoctorController extends Controller
{

    public function index()
    {
        $doctors = User::latest()->where('type', 'doctor')->join('doctors', 'doctors.doc_id', '=', 'users.id')
            ->select('users.*');
        $specializationName = Specialization::get();

        if (request('searchDoctor')) {
            $searchTerm = '%' . request('searchDoctor') . '%';
            $doctors->where('users.name', 'like', $searchTerm);
        }

        // dd($doctors);

        return view('doctors', [
            "title" => "doctor list",
            "container" => "generalContainer",
            "doctors" => $doctors->get(),
            "specializationName" => $specializationName,
            "specializations" => $specializationName,
            "option" => isset($option) ? $option : ""
        ]);
    }


    public function getBySpecialization(Specialization $specialization)
    {
        $doctorsSpecialization = User::latest()->where('type', 'doctor');
        $doctor =  User::latest()->where('type', 'doctor');
        $specializationName = Specialization::get();

        if (request()->specialization) {
            $resultCategory = request()->specialization;
            if ($resultCategory == 'all') {
                $doctorsSpecialization = User::latest()->where('type', 'doctor')->join('doctors', 'doctors.doc_id', '=', 'users.id')
                    ->select('users.*');
            } else {
                $doctorsSpecialization = User::whereHas('doctor', function ($query) use ($resultCategory, $specialization) {
                    $query->where('specialization_id', $resultCategory)->orWhere('specialization_id', $specialization->id);
                })->where('type', 'doctor');
            }

            if (request()->specialization == "1" || $specialization->id == '1') {
                $option = "All doctors in Pediatrics";
            } elseif (request()->specialization == "2" || $specialization->id == '2') {
                $option = "All doctors in General Medicine";
            } elseif (request()->specialization == "3" || $specialization->id == '3') {
                $option = "All doctors in Eye Specialist";
            } elseif (request()->specialization == "4" || $specialization->id == '4') {
                $option = "All doctors in Orthopedics";
            } elseif (request()->specialization == "all") {
                $option = "All doctors";
            }
        }


        return view('doctors', [
            "title" => "doctor list",
            "container" => "generalContainer",
            "specializationName" => $specializationName,
            "doctorsSpecialization" => $doctorsSpecialization->get(),
            'doctors' => $doctor->get(),
            "option" => isset($option) ? $option : ""
        ]);
    }
    public function getBySpecializationName(Specialization $specialization)
    {
        $doctorsSpecialization = Doctor::latest();
        $specializationName = Specialization::get();
        $doctors = Doctor::where('specialization_id', $specialization->id);
        // dd($specialization);
        // $doctorsSpecialization = Doctor::where('specialization_id', $specialization->id);

        // if (request()->specialization) {
        //     $resultCategory = request()->specialization;

        //     if (request()->specialization == "1") {
        //         $option = "All doctors in Pediatrics";
        //     } elseif (request()->specialization == "2") {
        //         $option = "All doctors in General Medicine";
        //     } elseif (request()->specialization == "3") {
        //         $option = "All doctors in Eye Specialist";
        //     } elseif (request()->specialization == "4") {
        //         $option = "All doctors in Orthopedics";
        //     }
        // }
        return view('doctors', [
            "title" => "doctor list",
            "container" => "generalContainer",
            "specializationName" => $specializationName,
            "specialization" => $specialization,
            "doctors" => $doctors->get(),
            // "doctorsSpecialization" => $doctorsSpecialization->get(),
            "option" => isset($option) ? $option : ""
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        // 
    }

    public function showProfile(Doctor $doctor)
    {
        // dd($doctor);
        return view('doctorProfile', [
            "title" => "doctor profile",
            "container" => "generalContainer",
            "doctor" => $doctor,
            "specializations" => Specialization::all()

        ]);
    }
    public function showReview(Doctor $doctor)
    {
        return view('reviewPage', [
            "title" => "review page",
            "container" => "generalContainer",
            "doctor" => $doctor,
            "doctorComments" => $doctor->comments()->join('patients', 'patients.id', '=', 'comments.patient_id')->simplePaginate(2)
        ]);
    }
    public function comment(Doctor $doctor, Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'comment' => 'required'
            ]
        );
        if (!$validatedData->passes()) {
            return response()->json(['status' => 0, 'error' => $validatedData->errors()->toArray()]);
        } else {
            $values = [
                'comment' => $request->comment,
                'patient_id' => Auth::guard('patient')->user()->id,
                'doctor_id' => $doctor['id'],
                'created_at' => now()
            ];
        }
        $query = TmpComment::insert($values);
        if ($query) {
            return response()->json(['status' => 1, 'msg' => 'comment succesfully sent, please wait for admin to approve']);
        }
    }




    public function storePatient(Request $request)
    {
        $validatedData = Validator::make($request->all(), [
            'full_name' => 'required',
            'user_name' => 'required|unique:patients|',
            'email' => 'required|email:dns|unique:patients|',
            'phone_no' => 'required',
            'password' => 'required|min:3',
        ]);
        // $validatedData['password'] = Hash::make($validatedData['password']);
        if (!$validatedData->passes()) {
            return response()->json(['status' => 0, 'error' => $validatedData->errors()->toArray()]);
        } else {
            $values = [
                'full_name' => $request->full_name,
                'user_name' => $request->user_name,
                'email' => $request->email,
                'phone_no' => $request->phone_no,
                'password' => Hash::make($request->password)
            ];

            $query = DB::table('patients')->insert($values);
            if ($query) {
                return response()->json(['status' => 1, 'msg' => 'registration successfull']);
            }
            return redirect('/')->with('success', 'Registration successfull! Please login');
        }
    }

    // mobile

    public function updateDoctor(Request $request, $id)
    {
        $user = User::where('id', $id)->first();
        $doctor = Doctor::where('doc_id', $id)->first();
        $validatedData = Validator::make($request->all(), [
            'unique:doctors,user_name,' . $id,
            'unique:tmp_doctors,user_name,' . $id,
        ]);
        if (!$validatedData->passes()) {
            return response()->json($validatedData->errors(), 400);
        }
        $user->update([
            'name' => $request->name
        ]);
        $doctor->update([
            'user_name' => $request->user_name,
            'phone_no' => $request->phone_no,
            'specialization_id' => $request->specialization,
            'bio_data' => $request->bio_data,
            'experience_year' => $request->experience,
            'status' => $request->status,
        ]);

        // fullname, username, mobilenumber, specialization, status, biodata, experience

        return response()->json(['message' => 'Data updated successfully']);
    }

    public function showData()
    {
        // required data : appointment, user(doctor), related id patient, 
        $user = array();
        $user = Auth::user();
        $patients = User::where('type', 'patient')->get();
        $doctor = Doctor::where('doc_id', Auth::user()->id)->get();
        $appointments = Appointment::where('doctor_id', Auth::user()->id)->get();
        $todayAppointments = [];


        foreach ($appointments as $appointment) {
            if (now()->toDateString() == $appointment->date && 'approved' == $appointment->status) {
                // Add it to the todayAppointments array
                $todayAppointments[] = $appointment;
            }
            foreach ($patients as $patient) {
                if ($patient['id'] == $appointment['patient_id']) {
                    $appointment['patient_name'] = $patient['name'];
                    $appointment['photo_path'] = $patient['profile_photo_path'];
                }
            }
        }
        $user['doctor'] = $doctor;
        $user['patient'] = $appointments;
        $user['today_app'] = $todayAppointments;
        return $user;
    }

    public function showComment($doctorId)
    {
        $comments = Comment::where('doctor_id', $doctorId)->get();
        $patientsName = User::Select('name', 'id')->get();
        foreach ($comments as $comment) {
            foreach ($patientsName as $patientName) {
                if ($comment['patient_id'] == $patientName['id']) {
                    $comment['patientName'] = $patientName['name'];
                }
            }
        }
        return $comments;
    }
    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Doctor $doctorModel)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Doctor $doctorModel)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Doctor $doctorModel)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Doctor $doctorModel)
    {
        //
    }
}
