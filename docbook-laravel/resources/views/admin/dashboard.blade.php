@extends('layouts.mainAdmin')

@section('container')
<!-- Begin Page Content -->
<div class="container-fluid">
    <!-- Content Row -->
    <div class="row justify-content-center">
        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                Total Doctor</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">{{ $doctors->count() }}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fa-solid fa-user-doctor fa-2xl" style="color: #dddfeb;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        {{-- #DDDFEB --}}

        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                Total Patient</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">{{ $patients->count() }}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fa-solid fa-bed-pulse fa-2xl" style="color: #dddfeb;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Pending Requests Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                Pending Requests</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">{{ $tmpDoctors->count() }}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-comments fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->

</div>
<div class="dashboardHistoryTableContainer d-flex justify-content-center">
    <div
        class="mt-1 indexDashboard shadow rounded-3 col-xl-9 col-md-12 px-1 mb-5 mx-auto table-responsive border-top border-5 border-warning">
        @if (count($tmpDoctors) > 0)
        <h5 class="text-uppercase mt-3 ms-3 text-warning">Pending Doctor registration</h5>
        @if(session()->has('success'))
        <div class="alert alert-success fade show col-12 col-md-8 col-lg-5 col-xxl-4 mx-auto d-flex justify-content-between"
            role="alert">
            <div>
                <i class="fa-sharp fa-solid fa-square-check me-1" style="margin-right: 10px"></i>
                <div class="d-inline text-start">
                    {{ session('success') }}
                </div>
            </div>
            <div>
                <button type="button" class="btn-close border-0 bg-transparent bg-opacity-10 mt-1"
                    data-bs-dismiss="alert" aria-label="Close" style="padding:0"><i
                        class="fa-solid fa-xmark"></i></button>
            </div>
        </div>
        @endif
        <table class="table table-borderless col-sm-12  pendingTable">
            <thead>
                <tr>
                    <th scope="col" class="text-center"></th>
                    <th scope="col" class="text-center">full name</th>
                    <th scope="col" class="text-center">user name</th>
                    <th scope="col" class="text-center">detail</th>
                    <th scope="col" class="text-center">email</th>
                    <th scope="col" class="text-center">contact</th>
                    <th scope="col" class="text-center">specialization</th>
                    <th scope="col" class="text-center">Action</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($tmpDoctors as $item)
                <tr class="shadow-sm rounded">
                    <th scope="row" class="align-middle">{{ $loop->iteration }}</th>
                    <td class="align-middle text-center">{{ $item->full_name }}</td>
                    <td class="align-middle text-center">{{ $item->user_name }}</td>
                    <td class="align-middle text-center">
                        <form action="" method="post">
                            @csrf
                            <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal"
                                class="bg-transparent border border-0 align-middle displayDetailsTmpDoctor"
                                data-id='{{ $item->id }}'><i class="fa-sharp fa-solid fa-circle-info"></i>
                            </button>
                        </form>
                    </td>
                    <td class="align-middle text-center">{{ $item->email }}</td>
                    <td class="align-middle text-center">{{ $item->mobile_number }}</td>
                    <td class="align-middle text-center">{{ $item['specialization']->name }}</td>
                    <td class="align-middle text-center">
                        <form action="/admin/dashboard/approve-doctor/doctor/{{$item->id}}" method="post">
                            @csrf
                            <button class="bg-transparent border-0"
                                onclick="return confirm('Are you sure to approve?')"><i class="fa-solid fa-circle-check"
                                    id="approve-doctor" style="color: #37ff00;"></i></button>
                        </form>
                        <form action="/admin/dashboard/reject-doctor/doctor/{{$item->id}}" method="Post">
                            @csrf
                            <button class="bg-transparent border border-0"
                                onclick="return confirm('Are you sure to delete?')"><i class="fa-solid fa-circle-xmark"
                                    style="color: #ff0000;"></i></button>
                        </form>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
        @else
        <h5 class="text-uppercase mt-3 ms-3 text-warning mb-3">dont have pending doctor registration for now</h5>
        @endif
    </div>
    {{-- endof indexDashboard --}}
</div>
{{-- end of dashboardHistoryTableContainer --}}

<!-- End of Main Content -->



{{-- details modal --}}
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content d-flex flex-row bg-transparent">
            <div style="backdrop-filter: blur(10px);background: rgba(78, 115, 223,0.3);  box-shadow: inset 0 0 0 200px rgba(255,255,255,0.2); border-radius: 8px;
" class="d-flex justify-self-center flex-column border border-0 col-sm-12 col-12">
                <div class=" border-dark-subtle border-2 border-bottom mx-2 d-flex
justify-content-between" style="height: 35px;">
                    <h1 class=" fs-6 mt-2" id="exampleModalLabel">Information</h1>
                    <button type="button" class="btn-close mt-2" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body patient-modal-body ms-2 mt-2">
                    <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                        email</h1>
                    <p id="email" class="justify-content-center d-flex fw-bolder text-body"></p>
                    <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                        mobile number
                    </h1>
                    <p id="mobile_no" class="justify-content-center d-flex fw-bolder text-body">
                    </p>
                    <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                        specialization
                    </h1>
                    <p id="specialization" class="justify-content-center d-flex fw-bolder text-body">
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