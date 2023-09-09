<?php

namespace Database\Factories;

use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Doctor>
 */
class DoctorFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'doc_id' => $this->faker->unique()->numberBetween(144, 153),
            'user_name' => $this->faker->unique()->sentence(1),
            'password' => Hash::make('123'),
            'mobile_number' => $this->faker->phoneNumber(),
            'specialization_id' => mt_rand(1, 4),
            'status' => 'available',
            'bio_data' => $this->faker->sentence(10, 30),
            'experience_year' => 5

        ];
    }
}

// 85 to 94