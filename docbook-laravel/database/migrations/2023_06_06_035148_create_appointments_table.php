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
        Schema::create('appointments', function (Blueprint $table) {
            $table->id();
            $table->string("full_name");
            $table->date("date");
            $table->string("time");
            $table->text("disease");
            $table->foreignId("specialization_id")->nullable();
            $table->text("additional_message");
            $table->string("remark");
            $table->string("status");
            $table->foreignId("patient_id");
            $table->foreignId('doctor_id')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('appointments');
    }
};
