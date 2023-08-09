<?php

use App\Http\Controllers\AuthTodoController;
use App\Http\Controllers\EmailVerificationController;
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

Route::group(['middleware' => 'guest'], function (){
    Route::get('/', [AuthTodoController::class, 'local']);
    Route::get('/register', [AuthTodoController::class, 'register'])->name('todo.register');
    Route::post('/register', [AuthTodoController::class, 'registerStore']);
    Route::get('/login', [AuthTodoController::class, 'login'])->name('todo.login');
    Route::post('/login', [AuthTodoController::class, 'loginStore']);
});

Route::group(['middleware' => 'auth' ], function (){
    Route::post('/logout', [AuthTodoController::class, 'logout'])->name('todo.logout');
    Route::get('/email/verify', [EmailVerificationController::class, 'notice'])->name('verification.notice');
    Route::get('/email/verify/{id}/{hash}', [EmailVerificationController::class, 'verify'])->middleware('signed')->name('verification.verify');
    Route::post('/email/verification-notification', [EmailVerificationController::class, 'send'])->middleware('throttle:6,1')->name('verification.send');
});

Route::group(['middleware' => ['auth', 'verified']], function () {
    Route::get('/home', [AuthTodoController::class, 'home'])->name('todo.home');
    Route::get('/profile', [AuthTodoController::class, 'profile'])->name('todo.profile');
    Route::patch('/profile', [AuthTodoController::class, 'update'])->name('todo.update_profile');

    Route::prefix('todo')->group( function () {
        Route::get('/', [TodoController::class, 'index'])->name('todo.index');
        Route::patch('/{id}', [TodoController::class, 'updateCheck'])->name('todo.update_check')->whereNumber('id')->middleware('throttle:180,1');
        Route::get('/create' , [TodoController::class, 'create'])->name('todo.create');
        Route::post('/create', [TodoController::class, 'store'])->name('todo.store');
        Route::get('/edit/{id}' , [TodoController::class, 'edit'])->name('todo.edit')->whereNumber('id');
        Route::patch('/edit/{id}' , [TodoController::class, 'update'])->name('todo.update')->whereNumber('id');
        Route::delete('/{id}', [TodoController::class, 'destroy'])->name('todo.destroy')->whereNumber('id');
    });
});

Route::fallback(FallbackTodoController::class)->name('todo.void');

// Route::get('/hello', [HelloWorldJSController::class, 'helloWorld']);

