<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\DoctorController;
use App\Http\Controllers\PatientController;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\AppointmentController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::middleware('guest:doctor')->group(function () {

    Route::get('/', [HomeController::class, 'index'])->name('home');
    Route::post('/home', [RegisterController::class, 'storePatient']);
    Route::get('/profile-page/{doctor:user_name}', [DoctorController::class, 'showProfile']);
    Route::get('/review-page/{doctor:user_name}', [DoctorController::class, 'showReview']);
    Route::post('/review-page/{doctor:user_name}', [DoctorController::class, 'comment']);
    Route::post('profile-page/{doctor:user_name}/make-appointment', [AppointmentController::class, 'storeByDoctor']);
    Route::post('/', [LoginController::class, 'authenticatePatient']);
    Route::post('/patient-logout', [LoginController::class, 'logoutPatient']);
    Route::get('/all-doctors/specialization/{specialization:name}', [DoctorController::class, 'getBySpecializationName']);
});

Route::get('/all-doctors', [DoctorController::class, 'index']);
Route::post('/all-doctors/specialization', [DoctorController::class, 'getBySpecialization']);
Route::get('/all-doctors/specialization/{specialization}', [DoctorController::class, 'getBySpecialization'])->name('specialization');
Route::get('/doctor-login', [LoginController::class, 'doctorLogin'])->middleware('guest:doctor')->name('login');
Route::post('/doctor-login', [LoginController::class, 'authenticateDoctor']);
Route::get('/doctor-register', [RegisterController::class, 'createDoctor'])->middleware('guest:doctor');
Route::post('/doctor-register', [RegisterController::class, 'storeDoctor']);
Route::post('/doctor-logout', [LoginController::class, 'logoutDoctor']);



Route::middleware('doctor-access:doctor')->group(function () {

    Route::get('/dashboard', [DashboardController::class, 'index']);
    Route::post('/dashboard', [DashboardController::class, 'showDetails']);
    Route::get('/dashboard/{doctor:user_name}/edit', [DashboardController::class, 'editDoctor']);
    Route::post('/dashboard/{doctor:user_name}', [DashboardController::class, 'updateDoctor']);
    Route::get('/dashboard/appointment-request', [DashboardController::class, 'showAppointmentRequest']);
    Route::get('/dashboard/appointment-cancel', [DashboardController::class, 'showAppointmentCancel']);
    Route::get('/dashboard/appointment-today', [DashboardController::class, 'showAppointmentToday']);
    Route::get('/dashboard/appointment-approve', [DashboardController::class, 'showAppointmentApprove']);
    Route::get('/dashboard/appointment-search-by-name', [DashboardController::class, 'showAppointmentName']);
    Route::get('/dashboard/appointment-search-by-date', [DashboardController::class, 'showAppointmentDate']);

    Route::get('/dashboard/appointment-request/{patient:user_name}/{appointment}/edit', [AppointmentController::class, 'editActionAppointmentRequest']);

    Route::get('/dashboard/appointment-approve/{patient:user_name}/{appointment}/edit', [AppointmentController::class, 'editActionAppointmentApprove']);
    Route::post('/dashboard/appointment-approve/{patient:user_name}/{appointment}/', [AppointmentController::class, 'updateActionAppointmentApprove']);

    Route::get('/dashboard/appointment-cancel/{patient:user_name}/{appointment}/edit', [AppointmentController::class, 'editActionAppointmentCancel']);
    Route::delete('/appointment-cancel/{appointment}', [AppointmentController::class, 'deleteAppointmentApprove']);
});

Route::middleware('patient-access:patient')->group(function () {

    Route::get('/check-appointment/{patient:user_name}', [PatientController::class, 'index']);
    Route::post('/check-appointment', [PatientController::class, 'showDetails']);
    Route::delete('/appointment/{appointment:id}', [PatientController::class, 'deleteAppointment']);
    Route::put('/appointment/{appointment:id}', [PatientController::class, 'updateAppointmentToComplete']);
    Route::post('/make-appointment', [AppointmentController::class, 'store']);
});

Route::get('/admin', [AdminController::class, 'index']);
Route::post('/admin', [LoginController::class, 'authenticateAdmin']);
Route::post('/admin-logout', [LoginController::class, 'logoutAdmin']);

Route::middleware('admin-access:admin')->group(function () {
    Route::get('/admin/dashboard', [AdminController::class, 'showDashboard']);
    Route::post('/admin/dashboard', [AdminController::class, 'showDetailTmpDoctor']);
    Route::post('/admin/dashboard/approve-doctor/{tmpDoctor}', [AdminController::class, 'storeApproveDoctor']);
    Route::post('/admin/dashboard/reject-doctor/{tmpDoctor}', [AdminController::class, 'destroyRejectDoctor']);
    Route::get('/admin/dashboard/allDoctor/', [AdminController::class, 'showDoctor'])->name('admin.allDoctor');
    Route::post('/admin/dashboard/allDoctor/', [AdminController::class, 'showDetailDoctor'])->name('admin.allDoctorPost');

    Route::get('/admin/dashboard/addDoctor/', [AdminController::class, 'createDoctor'])->name('admin.createDoctor');
    Route::post('/admin/dashboard/addDoctor', [AdminController::class, 'storeDoctor'])->name('admin.storeDoctor');
    Route::get('/admin/dashboard/showAllDoctorCategory/', [AdminController::class, 'showAllDoctorCategory'])->name('admin.showDoctorByCategory');
    Route::get('/admin/dashboard/fetchAllDoctorCategory/', [AdminController::class, 'fetchAllDoctorCategory']);
    Route::post('/admin/dashboard/showDoctorByCategory/', [AdminController::class, 'getDoctorByCategory'])->name('admin.getDoctorByCategory');
    Route::get('/admin/dashboard/showDoctorBySearch/', [AdminController::class, 'showDoctorBySearch'])->name('admin.showDoctorBySearch');
    Route::post('/admin/dashboard/showDoctorBySearch/reject-doctor/{doctor:user_name}', [AdminController::class, 'destroyRejectDoctor2']);

    Route::get('/admin/dashboard/addPatient/', [AdminController::class, 'createPatient'])->name('admin.createPatient');
    Route::post('/admin/dashboard/addPatient/', [AdminController::class, 'storePatient'])->name('admin.storePatient');
    Route::get('/admin/dashboard/showPatientBySearch/', [AdminController::class, 'showPatientBySearch'])->name('admin.showPatientBySearch');
    Route::post('/admin/dashboard/reject-patient/{patient}', [AdminController::class, 'destroyRejectPatient']);
    Route::get('/admin/dashboard/comment', [AdminController::class, 'showComment'])->name("admin.commentPage");
    Route::post('/admin/dashboard/comment', [AdminController::class, 'showDetailTmpComment']);
    Route::post('/admin/dashboard/approve-comment/{tmpComment:id}/{patient:full_name}', [AdminController::class, 'storeApproveComment']);
    Route::post('/admin/dashboard/reject-comment/{tmpComment:id}/{patient:full_name}', [AdminController::class, 'destroyRejectComment']);
});
