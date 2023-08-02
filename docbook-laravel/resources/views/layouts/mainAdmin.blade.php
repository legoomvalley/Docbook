<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="csrf-token" content="{{ csrf_token() }}" />


    <title>{{ $title }}</title>

    <!-- Custom fonts for this template-->
    <link href="{{ asset('vendor/fontawesome-free/css/all.css') }}" rel="stylesheet" type="text/css">
    <link {{-- <link href="{{ asset('../vendor/admin/fontawesome-free/css/all.css') }}" rel="stylesheet"
        type="text/css">
    <link --}}
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    {{-- D:\legoom academy\buah\Docbook Laravel\docbook-laravel\vendor\admin\fontawesome-free\css\all.min.css --}}

    <!-- Custom styles for this template-->

    <link href="{{ asset('css/sb-admin.min.css') }}" rel="stylesheet">
    <link rel="stylesheet" href="{{ asset('css/bootstrap.min.css') }}">

    <link rel="stylesheet" href="{{ asset('css/all.css') }}">


</head>

<body id="page-top" class="sidebar-toggled">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">Docbook Admin</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="/admin/dashboard">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Home</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Information
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fa-solid fa-user-doctor"></i>
                    <span>Doctor</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">

                        <div class="dropdown sidebarDropdown">
                            <a class="collapse-item d-block" href="{{ route('admin.createDoctor') }}">Add Doctor
                            </a>

                        </div>

                        <div class="dropdown sidebarDropdown">
                            <a class="d-block collapse-item" href="#" role="button" data-bs-toggle="dropdown">
                                Search
                            </a>
                            <ul class="dropdown-menu sidebarDropdownMenu">
                                <li><a class="dropdown-item" href="{{ route('admin.showDoctorByCategory') }}">By
                                        Category</a></li>
                                <li><a class="dropdown-item" href="{{ route('admin.showDoctorBySearch') }}">By Name</a>
                                </li>
                            </ul>
                        </div>

                    </div>
                </div>
            </li>


            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
                    aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="fa-solid fa-bed-pulse fa"></i>

                    <span>Patient</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <div class="dropdown sidebarDropdown">
                            <a class="collapse-item d-block" href="{{ route('admin.createPatient') }}">Add Patient
                            </a>
                        </div>
                        <div class="dropdown sidebarDropdown">
                            <a class="collapse-item d-block" href="{{ route('admin.commentPage') }}">Pending Comment
                            </a>
                        </div>
                        <div class="dropdown sidebarDropdown">
                            <a class="d-block collapse-item" href="#" role="button" data-bs-toggle="dropdown">
                                Search
                            </a>
                            <ul class="dropdown-menu sidebarDropdownMenu">
                                <li><a class="dropdown-item" href="{{ route('admin.showPatientBySearch') }}">By Name</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Nav Item - Charts -->
            {{-- <li class="nav-item">
                <a class="nav-link" href="">
                    <i class="fa-solid fa-user"></i>
                    <span>Your Data</span></a>
            </li> --}}

            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link">
                    {{-- <i class="fa-solid fa-right-from-bracket"></i>
                    <span>Logout</span> --}}
                    <form action="/admin-logout" method="POST">
                        @csrf
                        <button type="submit" class="border border-0 bg-transparent">
                            <i class="fas fa-sign-out fa-xs"></i>
                        </button>
                        <span>Logout</span>
                    </form>
                </a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                </nav>
                <!-- End of Topbar -->


                @yield('container')



                <!-- Bootstrap core JavaScript-->
                <script src="{{asset('vendor/jquery/jquery.js ')}}"></script>
                <script src="{{asset('vendor/jquery-easing/jquery.easing.js')}}"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                    integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
                    crossorigin="anonymous">
                </script>
                <script src="{{ asset('js/bootstrap.min.js') }}"></script>
                <script src="{{asset('vendor/bootstrap/js/bootstrap.bundle.js')}}"></script>

                <!-- Core plugin JavaScript-->

                <!-- Custom scripts for all pages-->
                <script src="{{asset('js/sb-admin-2.min.js')}}"></script>
                @yield('jsAjax')

                <!-- Page level plugins -->

                <!-- Page level custom scripts -->

</body>

</html>