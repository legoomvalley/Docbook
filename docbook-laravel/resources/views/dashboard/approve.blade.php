@extends('layouts.dashboardMain')
@section('container')
<!-- <h1>brobeo beo</h1> -->
<div class="dashboard-main homeDashboard requestDashboardContainer" style="margin-left:260px">
    @if(session()->has('success'))
    <div class="alert alert-success alert-dismissible fade show ol-10 col-md-6 col-lg-4 mx-auto" role="alert">
        <i class="fa-sharp fa-solid fa-square-check me-1"></i>
        {{ session('success') }}
        <button type="button" class="btn-close align-middle" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    @endif
    <div class="dashboardHistoryTableContainer dashboardHistoryTableContainer1">
        <div
            class="shadow indexDashboard rounded-4 col-11 col-sm-11 col-md-11 col-lg-11 px-4 mb-2 mx-auto approveTablePageContainer">
            <h5>Approved Appointment</h5>
            <table class="table table-borderless approveTablePage">
                <tr>
                    <th scope="col" class="text-center">id</th>
                    <!-- <th scope="col" class="text-center">Patient id</th> -->
                    <th scope="col" class="text-center">Name</th>
                    <th scope="col" class="text-center">Details</th>
                    <th scope="col" class="text-center">Mobile No</th>
                    <th scope="col" class="text-center">Date</th>
                    <th scope="col" class="text-center">Diseases</th>
                    <th scope="col" class="text-center">Time</th>
                    <th scope="col" class="text-center">Approval</th>
                    <th scope="col" class="text-center">Edit</th>
                </tr>
                @foreach ($doctorAppointments as $appointment)

                <tr class="shadow-sm rounded-5">
                    <td class="align-middle text-center">
                        {{ ($doctorAppointments ->currentpage()-1) * $doctorAppointments ->perpage() + $loop->index +
                        1}}
                    </td>
                    <td class="align-middle">
                        {{$appointment->patient->full_name }}
                    </td>
                    <td class="align-middle text-center">
                        <form action="/dashboard" method="post">
                            @csrf
                            <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal2"
                                class="bg-transparent border border-0 displayDetailsCancel"
                                data-id='{{ $appointment->id }}'><i class="fa-sharp fa-solid fa-circle-info"></i>
                            </button>
                        </form>
                    </td>
                    <td class="align-middle text-center">
                        {{$appointment->patient->phone_no }}
                    </td>
                    <td class="align-middle text-center">
                        {{date('d/m/Y', strtotime($appointment->date)) }}
                    </td>
                    <td class="align-middle text-center">
                        {{$appointment->disease }}
                    </td>
                    <td class="align-middle text-center">
                        {{$appointment->time}}
                    </td>
                    <td class="align-middle text-center">
                        {{$appointment->status }}
                    </td>
                    <td class="align-middle text-center">
                        <a
                            href="/dashboard/appointment-approve/{{ $appointment->patient->user_name }}/{{ $appointment->id }}/edit">
                            <i class="fa-sharp fa-regular fa-pen-to-square"></i>
                        </a>
                        {{-- <a class="myBtn"
                            href="/dashboard/appointment-request/{{ $appointment->patient->user_name }}/{{ $appointment->id }}/action"
                            class="fas fa-times-circle requestIcon" style="color: red;"><i
                                class="fa-solid fa-circle-xmark"></i></a>
                        <a class="myBtn2"
                            href="/dashboard/appointment-request/{{ $appointment->patient->user_name }}/{{ $appointment->id }}/action"
                            class="fas fa-check-circle requestIcon" style=" color:green;"><i
                                class="fa-solid fa-circle-check"></i></a> --}}
                    </td>
                </tr>
                @endforeach
            </table>

        </div>
        <div class=" shadow-none d-flex justify-content-end justify-items-start justify-self-center col-sm-11 mx-auto">

            {{ $doctorAppointments->links() }}
        </div>
    </div>



</div>
@endsection