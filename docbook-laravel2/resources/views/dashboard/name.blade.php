@extends('layouts.dashboardMain')
@section('container')
<div class="dashboard-main homeDashboard requestDashboardContainer" style="margin-left:260px">
    <div class="d-flex justify-content-center">
        <div class="col-10 col-sm-8 col-md-6 mx-auto">
            <div class="">search by name</div>
            <form action="/dashboard/appointment-search-by-name">
                <div class="input-group input-group-sm mb-3">
                    <input type="text" class="form-control" placeholder="patient's name" value="{{ request('search') }}"
                        name="search">
                    <button type="submit" class="input-group-text btn btn-primary" id="basic-addon2">check</button>
                </div>
            </form>
        </div>
    </div>
    <div class="dashboardHistoryTableContainer mt-2 mx-auto">
        <div
            class="shadow indexDashboard rounded-4 col-12 col-sm-12 col-md-12 col-lg-12 px-2 mb-4 mx-auto nameTablePageContainer overflow-x-hidden">
            {{-- @if ($patient->count() && null !== (request('search'))) --}}
            @if ($patient->count() && null !== (request('search')))
            <h5 class="fw-normal">Result for <span class="fst-italic">"{{ request('search') }}"</span> keyword</h5>
            <table class="table table-borderless nameTablePage">
                <tr>
                    <th scope="col" class="text-center">id</th>
                    <!-- <th scope="col" class="text-center">Patient id</th> -->
                    <th scope="col" class="text-center">Name</th>
                    <th scope="col" class="text-center">Details</th>
                    <th scope="col" class="text-center">Mobile No</th>
                    <th scope="col" class="text-center">Date</th>
                    <th scope="col" class="text-center">Diseases</th>
                    <th scope="col" class="text-center">Time</th>
                    <th scope="col" class="text-center">Email</th>
                </tr>
                {{-- @dd($doctor->appointments) --}}
                @foreach ($patient as $p)

                <tr class="shadow-sm rounded-5">
                    <td class="align-middle text-center">
                        {{ $loop->iteration}}
                    </td>
                    <td class="align-middle text-center">
                        {{-- {{$p->patient->full_name }} --}}
                        {{$p->full_name }}
                    </td>
                    <td class="align-middle text-center">
                        <form action="/dashboard" method="post">
                            @csrf
                            <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal"
                                class="bg-transparent border border-0 displayDetailsName" data-id='{{ $p->id }}'><i
                                    class="fa-sharp fa-solid fa-circle-info"></i>
                            </button>
                        </form>
                    </td>
                    <td class="align-middle text-center">
                        {{$p->phone_no }}
                    </td>
                    <td class="align-middle text-center">
                        {{date('d/m/Y', strtotime($p->date)) }}
                    </td>
                    <td class="align-middle text-center">
                        {{ $p->disease }}
                    </td>
                    <td class="align-middle text-center">
                        {{ $p->time}}
                    </td>
                    <td class="align-middle text-center">
                        {{ $p->email}}
                    </td>
                </tr>
                @endforeach
            </table>
            @elseif( null === (request('search')))
            <h5 class="fs-6">Search Patient Here</h5>
            <table class="table table-borderless nameTablePage" style="width: 65vw;max-width:550px">
                <tr>
                    <th>id</th>
                    <!-- <th>Patient id</th> -->
                    <th>Name</th>
                    <th>Mobile No</th>
                    <th>Date</th>
                    <th>Diseases</th>
                    <th>Time</th>
                    <th>Email</th>
                </tr>
                {{-- @dd($doctor->appointments) --}}
            </table>
            @elseif($patient->count() < 1 && null !==(request('search'))) <h5>No Patient Found</h5>
                <table class="table table-borderless nameTablePage" style="width: 65vw;max-width:550px">
                    <tr>
                        <th>id</th>
                        <!-- <th>Patient id</th> -->
                        <th>Name</th>
                        <th>Mobile No</th>
                        <th>Date</th>
                        <th>Diseases</th>
                        <th>Time</th>
                        <th>Email</th>
                    </tr>
                    {{-- @dd($doctor->appointments) --}}
                </table>
                @endif
        </div>
    </div>


    {{-- name modal --}}
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content d-flex flex-row bg-transparent">
                <div style="backdrop-filter: blur(10px);background: rgba(134, 148, 222,0.3);   border-radius: 8px;"
                    class="d-flex justify-self-center shadow-sm flex-column border border-0 col-sm-12 col-12">
                    <div class=" border-dark-subtle border-2 border-bottom mx-2 d-flex
justify-content-between" style="height: 30px;">
                        <h1 class=" fs-6 mt-1" id="exampleModalLabel">Information</h1>
                        <button type="button" class="btn-close mt-2" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>
                    <div class="modal-body patient-modal-body ms-2 mt-2">
                        <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                            Mobile No</h1>
                        <p id="mobile_no" class="justify-content-center d-flex fw-bolder text-body"></p>
                        <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                            Disease
                        </h1>
                        <p id="disease" class="justify-content-center d-flex fw-bolder text-body">
                        <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                            Date | Time
                        </h1>
                        <p id="date" class="justify-content-center d-flex fw-bolder text-body bg-transparent">
                        </p>
                        <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                            Email
                        </h1>
                        <p id="email" class="justify-content-center d-flex fw-bolder text-body">
                        </p>
                        <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                            Approval
                        </h1>
                        <p id="status" class="justify-content-center d-flex fw-bolder text-body">
                        </p>
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

    {{-- id Name Details Mobile No Diseases Time Email --}}