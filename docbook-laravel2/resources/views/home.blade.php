@extends('layouts.main')

@section('container')
<!-- ! - background image section - -->

<div class="backgroundImgContainer">
    {{-- <img src="{{ asset('img/homeBackground.jpg') }}" alt=""> --}}
    <div class="imgTxt">
        <h1>Instant Consultation With Trusted Doctors</h1>
    </div>
</div>
<div style="position: relative;" class="mb-5"></div>
@auth('patient')
<div class="row justify-content-center justify-self-center justify-item-center mx-auto bg-body-secondary py-5"
    style="max-width: 1400px">
    <div class=" patientAppointmentHome col-sm-11 col-md-11 col-lg-9 col-xxl-7 col-xl-8 py-5">
        {{-- col-sm-12 col-md-10 col-lg-9 col-xl-5 --}}
        {{-- appointment section --}}
        <main class="form-signin" style="z-index: 1000">
            <form action="/make-appointment" method="POST">
                @csrf
                <h1 class="h3 fw-bold font-monospace text-center">Make An Appointment Here</h1>
                @if(session()->has('success'))
                <div class="d-flex justify-content-center">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <div class="text-center"><i class="fa-sharp fa-solid fa-square-check me-1"></i> {!!
                            session('success') !!}

                        </div>

                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </div>
                @endif
                <div class="form1">
                    <div class="input-group mb-3">
                        {{-- date --}}
                        <div class="form-floating f">
                            <input value="{{ old('date') }}" name="date" type="text"
                                class="form-control rounded-start @error('date') is-invalid  @enderror datePicker">
                            <label for="floatingInput">Date</label>
                            @error('date')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                            @enderror
                        </div>
                        <div class="form-floating">


                            {{-- time --}}
                            <input value="{{ old('time') }}" name="time" type="text"
                                class="timePicker form-control rounded-end @error('time') is-invalid  @enderror"
                                id="timePicker" readonly>
                            <label for="floatingInput">Time</label>
                            @error('time')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                            @enderror
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <div class="form-floating">


                            {{-- disease --}}
                            <input value="{{ old('disease') }}" name="disease" type="text"
                                class="form-control rounded-start @error('disease') is-invalid  @enderror"
                                id="floatingInput">
                            <label for="floatingInput">Disease</label>
                            @error('disease')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                            @enderror
                        </div>
                        <div class="form-floating">


                            {{-- specialization --}}
                            <select name="specialization_id" class="form-select">
                                {{-- @dd($specializations) --}}
                                {{-- <option selected disabled>Select Specialization</option> --}}
                                @foreach ($specializations as $specialization)
                                <option value="{{ $specialization->id }}">{{ $specialization->name }}</option>
                                @endforeach
                            </select>
                            <label for="floatingInput">Select Specialization</label>
                        </div>
                    </div>
                    <div class="d-grid col-4 mx-auto mt-3">
                        <button class="btn btn-lg btn-primary" type="submit">Submit</button>
                    </div>
                </div>
            </form>


            <form action="/make-appointment" method="POST">
                @csrf
                {{-- form 2 --}}
                <div class="form2">
                    <div class="mb-1 dateTime">
                        {{-- date --}}
                        <div class="mb-1 input">
                            <label for="floatingInput">Date</label>
                            <input value="{{ old('date') }}" name="date" type="text"
                                class="form-control rounded-start @error('date') is-invalid  @enderror datePicker"
                                readonly>
                            @error('date')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                            @enderror
                        </div>
                        <div class="mb-1 input">


                            {{-- time --}}
                            <label for="floatingInput">Time</label>
                            <input value="{{ old('time') }}" name="time" type="text"
                                class="timePicker form-control rounded-end @error('time') is-invalid  @enderror"
                                id="timePicker" readonly>
                            @error('time')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                            @enderror
                        </div>
                    </div>
                    <div class="mb-1 diseaseSpecialization">
                        <div class="mb-1 input">
                            {{-- disease --}}
                            <label for="floatingInput">Disease</label>
                            <input value="{{ old('disease') }}" name="disease" type="text"
                                class="form-control rounded-start @error('disease') is-invalid  @enderror"
                                id="floatingInput">
                            @error('disease')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                            @enderror
                        </div>
                        <div class="mb-1 input">
                            {{-- specialization --}}
                            <label for="floatingInput">Select Specialization</label>
                            <select name="specialization_id" class="form-select">
                                @foreach ($specializations as $specialization)
                                <option value="{{ $specialization->id }}">{{ $specialization->name }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    <div class="d-grid col-4 mx-auto mt-3">
                        <button class="btn btn-lg btn-primary" type="submit">Submit</button>
                    </div>
                </div>

            </form>
        </main>
    </div>
</div>
{{-- not auth patient --}}
{{-- ================================================= --}}
@else
<!-- login section -->
<div class="appointmentFormContainer pt-3 pb-5 d-flex justify-content-center mx-auto"
    id="appointmentFormContainer login">
    <div class="col-lg-8 col-12 col-md-8 col-xxl-7">
        <h4 class="text-center px-1">Please Login First If You Want to Make An Appointment</h4>
        <p class="text-center login-here-patient">Login As Patient Here</p>
        @if(session()->has('error'))
        <div class="d-flex justify-content-center">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <div class="text-center"><i class="fa-solid fa-square-xmark"></i>
                    {{ session('error') }}
                </div>

                <button type="button" class="btn-close mt-1" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </div>

        @endif
        <form action="/" method="POST" id="form1">
            @csrf
            <div class="row d-flex justify-content-center">
                <div class="mb-3 col-11 col-sm-10 patientLogin">
                    <input type="text" class="form-control  @error('user_name') invalidInputFeedback @enderror"
                        placeholder="Username" name="user_name" value="{{ old('user_name') }}">
                    @error('user_name')
                    <p class="text-danger">{{ $message }}</p>
                    @enderror
                </div>
            </div>
            <div class="row d-flex justify-content-center">
                <div class="mb-2 col-11 col-sm-10 patientLogin">
                    <input type="password" class="form-control @error('password') invalidInputFeedback @enderror"
                        placeholder="Password" name="password" value="{{ old('password') }}">
                    @error('password')
                    <p class="text-danger">{{ $message }}</p>
                    @enderror
                    <div id="passwordHelpBlock" class="form-text ms-1">
                        <button type="button" class="border border-0 text-decoration-underline text-primary"
                            data-bs-toggle="modal" data-bs-target="#registerModal">Register
                            Here</button>
                    </div>
                </div>
            </div>
            <div class="d-grid gap-2 col-4 mx-auto patientLogin">
                <button class="mb-3 btn btn-primary d-flex align-items-center justify-content-center" type="submit">
                    <div>Login</div>
                </button>
            </div>
        </form>
    </div>
</div>




<!-- Modal -->
<div class="modal-dialog modal-dialog-scrollable">
    <div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content register-patient-modal-content">
                <!-- Section: Design Block -->
                <section class="text-center">
                    <!-- Background image -->
                    <div class="p-5 bg-image" style="
          background-image: url('https://mdbootstrap.com/img/new/textures/full/171.jpg');
          height: 300px;
          ">
                        <div class="register-close-modal-patient d-flex justify-content-end">
                            <button type="button" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                        </div>
                        <h1>Register</h1>
                        <p>Register As A Patient Here</p>
                    </div>
                    <!-- Background image -->

                    <div class="card mx-4 mx-md-5 shadow-5-strong  mb-5 modalInputCard" style="
          margin-top: -140px;
          background: hsla(0, 0%, 100%, 0.8);
          backdrop-filter: blur(30px);
          ">
                        <div class="card-body py-5 px-md-5 success-registration">

                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                    {{-- form --}}
                                    <form action="/home" method="post" enctype="multipart/form-data"
                                        id="patient-register-form">
                                        @csrf
                                        <!-- Full Name Input -->
                                        <div class="mb-4">
                                            <div class="form-outline input-group-sm">
                                                <input value="{{ old('full_name') }}" name="full_name" type="text"
                                                    id="form3Example1" placeholder="Full Name"
                                                    class="form-control full_name_error" />

                                                <p class="text-danger full_name_error full_name"></p>
                                            </div>
                                        </div>
                                        {{-- Username Input --}}
                                        <div class="mb-4">
                                            <div class="form-outline input-group-sm">
                                                <input value="{{ old('user_name') }}" name="user_name" type="text"
                                                    id="username" placeholder="Username"
                                                    class="form-control user_name_error" />
                                                <p class="text-danger user_name_error"></p>
                                            </div>
                                        </div>
                                        <!-- Email input -->
                                        <div class="form-outline input-group-sm mb-4">
                                            <input value="{{ old('email') }}" name="email" type="email"
                                                id="form3Example3" placeholder="Email"
                                                class="form-control email_error" />
                                            <p class="text-danger email_error"></p>
                                        </div>
                                        <!-- Mobile No input -->
                                        <div class="form-outline input-group-sm mb-4">
                                            <input value="{{ old('phone_no') }}" name="phone_no" type="text"
                                                id="form3Example4" placeholder="Mobile Number"
                                                class="form-control phone_no_error" />
                                            <p class="text-danger phone_no_error"></p>
                                        </div>
                                        {{-- password input --}}
                                        <div class="form-outline input-group-sm mb-4">
                                            <input value="{{ old('password') }}" name="password" type="password"
                                                id="form3Example4" placeholder="Password"
                                                class="form-control  password_error" />
                                            <p class="text-danger password_error"></p>
                                        </div>
                                        <!-- Submit button -->
                                        <button type="submit" class="btn btn-outline-primary btn-sm btn-block mb-4"
                                            id="patient-registration-btn">
                                            Register
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- Section: Design Block -->
            </div>
        </div>
    </div>
</div>
@endauth

<!-- * ! speciality section -->
<div class="specialityContainer">
    <div class="specialityTxt">
        <h1>Our Speciality</h1>
        <p>Private online consultations with verified doctors in all specialists</p>
    </div>
    <div class="specialityGallery">
        <div class="imageSpeciality">
            <figure style="position: relative; overflow:hidden" class="rounded-4">
                <a href="{{ route('specialization', ['specialization' => '1']) }}" class="text-white">
                    <img src="{{ asset('img/specialityImg1.png') }}" alt="">
                    <div class="imgTitle">
                        <h3>Pediatrics</h3>
                    </div>
                </a>
            </figure>
        </div>
        <div class="imageSpeciality rounded">
            <figure style="position: relative; overflow:hidden" class="rounded-4">
                <a class="text-white" href="{{ route('specialization', ['specialization' => '2']) }}">
                    <img src="{{ asset('img/specialityImg2.png') }}" alt="">
                    <div class="imgTitle">
                        <h3>General Medicine</h3>
                    </div>
                </a>
                </figcaption>
            </figure>
        </div>
        <div class="imageSpeciality">
            <figure style="position: relative; overflow:hidden" class="rounded-4">
                <a class="text-white" href="all-doctors/specialization/{{ '3'}}">
                    <img src="{{ asset('img/specialityImg3.png') }}" alt="">
                    <div class="imgTitle">
                        <h3>Orthopedics</h3>
                    </div>
                </a>
                </figcaption>
            </figure>
        </div>
        <div class="imageSpeciality">
            <figure style="position: relative; overflow:hidden" class="rounded-4">
                <a class="text-white" href="all-doctors/specialization/{{ '4'}}">
                    <img src="{{ asset('img/specialityImg4.png') }}" alt="">
                    <div class="imgTitle">
                        <h3>Eye Specialist</h3>
                    </div>
                </a>
                </figcaption>
            </figure>
        </div>
    </div>
</div>

<!-- Question Section -->
<div class="questionContainer">
    <div class="questionTitle">
        <h1>Why Docbook?</h1>
        <p>Docbook provide solution to patients so that they're can make reservation more easier</p>
    </div>
    <div class="questionDescription">
        <img src="{{ asset('img/doctorQuestion.png') }}" alt="">
        <div class="answer">
            <h1>Curated Doctors</h1>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ducimus atque ipsum impedit id deserunt
                eos facilis incidunt error sapiente, eum dolores, necessitatibus ipsam nihil earum sequi quibusdam? Est
                unde facilis magnam, aliquam voluptates explicabo suscipit voluptatem praesentium, a voluptas numquam
                delectus quidem,.</p>
        </div>
    </div>
</div>



{{-- one patient can has many appointment --}}
{{-- one appointment only has one patient --}}

@endsection
@section('jsAjax')
<script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
@endsection

{{-- patient register form
full name, phone number, email, username, password
username must unique

patient login form
username, password

appointment form
date, disease, speciality, additional_message, status, id_doctors --}}