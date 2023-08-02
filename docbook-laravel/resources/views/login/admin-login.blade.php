@extends('layouts.main3')

@section('container')



<div class="d-flex justify-content-center align-items-center" style="height: 80vh;">
    <div class="bg-body-tertiary col-12 col-md-9 col-lg-5 pt-4 pb-5 px-5 shadow">
        <main class="form-signin">
            <form action="/admin" method="POST">
                @csrf
                <h1 class="h3 mb-3 fw-normal">Welcome!</h1>
                <p class="">Sign in as admin here</p>
                @if(session()->has('error'))
                <div class="d-flex justify-content-center">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <div class="text-center"><i class="fa-solid fa-square-xmark"></i>
                            {{ session('error') }}
                        </div>

                        <button type="button" class="btn-close mt-1" data-bs-dismiss="alert"
                            aria-label="Close"></button>
                    </div>
                </div>
                @endif

                <div class="form-floating">
                    <input type="text" class="form-control rounded-0 @error('user_name') is-invalid @enderror"
                        id="floatingInput" name="user_name" autofocus value="{{ old('user_name') }}">
                    <label for="floatingInput">Username</label>
                    @error('user_name')
                    <p class="text-danger">
                        {{$message}}
                    </p>
                    @enderror
                </div>
                <div class="form-floating">
                    <input type="password" class="form-control rounded-0 @error('password') is-invalid @enderror"
                        name="password" value="{{ old('password') }}" id="floatingPassword">
                    <label for="floatingPassword">Password</label>
                    @error('password')
                    <p class="text-danger">
                        {{$message}}
                    </p>
                    @enderror
                </div>

                <div class="checkbox mb-3">
                </div>
                <button class="w-100 btn btn-lg btn-primary" type="submit">Sign in</button>
            </form>
        </main>
    </div>
</div>



@endsection