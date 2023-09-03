<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
    <link rel="stylesheet" href="{{ asset('css/bootstrap.min.css') }}">
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


    {{-- navbar --}}
    <nav>
        <ul class="menu2">
            <li class="logo"><a class="navbar2Home" href="/"><img src="https://icon-master.com/i/Hospital/4C84C3"
                        alt=""></a></li>
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
            <div class="quickLinksDiv">
                <h1>Our Place</h1>
                <p>Lorem ipsum, dolor sit amet conse</p>
            </div>
            <div class="departmentsDiv">
                <h1>Departments</h1>
                <p>Eye Care</p>
                <p>General Medicine</p>
                <p>Orthopedics</p>
                <p>Pediatircs</p>
            </div>
            <div>
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
<script src="{{ asset('js/bootstrap.min.js') }}"></script>
<script src="{{ asset('js/jquery-ui.min.js') }}"></script>
<script src="{{ asset('js/jquery.timepicker.min.js') }}"></script>
@yield('jsAjax')

<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
{{-- <script type="text/javascript" src="{{ asset('js/dashboard.js') }}"></script>
<script type="text/javascript" src="{{ asset('js/review.js') }}"></script> --}}
{{-- <script type="text/javascript" src="{{ asset('js/app.js') }}"></script> --}}

</html>