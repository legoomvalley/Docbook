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

            <form action="{{ route('admin.storeDoctor') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class=" input-group-sm mt-2" style="padding:0">
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
                    <input name="password" type="password"
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
                            <option value="available">Available</option>
                            <option value="not available">Not Available</option>
                        </select>
                        @error('status')
                        <div class="text-danger">{{ $message }}</div>
                        @enderror
                    </div>
                </div>
                <div class=" input-group-sm mt-2">
                    <div class="form-text" id="basic-addon4">year of experience</div>
                    <input name="experience" type="number" min="0"
                        class="form-control shadow-sm @error('experience') is-invalid @enderror"
                        aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                        value="{{ old('experience') }}">
                    @error('experience')
                    <p class=" text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <div class=" input-group-sm mt-2">
                    <div class="form-text" id="basic-addon4">bio data</div>
                    <input name="bio_data" type="text"
                        class="form-control shadow-sm @error('bio_data') is-invalid @enderror"
                        aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                        value="{{ old('bio_data') }}" style="height: 100px;padding-bottom:70px">
                    @error('bio_data')
                    <p class=" text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <div class="input-group-sm mt-2">
                    <div class="form-text" id="basic-addon4">image</div>
                    <input type="file" class="form-control shadow-sm @error('image') is-invalid @enderror"
                        id="inputGroupFile03" name="image" aria-describedby="inputGroupFileAddon03" aria-label="Upload">
                    @error('image')
                    <p class="text-danger">{{ $message }}</p>
                    @enderror
                </div>
                <button type="submit" class="d-block mt-2 btn btn-outline-primary rounded align-middle">submit</button>


            </form>
        </div>
    </div>

    {{--
</div> --}}
{{--
</div> --}}

@endsection



{{-- @section('jsAjax')
<script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
@endsection --}}