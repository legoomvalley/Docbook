<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TmpDoctor extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    public function specialization()
    {
        return $this->belongsTo(Specialization::class);
    }
}
