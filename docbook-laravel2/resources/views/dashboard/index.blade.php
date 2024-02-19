@extends('layouts.dashboardMain')
@section('container')
<!-- <h1>brobeo beo</h1> -->
<div class="dashboard-main homeDashboard" style="margin-left:260px">
    {{-- <div class="dashboardFlexContainer"> --}}
        {{-- <div class="flexHomeDashboard1"> --}}
            <h1 class="my-5 text-center font-monospace fw-bolder">Welcome Doctor {{ $doctor['user_name']}}
            </h1>
            @if(session()->has('success'))
            <div class="alert alert-success alert-dismissible fade show col-10 col-md-6 col-lg-4 mx-auto" role="alert">
                <i class="fa-sharp fa-solid fa-square-check me-1"></i>
                {{ session('success') }}
                <button type="button" class="btn-close align-middle" data-bs-dismiss="alert"
                    aria-label="Close"></button>
            </div>
            @endif
            <div class="d-flex allTable align-content-center justify-content-center">

                <div class="d-flex flex-column requestCancelContainer">
                    <div class="shadow indexDashboard rounded-4 col-11 col-sm-11 col-md-11 col-lg-11 px-4 mb-5">
                        @if (count($requestedAppointmentAll) > 2)
                        <h5 class="ms-3 my-2">Appointment Request</h5>
                        <table class="table table-borderless requestTable">
                            <thead>
                                <tr>
                                    <th scope="col" class="text-center">id</th>
                                    <th scope="col" class="text-center">Name</th>
                                    <th scope="col" class="text-center">details</th>
                                    <th scope="col" class="text-center">Mobile No.</th>
                                    <th scope="col" class="text-center">Date</th>
                                    <th scope="col" class="text-center">Time</th>
                                    <th scope="col" class="text-center">Disease</th>
                                    <th scope="col" class="text-center">Action</th>
                                </tr>
                            </thead>
                            @foreach ($requestedAppointment as $appointment)
                            <tr class=" shadow-sm rounded-5">
                                <th scope="row" class="align-middle">{{ $loop->iteration }}</th>
                                <td class="align-middle text-center">{{$appointment->full_name }}</td>
                                <td class="align-middle text-center">
                                    <form action="/dashboard" method="post">
                                        @csrf
                                        <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal"
                                            class="bg-transparent border border-0 displayDetailsRequest"
                                            data-id='{{ $appointment->id }}'><i
                                                class="fa-sharp fa-solid fa-circle-info"></i>
                                        </button>
                                    </form>
                                </td>
                                <td class="align-middle text-center">{{ $appointment->patient_phone_no }}</td>
                                <td class="align-middle text-center">{{ date('d/m/Y',
                                    strtotime($appointment->date)) }}</td>
                                <td class="align-middle text-center">{{ $appointment->time }}</td>
                                <td class="align-middle text-center">{{ $appointment->disease }}</td>
                                <td class="align-middle text-center">
                                    <a class="myBtn"
                                        href="/dashboard/patients/{{ $appointment->patient_user_name }}/appointments/{{ $appointment->id }}/edit"
                                        class=""><i class=" fa-sharp fa-regular fa-pen-to-square"></i></a>
                                </td>
                            </tr>
                            @endforeach
                            {{--
                            </tbody> --}}
                        </table>
                        <h4 class="text-end"><a href="/dashboard/appointment-request">see more</a></h4>


                        @elseif(count($requestedAppointmentAll) == 2 || count($requestedAppointmentAll) == 1 )
                        <h5 class="ms-3 my-2">Appointment Request</h5>
                        <table class="table table-borderless">
                            <thead>
                                <tr>
                                    <th scope="col" class="text-center">id</th>
                                    <th scope="col" class="text-center">Name</th>
                                    <th scope="col" class="text-center">details</th>
                                    <th scope="col" class="text-center">Mobile No</th>
                                    <th scope="col" class="text-center">Date</th>
                                    <th scope="col" class="text-center">Action</th>
                                </tr>
                            </thead>
                            @foreach ($requestedAppointment as $appointment)
                            <tr class="shadow-sm rounded-5">
                                <td class="align-middle">
                                    {{ $loop->iteration }}
                                </td>
                                <td class="align-middle">
                                    {{$appointment->full_name }}
                                </td>
                                <td class="align-middle text-center">
                                    <form action="/dashboard" method="post">
                                        @csrf
                                        <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal"
                                            class="bg-transparent border border-0 displayDetailsRequest"
                                            data-id='{{ $appointment->id }}'><i
                                                class="fa-sharp fa-solid fa-circle-info"></i>
                                        </button>
                                    </form>
                                </td>
                                <td class="align-middle text-center">
                                    {{ $appointment->patient_phone_no }}
                                </td>
                                <td class="align-middle text-center">
                                    {{ date('d/m/Y', strtotime($appointment->date)) }}
                                </td>
                                <td class="align-middle text-center">
                                    <a class="myBtn"
                                        href="/dashboard/patients/{{ $appointment->patient_user_name }}/appointments/{{ $appointment->id }}/edit"
                                        class=""><i class=" fa-sharp fa-regular fa-pen-to-square"></i></a>
                                </td>
                            </tr>
                            {{-- endfor --}}
                            @endforeach
                        </table>

                        @elseif(count($requestedAppointmentAll) < 1) <h5 class="ms-3 my-2">Don't Have
                            Appointment Request </h5>
                            @endif
                    </div>


                    {{-- cancelled table --}}
                    <div class="shadow indexDashboard rounded-4 col-11 col-sm-11 col-md-11 col-lg-11 px-4 pb-1 mb-4">
                        {{-- if (sizeof($data['patientCancel']) > 1) { ?> --}}
                        @if (count($cancelledAppointmentAll) > 2)
                        <h5 class="ms-3 my-2">Cancelled Appointment</h5>
                        <table class="table table-borderless cancelTable ">
                            <thead>
                                <tr>
                                    <th scope="col" class="text-center">id</th>
                                    <th scope="col" class="text-center">Name</th>
                                    <th scope="col" class="text-center">details</th>
                                    <th scope="col" class="text-center">Mobile No</th>
                                    <th scope="col" class="text-center">Date</th>
                                    <th scope="col" class="text-center">time</th>
                                    <th scope="col" class="text-center">disease</th>
                                    <th scope="col" class="text-center">status</th>
                                    <th scope="col" class="text-center">action</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($cancelledAppointment as $appointment)
                                <tr class="shadow-sm rounded-5">
                                    <td class="align-middle">
                                        {{ $loop->iteration }}
                                    </td>
                                    <td class="align-middle text-center">
                                        {{$appointment->full_name }}
                                    </td>
                                    <td class="align-middle text-center">
                                        <form action="/dashboard" method="post">
                                            @csrf
                                            <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal2"
                                                class="bg-transparent border border-0 displayDetailsCancel"
                                                data-id='{{ $appointment->id }}'><i
                                                    class="fa-sharp fa-solid fa-circle-info"></i>
                                            </button>
                                        </form>
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->patient_phone_no }}
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ date('d/m/Y', strtotime($appointment->date)) }}
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->time }}
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->disease }}
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->status }}
                                    </td>
                                    <td class="align-middle text-center">
                                        <a href=" /dashboard/patients/{{ $appointment->patient_user_name
                                        }}/appointments/{{$appointment->id}}/edit">
                                            <i class="fa-sharp fa-regular fa-pen-to-square"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                            </tbody>
                        </table>
                        <h4 class="text-end"><a href="dashboard/appointment-cancel">see more</a></h4>
                        @elseif(count($cancelledAppointmentAll) == 2 || count($cancelledAppointmentAll) ==
                        1)
                        <h5 class="ms-3 my-2">Cancelled Appointment</h5>
                        <table class="table table-borderless">
                            <thead>
                                <tr>
                                    <th scope="col" class="text-center">id</th>
                                    <th scope="col" class="text-center">Name</th>
                                    <th scope="col" class="text-center">details</th>
                                    <th scope="col" class="text-center">Mobile No</th>
                                    <th scope="col" class="text-center">Date</th>
                                    <th scope="col" class="text-center">Action</th>
                                    <th scope="col" class="text-center">edit</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach($cancelledAppointment as $appointment)
                                <tr class="shadow-sm rounded-5">
                                    <td class="align-middle">
                                        {{ $loop->iteration }}
                                    </td>
                                    <td class="align-middle">
                                        {{$appointment->full_name }}
                                    </td>
                                    <td class="align-middle text-center">
                                        <form action="/dashboard" method="post">
                                            @csrf
                                            <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal2"
                                                class="bg-transparent border border-0 displayDetailsCancel"
                                                data-id='{{ $appointment->id }}'><i
                                                    class="fa-sharp fa-solid fa-circle-info"></i>
                                            </button>
                                        </form>
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->patient_phone_no }}
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ date('d/m/Y', strtotime($appointment->date)) }}
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->status }}
                                    </td>
                                    <td class="align-middle text-center">
                                    <td class="align-middle text-center">
                                        <a href=" /dashboard/patients/{{ $appointment->patient_user_name
                                            }}/appointments/{{$appointment->id}}/edit">
                                            <i class="fa-sharp fa-regular fa-pen-to-square"></i>
                                        </a>
                                    </td>
                                    </td>
                                </tr>
                                {{-- endfor --}}
                                @endforeach
                            </tbody>
                        </table>
                        @elseif(count($cancelledAppointmentAll) < 1) <h5 class="ms-3 my-2">Don't Have
                            Cancelled
                            Appointment
                            </h5>
                            @endif

                    </div>

                    {{--
                </div> --}}
            </div>




            <!-- today table -->
            <div class="d-flex align-items-center todayTableContainer">
                <div class="shadow indexDashboard rounded-4 col-11 col-sm-11 col-md-11 col-lg-11 px-4 mt-4">
                    {{-- if (sizeof($data['todayPatient']) > 1) { ?> --}}
                    {{-- for ($i = 0; $i < 2; $i++) : ?> --}}
                        @if (count($todayAppointmentAll) > 2)
                        <h5 class="ms-3 my-2">Today Appointment</h5>
                        <table class="table table-borderless todayTable">
                            <thead>
                                <tr>
                                    <th scope="col" class="text-center">id</th>
                                    <th scope="col" class="text-center">Name</th>
                                    <th scope="col" class="text-center">detail</th>
                                    <th scope="col" class="text-center">Mobile No</th>
                                    <th scope="col" class="text-center">Time</th>
                                    <th scope="col" class="text-center">Disease</th>
                                    <th scope="col" class="text-center">edit</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($todayAppointment as $appointment)
                                <tr class="shadow-sm rounded-5">
                                    <td class="align-middle">
                                        {{ $loop->iteration }}
                                    </td>
                                    <td class="align-middle">
                                        {{$appointment->full_name }}
                                    </td>
                                    <td class="align-middle text-center">
                                        <form action="/dashboard" method="post">
                                            @csrf
                                            <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal3"
                                                class="bg-transparent border border-0 displayDetailsToday"
                                                data-id='{{ $appointment->id }}'><i
                                                    class="fa-sharp fa-solid fa-circle-info"></i>
                                            </button>
                                        </form>
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->patient_phone_no }}
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->time }}
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->disease }}
                                    </td>
                                    <td class="align-middle text-center">
                                        <a
                                            href="/dashboard/patients/{{ $appointment->patient_user_name }}/appointments/{{ $appointment->id }}/edit">
                                            <i class="fa-sharp fa-regular fa-pen-to-square"></i>
                                        </a>
                                    </td>
                                </tr>
                                {{-- endfor --}}
                                @endforeach
                            </tbody>
                        </table>
                        <h4 class="text-end"><a href="/dashboard/appointment-today">see more</a></h4>
                        @elseif(count($todayAppointmentAll) == 2 || count($todayAppointmentAll) == 1)
                        <h5 class="ms-3 my-2">Today Appointment</h5>
                        <table class="table table-borderless">
                            <thead>
                                <tr>
                                    <th scope="col" class="text-center">id</th>
                                    <th scope="col" class="text-center">Name</th>
                                    <th scope="col" class="text-center">detail</th>
                                    <th scope="col" class="text-center">Mobile No</th>
                                    <th scope="col" class="text-center">Time</th>
                                    <th scope="col" class="text-center">Disease</th>
                                    <th scope="col" class="text-center">edit</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($todayAppointment as $appointment)
                                <tr class="shadow-sm rounded-5">
                                    <td class="align-middle">
                                        {{ $loop->iteration }}
                                    </td>
                                    <td class="align-middle">
                                        {{$appointment->full_name }}
                                    </td>
                                    <td class="align-middle text-center">
                                        <form action="/dashboard" method="post">
                                            @csrf
                                            <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal"
                                                class="bg-transparent border border-0 displayDetailsToday"
                                                data-id='{{ $appointment->id }}'><i
                                                    class="fa-sharp fa-solid fa-circle-info"></i>
                                            </button>
                                        </form>
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->patient_phone_no }}
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->time }}
                                    </td>
                                    <td class="align-middle text-center">
                                        {{ $appointment->disease }}
                                    </td>
                                    <td class="align-middle text-center">
                                        <a
                                            href="/dashboard/appointment-approve/{{ $appointment->patient_user_name }}/appointments/{{ $appointment->id }}/edit">
                                            <i class="fa-sharp fa-regular fa-pen-to-square"></i>
                                        </a>
                                    </td>
                                </tr>
                                {{-- endfor --}}
                                @endforeach
                            </tbody>
                        </table>
                        @elseif(count($todayAppointmentAll) < 1) <h5 class="ms-3 my-2">Don't Have Appointment
                            Today</h5>
                            @endif
                            {{-- } ?> --}}
                </div>
            </div>


            {{-- request modal --}}
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content d-flex flex-row bg-transparent">
                        <div style="backdrop-filter: blur(10px);background: rgba(134, 148, 222,0.3);  box-shadow: inset 0 0 0 200px rgba(255,255,255,0.2); border-radius: 8px;
" class="d-flex justify-self-center flex-column border border-0 col-sm-12 col-12">
                            <div class=" border-dark-subtle border-2 border-bottom mx-2 d-flex
justify-content-between" style="height: 30px;">
                                <h1 class=" fs-6 mt-1" id="exampleModalLabel">Information</h1>
                                <button type="button" class="btn-close mt-2" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body patient-modal-body ms-2 mt-2">
                                <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                    id="exampleModalLabel">
                                    Mobile No</h1>
                                <p id="mobile_no" class="justify-content-center d-flex fw-bolder text-body"></p>
                                <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                    id="exampleModalLabel">
                                    Date | Time
                                </h1>
                                <p id="date" class="justify-content-center d-flex fw-bolder text-body">
                                </p>
                                <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                    id="exampleModalLabel">
                                    Disease
                                </h1>
                                <p id="disease" class="justify-content-center d-flex fw-bolder text-body">
                                </p>
                            </div>
                            <div class="modal-footer border-dark-subtle border-2 mx-2">
                                <button type="button" class="btn btn-danger btn-sm"
                                    data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {{-- cancel modal --}}
            <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content d-flex flex-row bg-transparent">
                        <div style="backdrop-filter: blur(10px);background: rgba(134, 148, 222,0.3);  box-shadow: inset 0 0 0 200px rgba(255,255,255,0.2); border-radius: 8px;
" class="d-flex justify-self-center flex-column border border-0 col-sm-12 col-12">
                            <div class=" border-dark-subtle border-2 border-bottom mx-2 d-flex
justify-content-between" style="height: 30px;">
                                <h1 class=" fs-6 mt-1" id="exampleModalLabel">Information</h1>
                                <button type="button" class="btn-close mt-2" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body patient-modal-body ms-2 mt-2">
                                <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                    id="exampleModalLabel">
                                    Mobile No</h1>
                                <p id="mobile_no" class="justify-content-center d-flex fw-bolder text-body"></p>
                                <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                    id="exampleModalLabel">
                                    Date | Time
                                </h1>
                                <p id="date" class="justify-content-center d-flex fw-bolder text-body">
                                </p>
                                <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                    id="exampleModalLabel">
                                    Disease
                                </h1>
                                <p id="disease" class="justify-content-center d-flex fw-bolder text-body">
                            </div>
                            <div class="modal-footer border-dark-subtle border-2 mx-2">
                                <button type="button" class="btn btn-danger btn-sm"
                                    data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {{-- today modal --}}
            <div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content d-flex flex-row bg-transparent">
                        <div style="backdrop-filter: blur(10px);background: rgba(134, 148, 222,0.3);  box-shadow: inset 0 0 0 200px rgba(255,255,255,0.2); border-radius: 8px;
" class="d-flex justify-self-center flex-column border border-0 col-sm-12 col-12">
                            <div class=" border-dark-subtle border-2 border-bottom mx-2 d-flex
justify-content-between" style="height: 30px;">
                                <h1 class=" fs-6 mt-1" id="exampleModalLabel">Information</h1>
                                <button type="button" class="btn-close mt-2" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body patient-modal-body ms-2 mt-2">
                                <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                    id="exampleModalLabel">
                                    Mobile No</h1>
                                <p id="mobile_no" class="justify-content-center d-flex fw-bolder text-body"></p>
                                <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                    id="exampleModalLabel">
                                    Date | Time
                                </h1>
                                <p id="date" class="justify-content-center d-flex fw-bolder text-body">
                                </p>
                                <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                    id="exampleModalLabel">
                                    Disease
                                </h1>
                                <p id="disease" class="justify-content-center d-flex fw-bolder text-body">
                                <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                    id="exampleModalLabel">
                                    Approval
                                </h1>
                                <p id="approval" class="justify-content-center d-flex fw-bolder text-body">
                                </p>
                            </div>
                            <div class="modal-footer border-dark-subtle border-2 mx-2">
                                <button type="button" class="btn btn-danger btn-sm"
                                    data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>







            {{--
        </div> --}}
        {{-- @dd($todayAppointmentAll['time']) --}}
        @endsection
        @section('jsAjax')
        <script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
        @endsection
        <!-- Trigger/Open The Modal -->
        <!-- <button id="myBtn">Open Modal</button> -->

        {{-- 775px max width --}}