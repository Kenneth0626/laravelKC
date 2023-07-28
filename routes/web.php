<?php

use App\Http\Controllers\HelloWorldController;
use App\Http\Controllers\HelloWorldJSController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

// Route::get('/', function () {
//     return view('hw.hello');
// });

// Route::get('/', HelloWorldController::class);

Route::get('/', [HelloWorldJSController::class, 'index']);


