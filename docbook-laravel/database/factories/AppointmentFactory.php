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
            'full_name' => $this->faker->sentence(5),
            'time' => $this->faker->time(),
            'disease' => $this->faker->sentence(1),
            'additional_message' => $this->faker->sentence(10),
            'specialization_id' => mt_rand(1, 4),
            'remark' => $this->faker->sentence(10),
            'status' => $this->faker->randomElement(['Approved', 'Not Approved', 'Pending']),
            'patient_id' => mt_rand(1, 10),
            'doctor_id' => mt_rand(1, 9),
        ];
    }
}

// date, time, disease, specialization_id, additional_message,remark, status patient_id(1-9), doctor_id(1-8);