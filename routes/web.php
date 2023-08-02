<?php

use App\Http\Controllers\FallbackTodoController;
use App\Http\Controllers\HelloWorldController;
use App\Http\Controllers\HelloWorldJSController;
use App\Http\Controllers\TodoController;
use Illuminate\Foundation\Http\Middleware\HandlePrecognitiveRequests;
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

Route::get('/', [TodoController::class, 'index'])->name('todo.index');

Route::patch('/{id}', [TodoController::class, 'updateCheck'])->name('todo.update_check')->whereNumber('id');

Route::get('/create' , [TodoController::class, 'create'])->name('todo.create');

Route::post('/create', [TodoController::class, 'store'])->name('todo.store')->middleware([HandlePrecognitiveRequests::class]);

Route::get('/edit/{id}' , [TodoController::class, 'edit'])->name('todo.edit')->whereNumber('id');

Route::patch('/edit/{id}' , [TodoController::class, 'update'])->name('todo.update')->whereNumber('id')->middleware([HandlePrecognitiveRequests::class]);

Route::delete('/{id}', [TodoController::class, 'destroy'])->name('todo.destroy')->whereNumber('id');

Route::fallback(FallbackTodoController::class)->name('todo.void');

// Route::get('/hello', [HelloWorldJSController::class, 'helloWorld']);

