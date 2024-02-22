<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('doctors', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('doc_id')->unique();
            $table->string('user_name')->unique();
            $table->string('phone_no');
            $table->string('password');

            $table->foreignId('specialization_id');
            $table->text('experience_year');
            $table->text('bio_data');
            $table->string('img')->nullable();
            $table->string('status');
            $table->foreign('doc_id')->references('id')->on('users')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('doctors');
    }
};
