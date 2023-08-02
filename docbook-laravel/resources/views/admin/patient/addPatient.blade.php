@extends('layouts.mainAdmin')

@section('container')
{{-- <div class="container"> --}}

    <div class="formContainer mb-3 py-3 col-11 col-sm-10 col-md-10 col-lg-6 mx-auto rounded-4 shadow border-top border-5 border-success mt-5"
        id="formContainer">
        <div class="col-md-10 col-lg-6 mx-auto">
            <h3 class="text-success mt-2">add Patient</h3>
            @if(session()->has('success'))
            <div class="alert alert-success alert-dismissible fade show col-12 mx-auto" role="alert">
                <i class="fa-sharp fa-solid fa-square-check me-1"></i>
                {{ session('success') }}
                <button type="button" class="btn-close align-middle" data-bs-dismiss="alert"
                    aria-label="Close"></button>
            </div>
            @endif
            <form action="{{ route('admin.storePatient') }}" method="post" enctype="multipart/form-data">
                @csrf
                <div class=" input-group-sm mt-2">
                    <div class="form-text" id="basic-addon4">full name</div>
                    <input name="full_name" type="text"
                        class="form-control shadow-sm @error('full_name') is-invalid @enderror"
                        aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                        value="{{ old('full_name') }}">
                    @error('full_name')
                    <p class=" text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <div class=" input-group-sm mt-2">
                    <div class="form-text" id="basic-addon4">user name</div>
                    <input name="user_name" type="text"
                        class="form-control shadow-sm @error('user_name') is-invalid @enderror"
                        aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                        value="{{ old('user_name') }}">
                    @error('user_name')
                    <p class=" text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <div class=" input-group-sm mt-2">
                    <div class="form-text" id="basic-addon4">email</div>
                    <input name="email" type="text" class="form-control shadow-sm @error('email') is-invalid @enderror"
                        aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                        value="{{ old('email') }}">
                    @error('email')
                    <p class=" text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <div class=" input-group-sm mt-2">
                    <div class="form-text" id="basic-addon4">password</div>
                    <input name="password" type="text"
                        class="form-control shadow-sm @error('password') is-invalid @enderror"
                        aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
                    @error('password')
                    <p class="text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <div class=" input-group-sm mt-2">
                    <div class="form-text" id="basic-addon4">mobile number</div>
                    <input name="phone_no" type="text"
                        class="form-control shadow-sm @error('phone_no') is-invalid @enderror"
                        aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                        value="{{ old('phone_no') }}">
                    @error('phone_no')
                    <p class=" text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <input type="submit" value="submit" class="d-block mt-4 btn btn-outline-success rounded align-middle">


            </form>
        </div>
    </div>

    {{--
</div> --}}
{{--
</div> --}}

@endsection



@section('jsAjax')
<script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
@endsection