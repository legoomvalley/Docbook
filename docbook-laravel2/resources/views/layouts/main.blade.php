<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Using CSS Backdrop Filters">
    <meta property="og:url" content="https://lourfield.github.io/css-backdrop-filter/" />
    <meta name="csrf-token" content="{{ csrf_token() }}" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=inter">
    <meta property="og:type" content="website" />
    <meta property="og:title" content="CSS Backdrop Filters" />
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
    <link rel="stylesheet" href="{{ asset('sass/main.css') }}">
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
    <!-- Navbar -->

    {{-- navbar --}}
    <nav class="navbarr">
        <ul class="menu">
            <a href="/">
                <li class="logo navbar2Home"><img src="https://icon-master.com/i/Hospital/4C84C3" alt="">
                </li>
            </a>
            <li class="item"><a href="/"
                    class="text-decoration-none text-body {{ ($title === 'home') ? 'fw-bold' : '' }}">Home
                    <hr class="">
                </a></li>
            <li class=" item"><a href="/doctors" class="text-decoration-none text-body {{ ($title === 'doctor list') ? 'fw-bold' : ''
            }}">All Doctors
                    <hr class="">
                </a></li>
            @auth('patient')
            <li class="item"><a href="/patient-record/{{
                \Auth::guard('patient')->user()->user_name }}" class="text-decoration-none text-body {{ ($title === 'search record') ? 'fw-bold' : ''
            }}">Check Appointment
                    <hr class="">
                </a></li>
            <li class="item dropdown-headerr">
                <a class="greetingPatient text-decoration-none text-primary fw-bold font-monospace"><i
                        class="far fa-smile-beam" id="patient-greeting"></i> Welcome,
                    {{
                    \Auth::guard('patient')->user()->user_name }}</a>
                <ul class="nav-dropdown">
                    <div class="nav-dropdown2">
                        {{-- <li><a href="/dashboard"><span><i class="fas fa-columns fa-xs"></i> My Dashboard</span></a>
                        </li> --}}
                        <li>
                            <form action="/patient/{{ Auth::guard('patient')->user()->id }}" method="POST">
                                @csrf
                                <button type="submit" class="">
                                    <span class="doctorLogout"><i class="fas fa-sign-out fa-xs"></i>
                                        Logout</span>
                                </button>
                            </form>
                        </li>
                    </div>
                </ul>
            </li>
            @else
            <li class="item" id="doctor-login"><a href="/doctors/login" class="text-decoration-none text-body">Doctor
                    <hr class="">
                </a>
            </li>
            {{-- <li class="item"><a href="main.html#login">Login</a></li> --}}
            @endauth
            <li class="toggle"><a href="#"><i class="fas fa-bars"></i></a></li>
        </ul>
    </nav>

    <div class="{{ $container }}">
        @yield('container')
    </div>

    {{-- footer --}}

    <div class="footer">
        <div class="firstFooterSection">
            <div>
                <h1>Our CLinic</h1>
                <p>lorem ipsum dolor sit amet</p>
            </div>
            <div>
                <h1>Timing</h1>
                <p>10:30 am to 7:30pm</p>
            </div>
        </div>
        <div class="secondFooterSection">
            <div>
                <li class="logo"><img src="https://icon-master.com/i/Hospital/FFFFFF" />
                </li>
            </div>
            <div class="info1">
                <h1>Our Place</h1>
                <p>Lorem ipsum, dolor sit amet conse</p>
            </div>
            <div class="info2">
                <h1>Departments</h1>
                <p>Eye Care</p>
                <p>General Medicine</p>
                <p>Orthopedics</p>
                <p>Pediatircs</p>
            </div>
            <div class="info3">
                <h1>Timing</h1>
                <p>10:30 am to 7:30pm</p>
            </div>
        </div>
    </div>
    {{-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous">
    </script> --}}
</body>

<script type="text/javascript" src="{{ asset('js/jquery-3.7.0.min.js') }}"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
    integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous">
</script>
<script src="{{ asset('js/bootstrap.min.js') }}"></script>
<script src="{{ asset('js/jquery-ui.min.js') }}"></script>
<script src="{{ asset('js/jquery.timepicker.min.js') }}"></script>
@yield('jsAjax')

<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>

{{-- <script type="text/javascript" src="{{ asset('js/dashboard.js') }}"></script>
<script type="text/javascript" src="{{ asset('js/review.js') }}"></script> --}}
{{-- <script type="text/javascript" src="{{ asset('js/app.js') }}"></script> --}}

</html>