@extends('layouts.main')

@section('container')
<!-- <div class="allDoctorImg">
        <img src="/img/doctorProfilePicture.png" alt="">
    </div> -->
<div class="col-sm-12 col-xs-12 d-flex justify-content-center">
    <div class="profileContainer  col-11 col-xl-9 d-flex flex-column justify-content-center align-items-center">
        <div class="imgGallery bg-secondary rounded-top col-12">
            <img src="{{ asset('img/doctor.jpg') }}" alt="">
        </div>

        <div class="d-flex flex-column justify-content-start col-sm-12 col-xs-12 col-md-11 col-lg-9">
            <div class="profileHeader">
                <h2>Dr .
                    <?= $doctor->user->name; ?>
                </h2>
                <p>
                    <?= $doctor['location']; ?>
                </p>
            </div>
            <form action="" method="post" class="d-flex bg-secondary-subtle col-sm-5 col-8 justify-content-around py-1">
                <div>
                    <a href="/profile-page/{{ $doctor['user_name'] }}" class="text-decoration-none">My
                        Profile</a>
                </div>
                <div>
                    <a href="/review-page/{{ $doctor['user_name'] }}" class="text-decoration-none">reviews</a>
                </div>
            </form>
            <!-- <div style="margin-top: 60px;"> -->
            <div class="profileInformation">
                <h3>Name:</h3>
                <p>
                    <?= $doctor->user->name; ?>
                </p>
            </div>
            <div class="profileInformation">
                <h3>Email:</h3>
                <p>
                    <?= $doctor->user->email ?>
                </p>
            </div>
            <div class="profileInformation profileInformation3">
                <h3>Phone:</h3>
                <p>
                    <?= $doctor['mobile_number']; ?>
                </p>
            </div>
            <div class="profileInformation profileInformation4">
                <h3>Total experience:</h3>
                <p>
                    <?= $doctor['experience_year']; ?> year
                </p>
            </div>
            <div class="profileInformation profileInformation5">
                <h3>Specilization:</h3>
                <p>
                    <?= $doctor['specialization']->name; ?>
                </p>
            </div>
            <div class=" profileBtn mb-5 mt-5 ms-5">
                <button data-bs-toggle="modal" data-bs-target="#appointmentModal"
                    class="px-3 rounded-3 shadow align-middle">Book
                    Now</button>
            </div>
        </div>
        <!-- </div> -->
    </div>
</div>





{{-- modal --}}
<div class="modal-dialog modal-dialog-scrollable">
    <div class="modal fade" id="appointmentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content register-patient-modal-content">
                <!-- Section: Design Block -->
                <section class="text-center">
                    <!-- Background image -->
                    <div class="p-5 bg-image" style="
          background-image: url('https://mdbootstrap.com/img/new/textures/full/171.jpg');
          height: 300px;
          ">
                        {{-- <div class="register-close-modal-patient">
                            <button type="button" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                        </div> --}}
                        <div class="register-close-modal-patient d-flex justify-content-end">
                            <button type="button" data-bs-dismiss="modal"><i
                                    class="fa-solid fa-xmark text-end"></i></button>
                        </div>
                        <p>Make Appointment with Dr.{{ $doctor->user->name}}</p>
                    </div>
                    <!-- Background image -->

                    <div class="card mx-2 mx-sm-4 shadow-5-strong  mb-5 pb-3" style="
          margin-top: -160px;
          background: hsla(0, 0%, 100%, 0.8);
          backdrop-filter: blur(10px);
          ">
                        <div class="card-body pt-2">

                            <div class="row d-flex justify-content-center appointment-container">
                                <div class="form1">
                                    {{-- form --}}
                                    {{-- date, time, disease, pediatrics, additional message --}}
                                    <form action="{{ $doctor['user_name'] }}/make-appointment" method="post"
                                        enctype="multipart/form-data" id="patient-appointment-form">
                                        @csrf
                                        <!-- date Input -->
                                        <div class=" d-flex flex-column">
                                            <label for="datePicker"
                                                class="form-label text-start fw-bold text-body-tertiary ">Date</label>
                                            <input value="{{ old('date') }}" name="date" type="text" placeholder="Date"
                                                class="form-control date_error datePicker" readonly />
                                            <p class="text-danger date_error"></p>
                                        </div>
                                        {{-- time Input --}}
                                        <label for="timePicker" class="text-start fw-bold text-body-tertiary"
                                            style="width: 100%">Time</label>
                                        <div class="mb-1 input-group" style="z-index: 9999 ">
                                            <input id="timePicker" type="text" name="time"
                                                class="form-control input-small rounded time_error" placeholder="Time"
                                                readonly>
                                        </div>
                                        <p class="text-danger time_error"></p>
                                        <!-- disease input -->
                                        <div class="mb-1 d-flex flex-column">
                                            <label for="form3Example4"
                                                class="form-label text-start fw-bold text-body-tertiary">Disease</label>
                                            <input value="{{ old('disease') }}" name="disease" type="text"
                                                id="form3Example3" placeholder="disease" class="form-control" />
                                            <p class="text-danger disease_error"></p>
                                        </div>
                                        <!-- speciality input -->
                                        <div class="mb-1 d-flex flex-column">
                                            <label for="form3Example4"
                                                class="form-label text-start fw-bold text-body-tertiary">Specialization</label>
                                            <select name="specialization_id" class="form-select">
                                                @foreach ($specializations as $specialization)
                                                <option value="{{ $specialization->id }}">{{ $specialization->name
                                                    }}
                                                </option>
                                                @endforeach
                                            </select>
                                            <p class="text-danger"></p>
                                        </div>
                                        <!-- Submit button -->
                                        <button type="submit" class="btn btn-outline-primary btn-block"
                                            id="patient-appointment-btn">
                                            Book Now
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

<!-- name, email, phone, location, specialization -->
@endsection
@section('jsAjax')
<script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
@endsection