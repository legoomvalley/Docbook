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
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * 
    php artisan migrate:refresh --path='database/migrations/2023_06_06_035148_create_appointments_table.php'
     * Seed the application's database.
     */
    public function run(): void
    {
        // Specialization::create([
        //     'name' => 'Pediatrics'
        // ]);
        // Specialization::create([
        //     'name' => 'General Medicine'
        // ]);
        // Specialization::create([
        //     'name' => 'Eye Specialist'
        // ]);
        // Specialization::create([
        //     'name' => 'Orthopedics'
        // ]);

        // Admin::create([
        //     'user_name' => "muaz",
        //     'password' => Hash::make('123')
        // ]);

        // User::factory(10)->create();

        // TmpDoctor::factory(10)->create();
        // 
        // Doctor::factory(10)->create();

        // Comment::factory(1)->create();
        Appointment::factory(40)->create();


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