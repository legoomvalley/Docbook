<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    @yield('container')
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