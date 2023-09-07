<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Doctor;
use App\Models\Patient;
use App\Models\TmpDoctor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class RegisterController extends Controller
{
    public function createDoctor()
    {
        return view('register.doctor-register', [
            'title' => 'doctor register',
            'container' => 'generalContainer'
        ]);
    }


    // website 

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
            'image' => 'required|image|file|max:5000'
        ]);
        if ($request->file('image')) {
            $validatedData['image'] = $request->file('image')->store('profile_photos');
        }

        $validatedData['password'] = Hash::make($validatedData['password']);
        TmpDoctor::create($validatedData);

        return redirect('/doctor')->with('success', 'Registration successfull! Please wait for admin to approve');
    }


    public function storePatient(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'full_name' => 'required',
                'user_name' => 'required|unique:patients|',
                'email' => 'required|email:dns|unique:users|',
                'phone_no' => 'required',
                'password' => 'required|min:3',
            ]
        );

        if (!$validatedData->passes()) {
            return response()->json(['status' => 0, 'error' => $validatedData->errors()->toArray()]);
        } else {
            $user = User::create([
                'name' => $request->full_name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'type' => 'patient'
            ]);
            Patient::create([
                'user_name' => $request->user_name,
                'phone_no' => $request->phone_no,
                'patient_id' => $user->id,
                'password' => Hash::make($request->password),
            ]);

            if ($user) {
                return response()->json(['status' => 1, 'msg' => 'registration successfull']);
            }
            return redirect('/')->with('success', 'Registration successfull! Please login');
        }
        // 
    }

    // mobile
    public function patientRegister(Request $request)
    {
        $validatedData = Validator::make($request->all(), [
            'full_name' => 'required',
            'user_name' => 'required|unique:patients|',
            'email' => 'required|email:dns|unique:users|',
            'phone_no' => 'required',
            'password' => 'required|min:3',
        ]);
        // $validatedData['password'] = Hash::make($validatedData['password']);
        if (!$validatedData->passes()) {
            return response()->json($validatedData->errors(), 400);
        }
        // else {
        $user = User::create([
            'name' => $request->full_name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'type' => 'patient'
        ]);
        Patient::create([
            'user_name' => $request->user_name,
            'phone_no' => $request->phone_no,
            'patient_id' => $user->id,
            'password' => Hash::make($request->password),

        ]);
        return $user;
    }
    public function doctorRegister(Request $request)
    {
        $validatedData = Validator::make($request->all(), [
            'full_name' => 'required',
            'user_name' => 'required|unique:doctors|unique:tmp_doctors|',
            'email' => 'required|email:dns|',
            'mobile_number' => 'required',
            'specialization' => 'required',
            'password' => 'required|min:3',

        ]);
        // $validatedData['password'] = Hash::make($validatedData['password']);
        if (!$validatedData->passes()) {
            return response()->json($validatedData->errors(), 400);
        }
        // else {
        $user = TmpDoctor::create([
            'full_name' => $request->full_name,
            'user_name' => $request->user_name,
            'email' => $request->email,
            'mobile_number' => $request->mobile_number,
            'specialization_id' => $request->specialization,
            'status' => $request->status,
            'password' => Hash::make($request->password),
            'bio_data' => $request->bio_data,
            'experience_year' => $request->experience_year,
        ]);
        return $user;
    }


    // firstName
    // lastName
    // userName
    // email
    // mobileNumber
    // specialization
    // status
    // password
    // location
    // experience
    // image
}

// registration 
// add csrf in form 
// we also can add validation like how much word can entered by user and other, and we also can handle the validation err if we want
// add 'old' laravel method to maintained the input value even the browser reloaded 


// postponed task 
// add validation and handle the invalid input with laravel :)
