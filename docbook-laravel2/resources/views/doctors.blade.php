@extends('layouts.main')

@section('container')
<div class="generalContainer">


    <div class="allDoctorContainer">
        <div class="doctorListBar">
            <form action="/all-doctors/specialization" method="post">
                @csrf
                <select id="specialization" name="specialization" aria-placeholder="select speciality"
                    onchange="this.form.submit()">
                    <option id="select" value=" select" disabled selected>Select Speciality</option>
                    <option id="all" value="all">All Doctors</option>

                    @foreach ($specializationName as $s)
                    {{-- @dd($d) --}}
                    <option value="{{ $s->id }}">{{ $s->name }}
                    </option>
                    @endforeach
                </select>
            </form>
            <!-- </form> -->
        </div>
        <div class="searchLi mb-5">
            <form action="/all-doctors">
                <div class="search-root">
                    <div class="search-container">
                        <button class="searchBtnNav" type="submit">
                            <i class='fas fa-search fa-xs' style='color:#4c84c3'></i>
                        </button>
                        <input type="text" placeholder="Search for doctor's name..." name="searchDoctor"
                            value="{{ request('searchDoctor') }}">
                    </div>
                </div>
            </form>
        </div>
        @auth('patient')
        @if(isset($doctorsSpecialization) && $doctorsSpecialization->count() )
        {{-- <p class="doctorListMessage">{{ $option }}</p> --}}
        <p class="doctorListMessage">
            @if (empty(request('searchDoctor')))
            {{ $option }}
            @else
            Search results for: "{{ request('searchDoctor') }}"
            @endif
        </p>
        @foreach ($doctorsSpecialization as $item)
        <div class="allDoctorLists">
            <div class="allDoctorImg">
                <img src="{{ asset('img/doctor.jpg') }}" alt="">
            </div>
            <div class="doctorGeneralInformation">
                <div class="list1">
                    <a href="/profile-page/{{ $item->doctor->user_name }}">
                        <h1>
                            {{ $item->name }}
                        </h1>
                    </a>
                    <p class="bg-info border border-0 py-2 px-2 rounded-4 shadow-sm fw-bold text-white">

                        {{ $item->doctor->status }}
                    </p>
                </div>


                <div class="generalInformation">
                    {{-- $_SESSION['specialization'] = $item['Specialization'] --}}
                    <a href="/profile-page/{{ $item->doctor->user_name }}">
                        <h2>
                            {{$item->doctor->specialization->name }}
                        </h2>
                    </a>
                    <div class="list2">
                        <p>
                            {{$item->doctor->bio_data }}
                        </p>
                        <br>
                        <p>
                            Expereience : {{$item->doctor->experience_year }} year
                        </p>
                    </div>
                </div>
            </div>
            <div class="allDoctorBookBtn">
                <a href="/profile-page/{{ $item->doctor->user_name }}" class="text-decoration-none">Book Now</a>
            </div>
        </div>
        <div class="allDocListLine">
            <hr class="text-primary">
        </div>

        @endforeach
        @elseif ($doctors->count() && !isset($doctorsSpecialization))
        <p class="doctorListMessage">
            @if (empty(request('searchDoctor')))
            @else
            Search results for: "{{ request('searchDoctor') }}"
            @endif
        </p>
        @foreach ($doctors as $item)

        <div class="allDoctorLists">
            <div class="allDoctorImg">
                <img src="{{ asset('img/doctor.jpg') }}" alt="">
                <div class="smallDoctorBtn justify-content-center mt-2">
                    <a href="/profile-page/{{ $item->doctor->user_name }}" class="btn btn-primary btn-sm">Book Now</a>
                </div>
            </div>
            <div class="doctorGeneralInformation">
                <div class="list1">
                    <a href="/profile-page/{{ $item->doctor->user_name }}">
                        <h1>
                            {{ $item->name }}
                        </h1>
                    </a>
                    <p class="bg-info border border-0 py-2 px-2 rounded-4 shadow-sm fw-bold text-white">
                        {{ $item->doctor->status }}
                    </p>
                </div>


                <div class="generalInformation">
                    {{-- $_SESSION['specialization'] = $doctor['Specialization'] --}}
                    <a href="/profile-page/{{ $item->doctor->user_name }}">
                        <h2>
                            {{$item->doctor->specialization->name }}
                        </h2>
                    </a>
                    <div class="list2">
                        <p>
                            {{$item->doctor->bio_data }}
                        </p>
                        <br>
                        <p>
                            Expereience : {{$item->doctor->experience_year }} year
                        </p>
                    </div>
                </div>
            </div>
            <div class="allDoctorBookBtn">
                <a href="/profile-page/{{ $item->doctor->user_name }}" class="text-decoration-none">Book Now</a>
            </div>
        </div>
        <div class="allDocListLine">
            <hr class="text-primary">
        </div>

        @endforeach

        @else
        <div class="allDoctorLists" style="justify-content: center">
            <h1 style="text-align: center">no doctors found...</h1>
        </div>
        @endif

        {{--the else means not auth patient --}}
        {{-- ============================================================================== --}}
        @else
        @if(isset($doctorsSpecialization) && $doctorsSpecialization->count() )
        {{-- @dd($doctorsSpecialization->count()) --}}

        <p class="doctorListMessage">{{ $option }}</p>
        @foreach ($doctorsSpecialization as $item)
        <div class="allDoctorLists">
            <div class="allDoctorImg">
                <img src="{{ asset('img/doctor.jpg') }}" alt="">
            </div>
            <div class="doctorGeneralInformation">
                <div class="list1">
                    <h1 class="me-2">
                        {{ $item->name }}
                    </h1>
                    <p class="bg-info border border-0 py-2 px-2 rounded-4 shadow-sm fw-bold text-white">
                        {{ $item->doctor->status }}
                    </p>
                </div>


                <div class="generalInformation">
                    {{-- $_SESSION['specialization'] = $item['Specialization'] --}}
                    <h2>
                        {{-- {{$item['specialization']->name }} --}}
                    </h2>
                    <div class="list2">
                        <p>
                            {{$item->doctor->bio_data }}
                        </p>
                        <br>
                        <p>
                            Expereience : {{$item->doctor->experience_year }} year
                        </p>

                    </div>
                </div>
            </div>
        </div>
        <div class="allDocListLine">
            <hr class="text-primary">
        </div>

        @endforeach
        @elseif ($doctors->count() && !isset($doctorsSpecialization))
        <p class="doctorListMessage">
            @if (empty(request('searchDoctor')))
            @else
            Search results for: "{{ request('searchDoctor') }}"
            @endif
        </p>
        @foreach ($doctors as $item)

        <div class="allDoctorLists">
            <div class="allDoctorImg">
                <img src="{{ asset('img/doctor.jpg') }}" alt="">
                <div class="smallDoctorBtn justify-content-center mt-2">
                    <a href="/profile-page/{{ $item->doctor->user_name }}" class="btn btn-primary btn-sm">Book Now</a>
                </div>
            </div>
            <div class="doctorGeneralInformation">
                <div class="list1">
                    <h1>
                        {{ $item->name }}
                    </h1>
                    <p class="bg-info border border-0 py-2 px-2 rounded-4 shadow-sm fw-bold text-white">
                        {{ $item->doctor->status }}
                    </p>
                </div>


                <div class="generalInformation">
                    <h2>
                        {{$item->doctor->specialization->name }}
                    </h2>
                    <div class="list2">
                        <p>
                            {{$item->doctor->bio_data }}
                        </p>
                        <br>
                        <p>
                            Expereience : {{$item->doctor->experience_year }} year
                        </p>
                    </div>
                </div>
            </div>

        </div>
        <div class="allDocListLine">
            <hr class="text-primary">
        </div>

        @endforeach

        @else
        <div class="allDoctorLists" style="justify-content: center">
            <h1 style="text-align: center">no doctors found...</h1>
        </div>
        @endif
        @endauth

    </div>
</div>
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