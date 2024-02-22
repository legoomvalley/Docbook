@extends('layouts.dashboardMain')
@section('container')
<div class="generalContainer dashboardProfileRoot">

    <div class="dashboardProfileContainer">
        <h1> Your Profile</h1>

        @if(session()->has('success'))
        <div class="alert alert-success d-flex justify-content-between fade show col-10 col-md-12" role="alert">
            <div>
                <i class="fa-sharp fa-solid fa-square-check me-2" style="margin-right: 10px"></i>
                {{ session('success') }}
            </div>
            <div>
                <button type="button" class="btn-close border-0 bg-transparent bg-opacity-10 mt-1"
                    data-bs-dismiss="alert" aria-label="Close" style="padding:0; max-width:25px;"></button>
            </div>
        </div>
        @endif
        <form action="/dashboard/{{ $doctor->user_name }}" method="POST" enctype="multipart/form-data">
            @csrf
            <input class="form-control is-invalid" type="hidden" name="oldImg" value="{{ old('') }}">


            <label for="">Email</label>
            <input class="form-control @error('email') is-invalid @enderror" name="email" type="text"
                value="{{ old('email', $doctor->user->email) }}">
            @error('email')
            <div class="text-danger">
                {{ $message }}
            </div>
            @enderror


            <label for="">Full Name</label>
            <input class="form-control @error('full_name') is-invalid @enderror" name="full_name" type="text"
                value="{{ old('full_name', $doctor->user->name) }}">
            @error('full_name')
            <div class="text-danger">
                {{ $message }}
            </div>
            @enderror

            <label for="">Username</label>
            <input class="form-control @error('user_name') is-invalid @enderror" name="user_name" type="text"
                value="{{ old('user_name', $doctor->user_name) }}">
            @error('user_name')
            <div class="text-danger">
                {{ $message }}
            </div>
            @enderror
            <label for="">Phone Number</label>
            <input class="form-control @error('mobile_number') is-invalid @enderror" name="mobile_number" type="text"
                value="{{ old('mobile_number', $doctor->mobile_number) }}">
            @error('mobile_number')
            <div class="text-danger">
                {{ $message }}
            </div>
            @enderror

            <label for="">Total Experience</label>
            <input class="form-control @error('experience') is-invalid @enderror" name="experience" type="number"
                value="{{ old('experience', $doctor->experience_year) }}">
            @error('experience')
            <div class="text-danger">
                {{ $message }}
            </div>
            @enderror
            <label for="">Bio Data</label>
            <textarea class="form-control @error('bio_data') is-invalid @enderror" name="bio_data" type="text" row="5"
                style="min-height: 200px">{{ old('bio_data', $doctor->bio_data) }}</textarea>
            @error('bio_data')
            <div class="text-danger">
                {{ $message }}
            </div>
            @enderror


            {{-- image --}}
            <div class="mt-2">
                @if($doctor->user->profile_photo_path)
                <img src="{{ asset('storage/' . $doctor->user->profile_photo_path) }}" alt="" style="min-width: 100px"
                    class="img-preview img-fluid col-sm-5 img-thumbnail">
                @else
                <img alt="">
                @endif
                <input type="hidden" name="oldImg" value="{{ $doctor->img }}">
                <div class="form-text" id="basic-addon4">image</div>
                <input type="file"
                    class="py-2 ps-2 form-control border border-primary-subtle @error('image') is-invalid @enderror"
                    id="inputGroupFile03" name="image" aria-describedby="inputGroupFileAddon03" aria-label="Upload">
            </div>
            @error('image')
            <p class=" text-danger">{{ $message }}</p>
            @enderror

            <div class="dashboardProfileSelect">
                <div>
                    <label for="">Specialization</label>
                    <select name="specialization" id="dashboardSpecialization">
                        <option value="{{ old('specialization', $doctor->specialization_id) }}" selected
                            style="display:none;">
                            {{ $doctor->specialization->name }}
                        </option>
                        <option value="1">Pediatrics</option>
                        <option value="2">General Medicine</option>
                        <option value="3">Eye Specialist</option>
                        <option value="4">Orthopedics</option>
                    </select>
                </div>
                <div id="dashboardAvailability">
                    <label for="">Availability</label>
                    <select name="status">
                        <option value="{{ old('status', $doctor->status) }}" selected style="display:none;">
                            {{ $doctor->status }}
                        </option>
                        <option value="available">Available</option>
                        <option value="not available">Not Available</option>
                    </select>
                </div>
            </div>

            <label for="" class="mt-5">Registration Date</label>
            <input class="" type="text" value="{{  date('d-m-Y', strtotime($doctor->created_at)) }} " disabled>
            <div class="d-flex justify-content-center">
                <button type="submit" name="submit">Update</button>
            </div>
        </form>
    </div>
</div>
@endsection