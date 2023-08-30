<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class UsersController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
    public function logout()
    {
        $user = Auth::user();
        $user->currentAccessToken()->delete();
        return response()->json([
            'success' => 'Logout successfully!'
        ], 200);
    }
    public function uploadProfileImage(Request $request)
    {
        $id = Auth::user()->id;

        $user = User::findOrFail($id);

        if ($request->hasFile('profile_photo')) {
            $profilePhoto = $request->file('profile_photo');
            $profilePhotoPath = $profilePhoto->store('profile_photos', 'public');
            $user->profile_photo_path = $profilePhotoPath;
            $user->save();
        }

        return $user->profile_photo_path;
    }
}
