<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Patient>
 */
class PatientFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'user_name' => $this->faker->unique()->sentence(1),
            'password' => Hash::make('123'),
            'phone_no' => $this->faker->phoneNumber(),
            'patient_id' => $this->faker->unique()->numberBetween(11, 20),
        ];
    }
}
