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
            'full_name' => $this->faker->sentence(5),
            'user_name' => $this->faker->unique()->sentence(1),
            'phone_no' => $this->faker->phoneNumber(),
            'email' => $this->faker->freeEmail(),
            'password' => Hash::make('123'),
        ];
    }
}
