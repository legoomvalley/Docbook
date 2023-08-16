<?php

use App\Http\Controllers\LoginController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RegisterController;

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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
