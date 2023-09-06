<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TmpComment extends Model
{
    use HasFactory;

    // public $timestamps = false;
    protected $guarded = ['id'];


    public function patient()
    {
        return $this->belongsTo(User::class, 'patient_id')->with('patient');
    }

    public function doctor()
    {
        return $this->belongsTo(User::class, 'doctor_id')->with('doctor');
    }
}
