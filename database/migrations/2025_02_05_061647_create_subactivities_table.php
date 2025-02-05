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
        Schema::create('subactivities', function (Blueprint $table) {
            $table->id();
            $table->foreignId('activities_id')->constrained()->onDelete('cascade');
            $table->string('subactivitie');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('subactivities');
    }
};
