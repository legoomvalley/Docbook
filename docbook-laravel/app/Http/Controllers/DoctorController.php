<?php

namespace App\Http\Controllers;

use App\Models\Doctor;
use App\Models\TmpComment;
use App\Models\Appointment;
use Illuminate\Http\Request;
use App\Models\Specialization;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class DoctorController extends Controller
{

    public function index()
    {
        $doctors = Doctor::latest();
        $specializationName = Specialization::get();

        if (request('searchDoctor')) {
            $doctors->where('first_name', 'like', '%' . request('searchDoctor') . '%')->orWhere('last_name', 'like', '%' . request('searchDoctor') . '%')->get();
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
    public function bookDoctor(Doctor $doctor)
    {
        $specializationName = Specialization::get();
        // dd($doctors);

        return view('bookDoctor', [
            "title" => "Book Doctor",
            "container" => "generalContainer",
            "doctor" => $doctor,
            "specializations" => $specializationName,
            "option" => isset($option) ? $option : ""
        ]);
    }


    public function getBySpecialization()
    {
        $doctorsSpecialization = Doctor::latest();
        $specializationName = Specialization::get();
        $doctors = Doctor::latest();

        if (request()->specialization) {
            $resultCategory = request()->specialization;
            $doctorsSpecialization = Doctor::where('specialization_id', $resultCategory);

            if (request()->specialization == "1") {
                $option = "All doctors in Pediatrics";
            } elseif (request()->specialization == "2") {
                $option = "All doctors in General Medicine";
            } elseif (request()->specialization == "3") {
                $option = "All doctors in Eye Specialist";
            } elseif (request()->specialization == "4") {
                $option = "All doctors in Orthopedics";
            }
        }
        return view('doctors', [
            "title" => "doctor list",
            "container" => "generalContainer",
            "specializationName" => $specializationName,
            "doctors" => $doctors->get(),
            "doctorsSpecialization" => $doctorsSpecialization->get(),
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
