@extends('layouts.mainAdmin')

@section('container')
{{-- <div class="container"> --}}

    <div class="formContainer mb-3 py-3 col-11 col-sm-10 col-md-10 col-lg-8 mx-auto rounded-4 shadow border-top border-5 border-primary"
        id="formContainer">
        <div class="col-md-10 col-lg-6 mx-auto">
            <h3 class="text-primary mt-2">add Doctor</h3>
            @if(session()->has('success'))
            <div class="alert alert-success alert-dismissible fade show col-12 mx-auto" role="alert">
                <i class="fa-sharp fa-solid fa-square-check me-1"></i>
                {{ session('success') }}
                <button type="button" class="btn-close align-middle" data-bs-dismiss="alert"
                    aria-label="Close"></button>
            </div>
            @endif
            <form action="{{ route('admin.storeDoctor') }}" method="post" enctype="multipart/form-data">
                @csrf
                <div class="d-sm-flex justify-content-between">
                    <div class="input-group-sm mt-2 col-sm-6  pe-sm-2" style="padding:0">
                        <div class="form-text" id="basic-addon4">first name</div>
                        <input name="first_name" type="text"
                            class="form-control shadow-sm @error('first_name') is-invalid @enderror"
                            value="{{ old('first_name') }}">
                        @error('first_name')
                        <p class=" text-danger">{{ $message }}</p>
                        @enderror
                    </div>
                    <div class=" input-group-sm mt-2 col-sm-6" style="padding:0">
                        <div class="form-text" id="basic-addon4">last name</div>
                        <input name="last_name" type="text"
                            class="form-control shadow-sm @error('last_name') is-invalid @enderror"
                            aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                            value="{{ old('last_name') }}">
                        @error('last_name')
                        <p class=" text-danger">{{ $message }}</p>
                        @enderror
                    </div>
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
                    <input name="mobile_number" type="text"
                        class="form-control shadow-sm @error('mobile_number') is-invalid @enderror"
                        aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                        value="{{ old('mobile_number') }}">
                    @error('mobile_number')
                    <p class=" text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <div class="d-sm-flex justify-content-between">
                    <div class="input-group-sm mt-3 shadow-sm col-sm-6 pe-sm-2 shadow-none" style="padding: 0">
                        <select name="specialization_id"
                            class="form-select form-select-sm  @error('specialization_id') is-invalid @enderror"
                            value="{{ old('specialization_id') }}" aria-label=".form-select-sm example">
                            <option value="" disabled selected>Select Specialization</option>
                            <option value="1">Pediatrics</option>
                            <option value="2">General Medicine</option>
                            <option value="4">Orthopedics</option>
                            <option value="3">Eye Specialist</option>
                        </select>
                        @error('specialization_id')
                        <div class="text-danger">{{ $message }}</div>
                        @enderror
                    </div>
                    <div class=" input-group-sm mt-3 shadow-sm col-sm-6 shadow-none" style="padding: 0">
                        <select name="status" class="form-select form-select-sm  @error('status') is-invalid @enderror"
                            aria-label=".form-select-sm example" value="{{ old('status') }}">
                            <option value="" disabled selected>Select status</option>
                            <option value="Available">Available</option>
                            <option value="Not Available">Not Available</option>
                        </select>
                        @error('status')
                        <div class="text-danger">{{ $message }}</div>
                        @enderror
                    </div>
                </div>
                <div class=" input-group-sm mt-2">
                    <div class="form-text" id="basic-addon4">location</div>
                    <input name="location" type="text"
                        class="form-control shadow-sm @error('location') is-invalid @enderror"
                        aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                        value="{{ old('location') }}">
                    @error('location')
                    <p class=" text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <div class=" input-group-sm mt-2">
                    <div class="form-text" id="basic-addon4">experience</div>
                    <input name="experience" type="text"
                        class="form-control shadow-sm @error('experience') is-invalid @enderror"
                        aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                        value="{{ old('experience') }}" style="height: 100px;padding-bottom:70px">
                    @error('experience')
                    <p class=" text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <div class="input-group-sm mt-2">
                    <div class="form-text" id="basic-addon4">image</div>
                    <input type="file" class="form-control shadow-sm @error('img') is-invalid @enderror"
                        id="inputGroupFile03" name="img" aria-describedby="inputGroupFileAddon03" aria-label="Upload">
                    @error('img')
                    <p class="text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <input type="submit" value="submit" class="d-block mt-2 btn btn-outline-primary rounded align-middle">


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