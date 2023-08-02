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
            'first_name' => $this->faker->sentence(1),
            'last_name' => $this->faker->sentence(1),
            'user_name' => $this->faker->unique()->sentence(1),
            'mobile_number' => $this->faker->phoneNumber(),
            'email' => $this->faker->freeEmail(),
            'specialization_id' => mt_rand(1, 4),
            'password' => Hash::make('123'),
            'status' => 'available',
            'experience' => $this->faker->sentence(10, 30),
            'location' => $this->faker->address()

        ];
    }
}
