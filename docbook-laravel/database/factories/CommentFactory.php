<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Comment>
 */
class CommentFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            "comment" => $this->faker->sentence(45),
            "patient_id" => mt_rand(1, 10),
            "doctor_id" => mt_rand(1, 10)
        ];
    }
}
