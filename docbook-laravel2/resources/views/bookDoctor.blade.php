@extends('layouts.main')

@section('container')
<main class="form-signin" style="z-index: 1000">
    <div class="row justify-content-center justify-self-center justify-item-center mx-auto bg-body-secondary py-5"
        style="max-width: 1400px">
        <div class=" patientAppointmentHome col-sm-11 col-md-11 col-lg-9 col-xxl-7 col-xl-8 py-5">
            <form action="/book-doctor/{{ $doctor['user_name'] }}" method="POST">
                @csrf

                {{-- form 2 --}}
                {{-- <div class="form2"> --}}
                    <p class="text-center fw-bold text-uppercase">make appointment with Dr.{{ $doctor['first_name'] }}
                        {{
                        $doctor['last_name']
                        }}</p>

                    @if(session()->has('success'))
                    <div class="d-flex justify-content-center">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <div class="text-center"><i class="fa-sharp fa-solid fa-square-check me-1"></i> {{
                                session('success') }} <a
                                    href="/check-appointment/{{  Auth::guard('patient')->user()->user_name   }}">here</a>

                            </div>

                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </div>
                    @endif
                    <div class="mb-1 dateTime">
                        {{-- date --}}
                        <div class="mb-1 input">
                            <label for="floatingInput" class="text-body-tertiary">Date</label>
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
                            <label for="floatingInput" class="text-body-tertiary">Time</label>
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
                            <label for="floatingInput" class="text-body-tertiary">Disease</label>
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
                            <label for="floatingInput" class="text-body-tertiary">Select Specialization</label>
                            <select name="specialization_id" class="form-select">
                                @foreach ($specializations as $specialization)
                                <option value="{{ $specialization->id }}">{{ $specialization->name }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    <div class="mb-1">


                        {{-- additional Message --}}
                        <label for="floatingInput" class="text-body-tertiary">Additional Message</label>
                        <textarea value="{{ old('additional_message') }}" name="additional_message" type="text"
                            class="form-control rounded-end @error('additional_message') is-invalid  @enderror"
                            id="floatingInput" rows='3'></textarea>
                        @error('additional_message')
                        <div class="invalid-feedback">
                            {{ $message }}</div>
                        @enderror
                    </div>



                    <div class="d-grid col-4 mx-auto mt-3">
                        <button class="btn btn-lg btn-primary" type="submit">Submit</button>
                    </div>
                    {{--
                </div> --}}

            </form>
        </div>
    </div>
</main>
@endsection
@section('jsAjax')
<script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
@endsection


{{--
jumlah doctor
jumlah patient

delete patient
edit patient


--}}