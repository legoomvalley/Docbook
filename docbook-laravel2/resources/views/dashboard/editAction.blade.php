@extends('layouts.dashboardMain')
@section('container')

{{-- @dd($todayAppointmentAll['time']) --}}

<div
    class="editActionContainer container shadow p-3 mb-5 bg-body-tertiary rounded request-form-container mt-5 col-11 col-sm-10 col-sm-7 col-md-7 col-lg-6 col-xl-4 mx-auto">
    <!-- Content here -->

    <div class="homeDashboard" style="">
        <div class=" ">
            <div class="">
                <main class="form-signin w-100 mx-auto mb-5 pt-5">
                    <form method="post"
                        action="/dashboard/patients/{{  $appointment->patient->user_name }}/appointments/{{ $appointment->id }}">
                        @csrf
                        <h5 class="mb-3 fw-normal">Send Your Result for <span class="fw-bold text-body-tertiary">{{
                                $patient->full_name }}</span></h5>

                        <div class="">


                            {{-- specialization --}}
                            <select name="status" class="form-select @error('status') is-invalid  @enderror">
                                {{-- @dd($specializations) --}}
                                <option value="">Select Status</option>
                                @if ( $appointment->status == "Pending")
                                <option value="Approved">Approved</option>
                                <option value="Not Approved">Not Approved</option>
                                @else
                                <option value="{{old('status', $appointment->status)}}" selected
                                    class="text-body-tertiary">{{old('status',
                                    $appointment->status)}}</option>
                                <option value="Approved">Approved</option>
                                <option value="Not Approved">Not Approved</option>
                                @endif
                            </select>
                        </div>
                        @error('status')
                        <div class="ms-1 text-danger">
                            {{ $message }}
                        </div>
                        @enderror
                        <div class="mt-3">
                            <label class="ms-2" for="floatingPassword">Date</label>
                            <input type="text" class="form-control @error('date') is-invalid  @enderror" name="date"
                                id="datePickerDashboard3" placeholder="Date"
                                value="{{ old('date', $appointment->date) }}">
                        </div>
                        @error('date')
                        <div class="ms-1 text-danger">
                            {{ $message }}
                        </div>
                        @enderror
                        <div class="mt-3">
                            <label class="ms-2" for="floatingPassword">Time</label>
                            <input type="text" class="form-control @error('time') is-invalid  @enderror" name="time"
                                id="timePicker" placeholder="Time" value="{{ old('time', $appointment->time) }}">
                        </div>
                        @error('time')
                        <div class="ms-1 text-danger">
                            {{ $message }}
                        </div>
                        @enderror
                        <div class="mt-3">
                            <label class="ms-2">Additional Message</label>
                            <input type="text"
                                class="align-self-start form-control @error('remark') is-invalid  @enderror"
                                name="remark" id="floatingPassword" value="" style="height: 120px; padding-bottom:90px">
                        </div>
                        @error('remark')
                        <div class="ms-1 text-danger">
                            {{ $message }}
                        </div>
                        @enderror

                        <button class="w-100 btn btn-lg btn-primary mt-3" type="submit">Submit</button>
                    </form>
                </main>
            </div>
            @endsection
        </div>
    </div>
</div>
@section('jsAjax')
<script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script>
@endsection
<!-- Trigger/Open The Modal -->
<!-- <button id="myBtn">Open Modal</button> -->