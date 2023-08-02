@extends('layouts.main')
@section('container')
<div class="col-sm-12 col-xs-12 d-flex justify-content-center">
    <div
        class="profileContainer reviewContainer col-11 col-xl-9 d-flex flex-column justify-content-center align-items-center">
        <div class="imgGallery rounded-top col-12 bg-secondary">
            <img src="{{ asset('img/doctor.jpg') }}" alt="">
        </div>

        <div class="d-flex flex-column justify-content-start col-sm-12 col-12 col-md-11 col-lg-9">
            <div class="profileHeader reviewHeader">
                <h2>Dr .
                    {{$doctor['first_name']}}
                    {{ $doctor['last_name'] }}
                </h2>
                <p>
                    {{ $doctor['location'] }}
                </p>
            </div>
            <form action="" method="post" class="d-flex bg-secondary-subtle col-sm-5 col-8 justify-content-around py-1">
                <div>
                    <a href=" /profile-page/{{ $doctor['user_name'] }}" class="text-decoration-none">My Profile</a>
                </div>
                <div>
                    <a href="/review-page/{{ $doctor['user_name'] }}" class="text-decoration-none">reviews</a>
                </div>
            </form>
            <div class="mt-2">
                <button type="button" class="btn btn-secondary" data-bs-toggle="modal"
                    data-bs-target="#commentModal">Comment Here</button>
            </div>


            {{-- if (sizeof($data['comment']) > 0) { --}}
            <div class="row d-flex">
                <div class="col-sm-12 col-md-12">
                    <div class="card border border-0">
                        <div class="">

                            @foreach ($doctorComments as $comment)
                            <div class="mb-4 border border-0 ">
                                <div class="shadow p-3 bg-body-tertiary rounded col-12">
                                    <p><span class="fw-bold text-body-tertiary">{{ ($doctorComments ->currentpage()-1) *
                                            $doctorComments ->perpage() +
                                            $loop->index +
                                            1}}</span> {{ $comment->comment }}</p>
                                    <div class="d-flex justify-content-start">
                                        <div class="d-flex flex-row align-items-center">
                                            <p class="ms-2 text-secondary">- {{ $comment->patient->user_name }}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            @endforeach
                            @if ($doctorComments->links()->paginator->hasPages())
                            <div class="mt-4 p-4 box has-text-centered">
                                {{ $doctorComments->links() }}
                            </div>
                            @endif
                            {{-- {{ $doctorComments->links() }} --}}
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>



<div class="modal-dialog modal-dialog-scrollable">
    <div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog mx-auto" style="margin-top: 150px; width:90vw; min-width:276px; max-width:600px;">
            <div class="modal-content register-patient-modal-content ">
                <!-- Section: Design Block -->
                <section class="text-center">
                    <!-- Background image -->
                    <div class="pt-5 bg-image" style="
          background-image: url('https://mdbootstrap.com/img/new/textures/full/171.jpg');
          height: 300px;
          ">
                        <div class="register-close-modal-patient d-flex justify-content-end pe-3">
                            <button type="button" data-bs-dismiss="modal"><i
                                    class="fa-solid fa-xmark text-end"></i></button>
                        </div>
                        <h1>Comment</h1>
                        <p>Comment As A Patient Here</p>
                    </div>
                    <!-- Background image -->

                    <div class="card mx-3 shadow-5-strong  mb-5 modalInputCard" style="
          margin-top: -140px;
          background: hsla(0, 0%, 100%, 0.8);
          backdrop-filter: blur(30px);
          ">
                        <div class="card-body pb-2 success-comment">

                            <div class="row d-flex justify-content-center ">
                                <div class="col-md-12">
                                    {{-- form --}}
                                    @foreach ($doctorComments as $comment)
                                    <form action="/review-page/{{ $comment->doctor->user_name }}" method="post"
                                        enctype="multipart/form-data" id="doctor-comment-form">
                                        @endforeach
                                        @csrf
                                        {{-- comment input --}}
                                        <div class="mb-4">
                                            <div class="form-floating">
                                                <textarea class="form-control comment_error"
                                                    value="{{ old('comment') }}" name="comment" id="floatingTextarea2"
                                                    style="height: 150px"></textarea>
                                                <label for="floatingTextarea2">Comments</label>
                                            </div>
                                            <p class="text-danger comment_error"></p>
                                        </div>
                                        {{-- <input value="{{ old('comment') }}" name="comment" type="comment"
                                            id="form3Example4" class="form-control  comment_error"
                                            style="height: 100px" /> --}}

                                        <!-- Submit button -->
                                        <button type="submit" class="btn btn-outline-primary btn-sm btn-block mb-4"
                                            id="doctor-comment-btn">
                                            submit
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
@endsection

@section('jsAjax')
<script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
@endsection