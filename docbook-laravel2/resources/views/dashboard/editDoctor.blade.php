@extends('layouts.dashboardMain')
@section('container')
<div class="generalContainer dashboardProfileRoot">

    <div class="dashboardProfileContainer">
        <h1> Your Profile</h1>
        {{-- @if(session()->has('success')) --}}
        {{-- <div
            class="alert alert-success fade show col-12 col-md-8 col-lg-5 col-xxl-4 mx-auto d-flex justify-content-between"
            role="alert">
            <i class="fa-sharp fa-solid fa-square-check me-1" style="margin-right: 10px"></i>
            <p class="text-success" style="width:200%">data successfully updated</p>
            <button type="button" class="btn-close border-0 bg-transparent bg-opacity-10 mt-1" data-bs-dismiss="alert"
                aria-label="Close" style="padding:0"></button>
        </div> --}}
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
        <form action="/dashboard/{{ $doctor->user_name }}" method="post" enctype="multipart/form-data">
            @csrf
            <input class="form-control @error('email') is-invalid @enderror" type="hidden" name="oldImg"
                value="{{ old('') }}">

            <label for="">Email</label>
            <input class="form-control @error('email') is-invalid @enderror" name="email" type="text"
                value="{{ old('email', $doctor->email) }}">
            @error('email')
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

            <label for="">Location</label>
            <input class="form-control @error('location') is-invalid @enderror" name="location" type="text"
                value="{{ old('location', $doctor->location) }}">
            @error('location')
            <div class="text-danger">
                {{ $message }}
            </div>
            @enderror
            <label for="">Experience</label>
            <input class="form-control @error('experience') is-invalid @enderror" name="experience" type="text"
                value="{{ old('experience', $doctor->experience) }}">
            @error('experience')
            <div class="text-danger">
                {{ $message }}
            </div>
            @enderror


            {{-- image --}}
            <div class="mt-2">
                @if($doctor->img)
                <img src="{{ asset('storage/' . $doctor->img) }}" alt="" style="min-width: 100px"
                    class="img-preview img-fluid col-sm-5 img-thumbnail">
                @else
                <img alt="">
                @endif

                <input type="hidden" name="oldImg" value="{{ $doctor->img }}">
                <div class="form-text" id="basic-addon4">image</div>
                <input type="file" class="form-control border border-primary-subtle @error('img') is-invalid @enderror"
                    id="inputGroupFile03" name="img" aria-describedby="inputGroupFileAddon03" aria-label="Upload">
                @error('img')
                <p class="text-danger">{{ $message }}</p>
                @enderror
            </div>


            @error('email')
            <div class="text-danger">
                {{ $message }} </div>

            @enderror
            <div class="dashboardProfileSelect">
                <div>
                    <label for="">Specialization</label>
                    <select name="specialization_id" id="dashboardSpecialization">
                        <option value="{{ old('specialization_id', $doctor->specialization_id) }}" selected
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