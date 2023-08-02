<?php

namespace App\Http\Controllers;

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



    public function storeDoctor(Request $request)
    {

        // ddd($request);
        // return $request->file('image')->store('doctor-img');

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
        TmpDoctor::create($validatedData);

        return redirect('/doctor-login')->with('success', 'Registration successfull! Please wait admin to approve you');
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
