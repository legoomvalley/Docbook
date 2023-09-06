@extends('layouts.dashboardMain')
@section('container')
<div class="dashboard-main homeDashboard requestDashboardContainer" style="margin-left:260px">
    <div class=" d-flex justify-content-center">
        <div class="col-9 col-sm-6 col-md-4">
            <div class="d-block mt-3">search by date</div>
            <form action="/dashboard/appointment-search-by-date">
                <div class="input-group input-group-sm mb-2">
                    <input type="text" class="form-control" placeholder="from date" value="{{ request('search1') }}"
                        name="search1" id="datePickerDashboard1" required>
                </div>
                <div class="input-group input-group-sm">
                    <input type="text" class="form-control" placeholder="to date" value="{{ request('search2') }}"
                        name="search2" id="datePickerDashboard2" required>
                </div>
                <button type="submit"
                    class="w-100 input-group-text mb-4 mt-1 d-flex justify-content-center btn btn-primary btn-sm"
                    id="basic-addon2">check</button>
            </form>
        </div>
    </div>
    <div class="dashboardHistoryTableContainer mt-2 mx-auto">
        <div
            class="shadow indexDashboard rounded-4 col-11 col-sm-11 col-md-11 col-lg-11 px-2 mb-4 mx-auto dateTablePageContainer overflow-x-hidden">

            {{-- @if ($patient->count() && null !== (request('search1'))) --}}
            @if ($patient->count() && null !== request('search1') && null !== request('search2'))
            <h5 class="fs-6">Result between <span class="fst-italic fw-normal">{{ request('search1') }}</span>
                and
                <span class="fst-italic fw-normal">{{ request('search2') }}</span>
            </h5>
            <table class="table table-borderless dateTablePage">
                <tr>
                    <th scope="col" class="text-center">id</th>
                    <!-- <th scope="col" class="text-center">Patient id</th> -->
                    <th scope="col" class="text-center">Name</th>
                    <th scope="col" class="text-center">details</th>
                    <th scope="col" class="text-center">Mobile No</th>
                    <th scope="col" class="text-center">Date</th>
                    <th scope="col" class="text-center">Time</th>
                    <th scope="col" class="text-center">Email</th>
                </tr>
                {{-- @dd($doctor->appointments) --}}
                @foreach ($patient as $p)

                <tr class="shadow-sm rounded-5">
                    <td class="align-middle text-center">
                        {{ $loop->iteration}}
                    </td>
                    <td class="align-middle ">
                        {{-- {{$p->patient->full_name }} --}}
                        {{$p->full_name }}
                    </td>
                    <td class="align-middle text-center">
                        <form action="/dashboard" method="post">
                            @csrf
                            <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal"
                                class="bg-transparent border border-0 displayDetailsDate" data-id='{{ $p->id }}'><i
                                    class="fa-sharp fa-solid fa-circle-info"></i>
                            </button>
                        </form>
                    </td>
                    <td class="align-middle text-center">
                        {{-- {{$p->patient->phone_no }} --}}
                        {{$p->patient->phone_no }}
                    </td>
                    <td class="align-middle text-center">
                        {{ date('d/m/Y', strtotime($p->date)) }}
                    </td>
                    <td class="align-middle text-center">
                        {{ $p->time}}
                    </td>
                    <td class="align-middle text-center">
                        {{-- {{ $p->patient->email}} --}}
                        {{ $p->patient->email}}
                    </td>
                </tr>
                @endforeach
            </table>
            @elseif( null === (request('search1')) && null === (request('search2')))
            <h5 class="">Search Patient Here</h5>
            <table class="table table-borderless nameTablePage" style="width: 65vw;max-width:400px">
                <tr>
                    <th>id</th>
                    <!-- <th >Patient id</th> -->
                    <th>Name</th>
                    <th>Mobile No</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Email</th>
                </tr>
                {{-- @dd($doctor->appointments) --}}
            </table>
            @elseif($patient->count() < 1 && null !==(request('search1') && null !==(request('search2')))) <h5 class="">
                No Patient Found</h5>
                <table class="table table-borderless nameTablePage" style="width: 65vw;max-width:400px">
                    <tr>
                        <th>id</th>
                        <!-- <th>Patient id</th> -->
                        <th>Name</th>
                        <th>Mobile No</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Email</th>
                    </tr>
                    {{-- @dd($doctor->appointments) --}}
                </table>

                @endif
        </div>
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
                    <button type="button" class="btn-close mt-2" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body patient-modal-body ms-2 mt-2">
                    <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                        Mobile No</h1>
                    <p id="mobile_no" class="justify-content-center d-flex fw-bolder text-body"></p>
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