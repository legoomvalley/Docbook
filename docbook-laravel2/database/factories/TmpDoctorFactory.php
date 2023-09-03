<?php

namespace Database\Factories;

use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\TmpDoctor>
 */
class TmpDoctorFactory extends Factory
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
            'mobile_number' => $this->faker->phoneNumber(),
            'email' => $this->faker->freeEmail(),
            'specialization_id' => mt_rand(1, 4),
            'password' => Hash::make('123'),
            'status' => 'available',
            'experience_year' => mt_rand(1, 4),
            'bio_data' =>  $this->faker->sentence(10, 30),
        ];
    }
}
