<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Model;

class Doctor extends Authenticatable
{
    use HasFactory;

    protected $guarded = ['id'];
    protected $guard = 'doctor';


    public function specialization()
    {
        return $this->belongsTo(Specialization::class);
    }
    public function appointments()
    {
        return $this->hasMany(Appointment::class, 'doctor_id');
    }
    public function comments()
    {
        return $this->hasMany(Comment::class);
    }
    public function patients()
    {
        return $this->hasMany(Patient::class);
    }
    public function user()
    {
        return $this->hasOne(User::class, 'id');
    }
}
