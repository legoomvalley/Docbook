@extends('layouts.main')

@section('container')
<div class="appointmentHistoryBody d-flex justify-content-center flex-column">
    <div class="appointmentHistoryContainer">
        <h1>Check your result or status here</h1>
        <div class="appointmentHistoryLine">
            <hr>
        </div>
    </div>
    {{-- <div class="container bg-primary"> --}}
        @if ($patients->count() < 1) <h5>dont have appointment</h5>
            @else
            @if(session()->has('success'))
            <div class="alert alert-success alert-dismissible fade show col-10 col-md-6 col-lg-4 mx-auto" role="alert">
                <i class="fa-sharp fa-solid fa-square-check me-1"></i>
                {{ session('success') }}
                <button type="button" class="btn-close align-middle" data-bs-dismiss="alert"
                    aria-label="Close"></button>
            </div>
            @endif
            <table class="table table-borderless tableAppointment rounded-3 overflow-hidden mx-auto"
                style="width:90vw;">
                <thead>
                    <tr class=" rounded-top">
                        <th scope="col">No</th>
                        <th scope="col">Name</th>
                        <th scope="col">Date | Time</th>
                        <th scope="col">Remark</th>
                        <th scope="col">Status</th>
                        <th scope="col">details</th>
                        <th scope="col">Doctor Name</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody class="table-group-divider appointmentRecord">

                    @foreach($patients as $p)
                    <tr>
                        <td class="align-middle" scope="row">{{ $loop->iteration }}</td>
                        <td class="align-middle text-start">{{ $p->full_name }}</td>
                        <td class="align-middle">{{ date('d/m/Y', strtotime($p->date)) }} {{ $p->time }}</td>
                        <td class="align-middle">{{ $p->remark }}</td>
                        <td class="align-middle">{{ $p->status }}</td>
                        <td class="align-middle">
                            <form action="/make-appointments" method="post">
                                @csrf<button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal"
                                    class="bg-transparent border border-0 displayDetailsModal" data-id='{{ $p->id }}'><i
                                        class="fa-sharp fa-solid fa-circle-info"></i></button></form>
                        </td>
                        <td class="align-middle">{{ $p->doctor_name }}</td>
                        <td class="align-middle">
                            @if ($p->status == 'completed' || $p->status == 'not approved')
                            <form action="/appointment/{{ $p->id }}" method="POST" id="deleteForm">
                                @csrf
                                @method('DELETE')
                                <button type=" submit" class="text-decoration-none border border-0 bg-transparent "
                                    onclick="return confirm('Are you sure to delete?')">
                                    <i class=" fa-solid fa-trash text-danger"></i>
                                </button>
                            </form>
                            @elseif($p->status == 'approved')
                            <form action="/appointment/{{ $p->id }}" method="POST" id="deleteForm">
                                @csrf
                                @method('PUT')
                                <button type=" submit" class="text-decoration-none border border-0 bg-transparent "
                                    onclick="return confirm('Are you sure to change it status to completed?')">
                                    <i class="fa-regular fa-circle-check text-success"></i>
                                </button>
                            </form>
                            @else
                            -
                            @endif

                        </td>
                    </tr>
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                        aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content d-flex flex-row bg-transparent">
                                <div style="backdrop-filter: blur(10px);background: inherit;  box-shadow: inset 0 0 0 200px rgba(255,255,255,0.2); border-radius: 8px;
                            " class="d-flex justify-self-center flex-column border border-0 col-sm-12 col-12">
                                    <div class=" border-dark-subtle border-2 border-bottom mx-2 d-flex
                                justify-content-between" style="height: 30px;">
                                        <h1 class=" fs-6 mt-1" id="exampleModalLabel">Information</h1>
                                        <button type="button" class="btn-close mt-2" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body patient-modal-body ms-2 mt-2">
                                        <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                            id="exampleModalLabel">Remark
                                        </h1>
                                        <p id="remark" class="justify-content-center d-flex fw-bold text-body"></p>
                                        <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                            id="exampleModalLabel">Status</h1>
                                        <p id="status" class="justify-content-center d-flex fw-bolder text-body">
                                        <h1 class="fs-6 justify-content-center d-flex text-body-tertiary"
                                            id="exampleModalLabel">Date | Time
                                        </h1>
                                        <p id="date" class="justify-content-center d-flex fw-bolder text-body">
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
                    @endforeach
                </tbody>
            </table>
            @endif
            {{--
    </div> --}}
</div>
@endsection
@section('jsAjax')
<script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
@endsection