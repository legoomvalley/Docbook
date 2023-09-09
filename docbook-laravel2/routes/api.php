<?php

use App\Http\Controllers\AppointmentController;
use App\Http\Controllers\DoctorController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\PatientController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\UsersController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
// patient
Route::post('/register/patient', [RegisterController::class, 'patientRegister']);
Route::post('/login/patient', [LoginController::class, 'patientLogin']);
// doctor
Route::post('/register/doctor', [RegisterController::class, 'doctorRegister']);
Route::post('/login/doctor', [LoginController::class, 'doctorLoginMobile']);




Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [UsersController::class, 'logout']);


    // doctor page
    Route::get('/doctors', [DoctorController::class, 'showData']);
    Route::put('/doctor/{id}', [DoctorController::class, 'updateDoctor']);
    Route::put('/appointment/{id}', [AppointmentController::class, 'updateAppointment']);
    Route::delete('/appointment/{appointment}', [AppointmentController::class, 'destroyAppointment']);


    // patient page 
    Route::get('/patients', [PatientController::class, 'showData']);
    Route::get('/appointments', [AppointmentController::class, 'index']);
    Route::get('/doctor/{doctorId}/comments', [DoctorController::class, 'showComment']);
    Route::post('/book', [AppointmentController::class, 'storeDoctorMobile']);
    Route::post('/comments', [PatientController::class, 'storeComment']);
    Route::put('/patient-profile', [PatientController::class, 'update']);
    Route::put('/appointment/{appointment}', [AppointmentController::class, 'updatePatientAppointment']);
    Route::put('/appointment/{id}/status/', [AppointmentController::class, 'updatePatientAppointmentStatus']);
    Route::delete('/appointment/{appointment}', [AppointmentController::class, 'destroyPatientAppointment']);
    Route::post('/image', [UsersController::class, 'uploadProfileImage']);
});
