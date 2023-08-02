<?php

namespace App\Http\Controllers;

use App\Models\Doctor;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Laravel\Fortify\TwoFactorAuthenticatable;

class LoginController extends Controller
{
    // use AuthenticatesUsers;

    public function doctorLogin()
    {
        return view('login.doctor-login', [
            'title' => "doctor login",
            'container' => "generalContainer"
        ]);
    }


    public function authenticateDoctor(Request $request)
    {
        $credentials = $request->validate([
            'user_name' => 'required',
            'password' => 'required'
        ]);

        // login successfull 
        if (Auth::guard('doctor')->attempt($credentials)) {
            $request->session()->regenerate();
            return redirect()->intended('/dashboard');
        }

        // login failed
        return back()->with('error', 'Login failed, please try again');
    }



    public function logoutDoctor(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect('/');
    }



    public function authenticatePatient(Request $request)
    {
        $credentials = $request->validate([
            'user_name' => 'required',
            'password' => 'required'
        ]);

        // login successfull 
        if (Auth::guard('patient')->attempt($credentials)) {
            $request->session()->regenerate();
            return redirect()->intended('/');
        }

        // login failed
        return back()->with('error', 'Login failed, please try again');
    }

    public function logoutPatient(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect('/');
    }

    public function authenticateAdmin(Request $request)
    {
        $credentials = $request->validate([
            'user_name' => 'required',
            'password' => 'required'
        ]);

        // login successfull 
        if (Auth::guard('admin')->attempt($credentials)) {
            $request->session()->regenerate();
            return redirect()->intended('/admin/dashboard');
        }

        // login failed
        return back()->with('error', 'Login failed, please try again');
    }

    public function logoutAdmin(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect('/admin');
    }
}
// login 
// attempt = allow our program to check if the inserted information ever registered or not.

// patient register form 
// full name, phone number, email, username, password
// username must unique

// patient login form 
// username, password

// appointment form 
// date, disease, speciality, additional_message, status, id_doctors