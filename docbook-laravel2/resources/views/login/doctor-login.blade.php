@extends('layouts.main2')

@section('container')
<div class="signInContainer">

    @if(session()->has('success'))
    <div class="d-flex justify-content-center mx-2">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <div class="text-center"><i class="fa-regular fa-circle-check"></i></i>
                <p>{{ session('success') }}</p>
            </div>
            <button type="button" class="btn-close mt-1" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </div>

    @endif
    <div class="signInContainer2">

        <div class="signInImg">
            <img src="{{ asset('img/signinPic.png') }}" alt="">
        </div>
        <div class="signInForm">
            <h1>Sign In</h1>
            <p>sign as doctor here</p>
            @if(session()->has('error'))
            <div class="d-flex justify-content-center">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <div class="text-center"><i class="fa-solid fa-square-xmark"></i>
                        {{ session('error') }}
                    </div>

                    <button type="button" class="btn-close mt-1" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </div>
            @endif
            <form action="/doctors/login" method="POST">
                @csrf
                <label for="fname" style="display: block;">Username</label>
                {{-- --}}
                <input type="text" id="fname" name="user_name"
                    class="@error('user_name') invalidInputFeedback @enderror" placeholder="Username" autofocus
                    value="{{ old('user_name') }}">
                @error('user_name')
                <div class="text-danger">{{ $message }}</div>
                @enderror


                <label for="password" style="display: inline-block; margin-top: 5px">Password</label>
                {{-- --}}
                <input type="password" id="password" class="@error('password') invalidInputFeedback @enderror"
                    name="password" placeholder="Password">
                @error('password')
                <div class="text-danger">{{ $message }}</div>
                @enderror
                <div class="registerLinkContainer">
                    <a href="/doctors/register" data-toggle="modal" data-target="#login-modal"
                        class="registerLink">register here
                    </a>
                </div>
                <div class="loginBtn">
                    <button type="submit" name="login">sign in</button>
                </div>
            </form>
        </div>
    </div>
</div>


@endsection