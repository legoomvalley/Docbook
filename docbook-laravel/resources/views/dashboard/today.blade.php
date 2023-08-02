@extends('layouts.dashboardMain')
@section('container')
<!-- <h1>brobeo beo</h1> -->
<div class="dashboard-main homeDashboard requestDashboardContainer" style="margin-left:260px">
    <div class="dashboardHistoryTableContainer justify-content-center">
        <div
            class="shadow indexDashboard rounded-4 col-11 col-sm-11 col-md-11 col-lg-11 px-4 mb-4 todayTablePageContainer">
            @if (count($doctorAppointments) < 1) <h5 class="my-3 me-5" style="width: 100%">You Don't Have Appointment
                Today</h5>

                @else
                <h5>Today Appointment</h5>
                <table class="table table-borderless todayTablePage">
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
                            {{ ($doctorAppointments ->currentpage()-1) * $doctorAppointments ->perpage() + $loop->index
                            +
                            1}}
                        </td>
                        <td class="align-middle">
                            {{$appointment->patient->full_name }}
                        </td>
                        <td class="align-middle text-center">
                            <form action="/dashboard" method="post">
                                @csrf
                                <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal3"
                                    class="bg-transparent border border-0 displayDetailsToday"
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
                            {{$appointment->status}}
                        </td>
                        <td class="align-middle text-center">
                            <i class="fa-sharp fa-regular fa-pen-to-square"></i>
                        </td>
                    </tr>
                    @endforeach
                </table>
                @endif

        </div>
        <div class=" shadow-none d-flex justify-content-end justify-items-start justify-self-center col-sm-11 mx-auto">
            {{ $doctorAppointments->links() }}
        </div>
    </div>



</div>
<div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content d-flex flex-row bg-transparent">
            <div style="backdrop-filter: blur(10px);background: rgba(134, 148, 222,0.3);  box-shadow: inset 0 0 0 200px rgba(255,255,255,0.2); border-radius: 8px;
" class="d-flex justify-self-center flex-column border border-0 col-sm-12 col-12">
                <div class=" border-dark-subtle border-2 border-bottom mx-2 d-flex
justify-content-between" style="height: 30px;">
                    <h1 class=" fs-6 mt-1" id="exampleModalLabel">Information</h1>
                    <button type="button" class="btn-close mt-2" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body patient-modal-body ms-2 mt-2">
                    <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                        Mobile No</h1>
                    <p id="mobile_no" class="justify-content-center d-flex fw-bolder text-body"></p>
                    <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                        Time
                    </h1>
                    <p id="date" class="justify-content-center d-flex fw-bolder text-body">
                    </p>
                    <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                        Disease
                    </h1>
                    <p id="disease" class="justify-content-center d-flex fw-bolder text-body">
                </div>
                <div class="modal-footer border-dark-subtle border-2 mx-2">
                    <button type="button" class="btn btn-danger btn-sm" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
@section('jsAjax')
<script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
@endsection