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
    Route::get('/doctor-profile/{doctor:user_name}', [DoctorController::class, 'showProfile']);
    Route::get('/review/{doctor:user_name}', [DoctorController::class, 'showReview']);
    Route::post('/review/{doctor:user_name}', [DoctorController::class, 'comment']);
    Route::post('doctor-profile/{doctor:user_name}/', [AppointmentController::class, 'storeByDoctor']);
    Route::post('/', [LoginController::class, 'authenticatePatient']);
    Route::post('/patient/{patient:user_name}', [LoginController::class, 'logoutPatient']);
});

Route::get('/doctors', [DoctorController::class, 'index']);
Route::post('/doctors/specialization', [DoctorController::class, 'getBySpecialization']);
Route::get('/doctors?specialization={specialization}', [DoctorController::class, 'getBySpecialization'])->name('specialization');
Route::get('/doctors/login', [LoginController::class, 'doctorLogin'])->middleware('guest:doctor')->name('login');
Route::post('/doctors/login', [LoginController::class, 'authenticateDoctor']);
Route::get('/doctors/register', [RegisterController::class, 'createDoctor'])->middleware('guest:doctor');
Route::post('/doctors/register', [RegisterController::class, 'storeDoctor']);
Route::post('/doctors/logout', [LoginController::class, 'logoutDoctor']);



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


    // start from here
    Route::get('/dashboard/patients/{patient:user_name}/appointments/{appointment}/edit', [AppointmentController::class, 'editActionAppointment']);
    Route::post('/dashboard/patients/{patient:user_name}/appointments/{appointment}/', [AppointmentController::class, 'updateActionAppointment']);

    Route::delete('/appointment-cancel/{appointment}', [AppointmentController::class, 'deleteAppointmentApprove']);
});

Route::middleware('patient-access:patient')->group(function () {

    Route::get('/patient-record/{patient:user_name}', [PatientController::class, 'index']);
    Route::post('/patient-record', [PatientController::class, 'showDetails']);
    Route::delete('/appointment/{appointment:id}', [PatientController::class, 'deleteAppointment']);
    Route::put('/appointment/{appointment:id}', [PatientController::class, 'updateAppointmentToComplete']);
    Route::post('appointment', [AppointmentController::class, 'store']);
});

Route::get('/admin', [AdminController::class, 'index']);
Route::post('/admin', [LoginController::class, 'authenticateAdmin']);
Route::post('/admin-logout', [LoginController::class, 'logoutAdmin']);

Route::middleware('admin-access:admin')->group(function () {
    Route::get('/admin/dashboard', [AdminController::class, 'showDashboard']);
    Route::post('/admin/dashboard', [AdminController::class, 'showDetailTmpDoctor']);
    Route::post('/admin/dashboard/approve-doctor/doctor/{tmpDoctor}', [AdminController::class, 'storeApproveDoctor']);
    Route::post('/admin/dashboard/reject-doctor/doctor/{tmpDoctor}', [AdminController::class, 'destroyRejectDoctor']);

    Route::get('/admin/dashboard/doctors/', [AdminController::class, 'showDoctor'])->name('admin.allDoctor');
    Route::post('/admin/dashboard/doctors/', [AdminController::class, 'showDetailDoctor'])->name('admin.allDoctorPost');

    Route::get('/admin/dashboard/doctor/create', [AdminController::class, 'createDoctor'])->name('admin.createDoctor');
    Route::post('/admin/dashboard/doctor', [AdminController::class, 'storeDoctor'])->name('admin.storeDoctor');
    Route::get('/admin/dashboard/doctors/category', [AdminController::class, 'showAllDoctorCategory'])->name('admin.showAllDoctor');
    Route::get('/admin/dashboard/fetchAllDoctorCategory/', [AdminController::class, 'fetchAllDoctorCategory']); //ajax
    Route::post('/admin/dashboard/showDoctorByCategory', [AdminController::class, 'getDoctorByCategory'])->name('admin.getDoctorByCategory');
    Route::get('/admin/dashboard/search-doctor/', [AdminController::class, 'showDoctorBySearch'])->name('admin.showDoctorBySearch');
    Route::post('/admin/dashboard/search-doctor/doctor/{doctor:user_name}', [AdminController::class, 'destroyRejectDoctor2']);

    Route::get('/admin/dashboard/search-patient/', [AdminController::class, 'showPatientBySearch'])->name('admin.showPatientBySearch');
    Route::delete('/admin/dashboard/patient/{patient}', [AdminController::class, 'destroyRejectPatient']);
    Route::get('/admin/dashboard/comment', [AdminController::class, 'showComment'])->name("admin.commentPage");
    Route::post('/admin/dashboard/comment', [AdminController::class, 'showDetailTmpComment']);
    Route::post('/admin/dashboard/approve-comment/{tmpComment:id}/{patient:full_name}', [AdminController::class, 'storeApproveComment']);
    Route::post('/admin/dashboard/reject-comment/{tmpComment:id}/{patient:full_name}', [AdminController::class, 'destroyRejectComment']);
});
