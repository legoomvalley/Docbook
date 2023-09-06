<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Appointment extends Model
{
    use HasFactory;

    public $timestamps = true;
    protected $guarded = ['id'];


    // one appointment can has one patient and one doctor
    public function doctor()
    {
        return $this->belongsTo(Doctor::class, 'doc_id');
    }


    public function patient(): BelongsTo
    {
        return $this->belongsTo(Patient::class, "patient_id");
    }
}
