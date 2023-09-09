<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Appointment>
 */
class AppointmentFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'date' => $this->faker->date('Y-m-d'),
            'full_name' => 'Hadley Stroman',
            'time' => $this->faker->time(),
            'disease' => $this->faker->sentence(1),
            'specialization_id' => mt_rand(1, 4),
            'remark' => $this->faker->sentence(10),
            'status' => $this->faker->randomElement(['approved', 'not approved', 'pending', 'completed']),
            'patient_id' => 15,
            'doctor_id' => 148,
        ];
    }
}

// date, time, disease, specialization_id, additional_message,remark, status patient_id(1-9), doctor_id(1-8);