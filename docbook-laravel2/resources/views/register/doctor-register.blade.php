@extends('layouts.main2')

@section('container')
{{-- <p class="text-danger">$message </p> --}}

<div class="registerContainer">
    <div class="registerImg">
        <img src="{{ asset('img/registerPic.png') }}" alt="">
    </div>
    <div class="registerForm">
        <h1>Register</h1>
        <p>register as doctor here</p>
        <form action="/doctor-register" method="post" enctype="multipart/form-data">
            @csrf

            <div class="input-group-sm mt-2">
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
                <input name="mobile_number" type="text"
                    class="form-control shadow-sm @error('mobile_number') is-invalid @enderror"
                    aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                    value="{{ old('mobile_number') }}">
                @error('mobile_number')
                <p class=" text-danger">{{ $message }}</p>
                @enderror
            </div>
            <div class=" input-group-sm mt-3 shadow-sm">
                <select name="specialization_id"
                    class="form-select form-select-sm  @error('specialization_id') is-invalid @enderror"
                    value="{{ old('specialization_id') }}" aria-label=".form-select-sm example">
                    <option value="" disabled selected>Select Specialization</option>
                    <option value="1">Pediatrics</option>
                    <option value="2">General Medicine</option>
                    <option value="4">Orthopedics</option>
                    <option value="3">Eye Specialist</option>
                </select>
            </div>
            @error('specialization_id')
            <div class="text-danger">{{ $message }}</div>
            @enderror
            <div class=" input-group-sm mt-3 shadow-sm">
                <select name="status" class="form-select form-select-sm  @error('status') is-invalid @enderror"
                    aria-label=".form-select-sm example" value="{{ old('status') }}">
                    <option value="" disabled selected>Select status</option>
                    <option value="available">Available</option>
                    <option value="not available">Not Available</option>
                </select>
            </div>
            @error('status')
            <div class="text-danger">{{ $message }}</div>
            @enderror
            <div class=" input-group-sm mt-2">
                <div class="form-text" id="basic-addon4">experience</div>
                <input name="experience" type="number"
                    class="form-control shadow-sm @error('experience') is-invalid @enderror"
                    aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                    value="{{ old('experience') }}">
                @error('experience')
                <p class=" text-danger">{{ $message }}</p>
                @enderror
            </div>
            <div class=" input-group-sm mt-2">
                <div class="form-text" id="basic-addon4">bio_data</div>
                <input name="bio_data" type="text"
                    class="form-control shadow-sm @error('bio_data') is-invalid @enderror"
                    aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                    value="{{ old('bio_data') }}">
                @error('bio_data')
                <p class=" text-danger">{{ $message }}</p>
                @enderror
            </div>
            <div class="mt-2">
                <div class="form-text" id="basic-addon4">image</div>
                <input type="file" class="form-control shadow-sm @error('image') is-invalid @enderror"
                    id="inputGroupFile03" name="image" aria-describedby="inputGroupFileAddon03" aria-label="Upload">
                @error('image')
                <p class="text-danger">{{ $message }}</p>
                @enderror
            </div>
            <a style="" href="/doctor-login" class="loginLink mt-3">dah login?
                tekan sini kawan
            </a>
            <input type="submit" value="submit">


        </form>
    </div>
</div>
@endsection