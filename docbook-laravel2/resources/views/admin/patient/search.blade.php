@extends('layouts.mainAdmin')

@section('container')
{{-- @extends('admin.doctor.tableSearchResult') --}}



<div class="dashboardHistoryTableContainer d-flex justify-content-center align-items-center flex-column">
    @if (count($patients) > 0)
    <div class="col-xl-9 col-md-12 d-flex justify-content-start" style="padding: 0">
        <div class="col-12 col-md-10 col-lg-8" style="padding: 0px">
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">search by name</label>
                <form>
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Patient's name"
                            aria-label="Recipient's username" name="searchPatient" aria-describedby="button-addon2"
                            id="keyword">
                        <button class="btn btn-outline-primary" type="submit" id="search-button">Button</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    @else
    @endif
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
            <button type="button" class="btn-close border-0 bg-transparent bg-opacity-10 mt-1" data-bs-dismiss="alert"
                aria-label="Close" style="padding:0"></button>
        </div>
    </div>
    @endif
    <div class="col-xl-9 col-md-12" style="padding: 0" id="searchDoctorContainer">

        <div
            class="mt-1 indexDashboard shadow rounded-3 px-1 mb-5 mx-auto table-responsive border-top border-5 border-primary">
            @if (count($patients) > 0)
            <h5 class="text-uppercase mt-3 ms-3 text-primary result">All Patient</h5>
            <table class="table table-borderless col-sm-12">
                <thead>
                    <tr>
                        <th scope="col" class="text-center"></th>
                        <th scope="col" class="">full name</th>
                        <th scope="col" class="text-center">contact</th>
                        <th scope="col" class="text-center">email</th>
                        <th scope="col" class="text-center">action</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($patients as $item)
                    <tr class="shadow-sm rounded">
                        <th scope="row" class="align-middle">{{ $loop->iteration }}</th>

                        <td class="align-middle">{{ $item->full_name }}</td>
                        <td class="align-middle text-center">{{ $item->phone_no }}</td>
                        <td class="align-middle text-center">{{ $item->email }}</td>
                        <td class="align-middle text-center">
                            <form action="/admin/dashboard/reject-patient/{{$item->full_name}}" method="post">
                                @csrf
                                <button class="bg-transparent border border-0"
                                    onclick="return confirm('Are you sure to delete?')"><i
                                        class="fa-solid fa-circle-xmark" style="color: #ff0000;"></i></button>
                            </form>
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
            @else
            <h5 class="text-uppercase mt-3 ms-3 text-primary result mb-3">Don't have patient for now</h5>
            @endif
        </div>

        @endsection

        @section('jsAjax')
        <script src="{{ asset('js/jquery-ui.min.js') }}"></script>
        <script src="{{ asset('js/jquery.timepicker.min.js') }}"></script>
        <script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
        <script type="text/javascript" src="{{ asset('js/selectMenu.js') }}"></script>

        <script>
            $(function () {
    fetch_doctor_data();
    function fetch_doctor_data(query = '') {
        $.ajax({
            url: "{{ route('admin.showDoctorBySearch') }}",
            method: 'GET',
            data: { query: query },
            dataType: 'json',
            success: function (data) {
                if ($('#keyword').val() !== "") {
                    $('.result').html("keyword for " + $('#keyword').val());
                } else {
                    $('.result').html("All doctor");
                }
                // $('#total_records').text(data.total_data);
            }
        })
    }
    $(document).on('keyup', '#keyword', function () {
        var query = $(this).val();
        fetch_doctor_data(query);
    });
    $(document).on('click', '.test', function () {
        console.log("rr")
    })
    })
        </script>
        @endsection