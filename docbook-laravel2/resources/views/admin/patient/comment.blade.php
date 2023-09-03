@extends('layouts.mainAdmin')

@section('container')



<div class="dashboardHistoryTableContainer d-flex justify-content-center">
    <div
        class="mt-1 indexDashboard shadow rounded-3 col-xl-9 col-md-12 px-1 mb-5 mx-auto table-responsive border-top border-5 border-primary">
        @if (count($tmpComment) > 0)

        <h5 class="text-uppercase mt-3 ms-3 text-primary">Pending Patient Comment</h5>
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
                    data-bs-dismiss="alert" aria-label="Close" style="padding:0"></button>
            </div>
        </div>
        @endif
        <table class="table table-borderless col-sm-12  pendingCommentTable">
            <thead>
                <tr>
                    <th scope="col" class="text-center"></th>
                    <th scope="col" class="text-center">From Patient</th>
                    <th scope="col" class="text-center">To Doctor</th>
                    <th scope="col" class="text-center">Detail Comment</th>
                    <th scope="col" class="text-center">Action</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($tmpComment as $item)
                <tr class="shadow-sm rounded">
                    <th scope="row" class="align-middle">{{ $loop->iteration }}</th>
                    <td class="align-middle text-center">{{ $item->patient->full_name }}</td>
                    <td class="align-middle text-center">{{ $item->doctor->first_name }} {{ $item->doctor->last_name }}
                    </td>
                    <td class="align-middle text-center">
                        <form action="" method="post">
                            @csrf
                            <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal"
                                class="bg-transparent border border-0 align-middle displayDetailsTmpComment"
                                data-id='{{ $item->id }}'><i class="fa-sharp fa-solid fa-circle-info"></i>
                            </button>
                        </form>
                    </td>
                    <td class="align-middle text-center">
                        <form action="/admin/dashboard/approve-comment/{{$item->id}}/{{ $item->patient->full_name }}"
                            method="post">
                            @csrf
                            <button class="bg-transparent border-0"
                                onclick="return confirm('Are you sure to approve this comment?')"><i
                                    class="fa-solid fa-circle-check" id="approve-doctor"
                                    style="color: #37ff00;"></i></button>
                        </form>
                        <form action="/admin/dashboard/reject-comment/{{$item->id}}/{{ $item->patient->full_name }}"
                            method="post">
                            @csrf
                            <button class="bg-transparent border border-0"
                                onclick="return confirm('Are you sure to reject this comment?')"><i
                                    class="fa-solid fa-circle-xmark" style="color: #ff0000;"></i></button>
                        </form>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
        @else
        <h5 class="text-uppercase mt-3 ms-3 text-primary mb-3">don't have Pending Patient Comment for now</h5>
        @endif
    </div>
    {{-- endof indexDashboard --}}
</div>
{{-- end of dashboardHistoryTableContainer --}}

<!-- End of Main Content -->



{{-- details modal --}}
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="margin-top: 150px">
        <div class="modal-content d-flex flex-row bg-transparent">
            <div style="backdrop-filter: blur(10px);background: rgba(78, 115, 223,0.3);  box-shadow: inset 0 0 0 200px rgba(255,255,255,0.2); border-radius: 8px;
" class="d-flex justify-self-center flex-column border border-0 col-sm-12 col-12">
                <div class=" border-dark-subtle border-2 border-bottom mx-2 d-flex
justify-content-between" style="height: 35px;">
                    <h1 class=" fs-6 mt-2" id="exampleModalLabel">comment detail</h1>
                    <button type="button" class="btn-close mt-2" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body patient-modal-body ms-2 mt-2">
                    <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                        comment</h1>
                    <p id="comment" class="justify-content-center d-flex fw-bolder text-body"></p>
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
<script src="{{ asset('js/jquery-ui.min.js') }}"></script>
<script src="{{ asset('js/jquery.timepicker.min.js') }}"></script>
<script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
<script type="text/javascript" src="{{ asset('js/selectMenu.js') }}"></script>

@endsection