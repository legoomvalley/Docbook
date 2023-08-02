<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Admin;
use App\Models\Doctor;
use App\Models\Comment;
use App\Models\Patient;
use App\Models\TmpDoctor;
use App\Models\Appointment;
use App\Models\Specialization;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        //     Specialization::create([
        //         'name' => 'Pediatrics'
        //     ]);
        //     Specialization::create([
        //         'name' => 'General Medicine'
        //     ]);
        //     Specialization::create([
        //         'name' => 'Eye Specialist'
        //     ]);
        //     Specialization::create([
        //         'name' => 'Orthopedics'
        //     ]);

        Admin::create([
            'user_name' => "muaz",
            'password' => Hash::make('123')
        ]);

        // Doctor::factory(9)->create();

        // Patient::factory(10)->create();

        // Appointment::factory(50)->create();
        // // TmpDoctor::factory(20)->create();


        // Comment::factory(100)->create();

        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }
}

// Pediatrics
// Eye Specialist
// General Medicine
// Orthopedics