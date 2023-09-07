<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
    <link rel="stylesheet" href="{{ asset('css/bootstrap.min.css') }}">
    <link rel="stylesheet" href="{{ asset('css/jquery-ui.min.css') }}">
    <link rel="stylesheet" href="{{ asset('css/jquery.timepicker.min.css') }}">

    <link rel="stylesheet" href="{{ asset('css/all.css') }}">


    <title>
        {{ $title }}
    </title>
    {{--
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    --}}
</head>


<body>

    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
        <symbol id="check-circle-fill" viewBox="0 0 16 16">
            <path
                d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" />
        </symbol>
        <symbol id="info-fill" viewBox="0 0 16 16">
            <path
                d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z" />
        </symbol>
        <symbol id="exclamation-triangle-fill" viewBox="0 0 16 16">
            <path
                d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
        </symbol>
    </svg>
    <div class="dashboard-sidebar dashboard-bar-block dashboard-collapse dashboard-card"
        style="width:250px; z-index:10000;" id="mySidebar">
        {{-- <div class="sidebarImg">
            <img src="" style="width:50%;" alt="">
        </div> --}}
        <button class="dashboard-bar-item dashboard-button dashboard-hide-large" onclick="dashboard_close()">Close
            &times;</button>
        <a href="/dashboard" class="dashboard-bar-item dashboard-button "><i
                class="fa-sharp fa-solid fa-table-columns me-2"></i>Dashboard</a>
        <a href="/dashboard/appointment-request" class="dashboard-bar-item dashboard-button "><i
                class="fa-solid fa-bars-progress me-2"></i>Appointment Request</a>
        <a href="/dashboard/appointment-approve" class="dashboard-bar-item dashboard-button"><i
                class="fa-solid fa-person-circle-check me-2"></i>Approved
            Appointment</a>
        <a href="/dashboard/appointment-cancel" class="dashboard-bar-item dashboard-button"><i
                class="fa-solid fa-person-circle-xmark me-2"></i>Cancelled
            Appointment</a>
        <a href="/dashboard/appointment-today" class="dashboard-bar-item dashboard-button ">
            <i class="fa-solid fa-calendar-week me-2"></i>Today Appointment
        </a>
        <!-- <a href="/Doctors/searchDashboardPage/" class="dashboard-bar-item dashboard-button "> Search</a> -->

        <button class="dashboardDropdown-btn"><i class="fa-solid fa-magnifying-glass me-2"></i>Search
            <i class="fa fa-caret-down"></i>
        </button>
        <div class="dashboardDropdown-container">
            <a href="/dashboard/appointment-search-by-name"><i class="fa-solid fa-file-signature me-2"></i>By Name</a>
            <a href="/dashboard/appointment-search-by-date"><i class="fa-solid fa-calendar-days me-2"></i>By Date</a>
        </div>

        <!-- <a href="/Doctors/reportDashboardPage/class="dashboard-bar-item dashboard-button">Report</a> -->
        <form action="/doctors/logout" method="POST">
            <a href="" class="dashboard-bar-item dashboard-button" style="padding: 0">
                <button type="submit" class="border border-0 bg-transparent text-white text-start ps-3"
                    style="min-width:100%; min-height:100%">
                    @csrf
                    <span class="doctorLogout"><i class="fas fa-sign-out fa-xs"></i>
                        Logout</span>
                </button>
            </a>
        </form>
    </div>

    <div class="dashboard-main" style="margin-left:230px">

        <div class="dashboard-teal">
            <div class="dashboard-container ">
                <button class="dashboard-button dashboard-teal dashboard-xlarge dashboardBurger"
                    onclick="dashboard_open()">&#9776;</button>
                <h1>

                </h1>
            </div>
            <div class="dashboard-container profileBar2">
                <a href="/dashboard/{{ $doctor->user_name }}/edit"><i class="far fa-user"></i></a>
                <img style="border-radius:100%;" src="{{ asset('storage/' . $doctor->user->profile_photo_path) }}"
                    alt="">
            </div>
        </div>
    </div>

    <div class="{{ $container }}">
        @yield('container')
    </div>
</body>

<script type="text/javascript" src="{{ asset('js/jquery-3.7.0.min.js') }}"></script>
<script src="{{ asset('js/bootstrap.min.js') }}"></script>
<script src="{{ asset('js/jquery-ui.min.js') }}"></script>
<script src="{{ asset('js/jquery.timepicker.min.js') }}"></script>
@yield('jsAjax')

<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>

{{-- <script type="text/javascript" src="{{ asset('js/dashboard.js') }}"></script>
<script type="text/javascript" src="{{ asset('js/review.js') }}"></script> --}}
{{-- <script type="text/javascript" src="{{ asset('js/app.js') }}"></script> --}}

</html>