<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Patient extends Authenticatable
{
    use HasFactory;

    protected $guarded = ['id'];


    public function appointments()
    {
        return $this->hasMany(Appointment::class);
    }
    public function comments()
    {
        return $this->hasMany(Comment::class);
    }
}
