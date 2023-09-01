<?php

use App\Http\Controllers\AuthApiController;
use App\Http\Controllers\CommentApiController;
use App\Http\Controllers\PostApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/login', [AuthApiController::class, 'login']);
Route::post('/register', [AuthApiController::class, 'register']);

Route::get('/posts', [PostApiController::class, 'index']);
Route::get('/posts/{id}', [PostApiController::class, 'show']);
Route::get('/posts/comments/{id}', [PostApiController::class, 'comments']);

Route::group(['middleware' => 'auth:sanctum'], function () {
    Route::post('/posts/create', [PostApiController::class, 'store']);
    Route::get('/posts/edit/check/{id}', [PostApiController::class, 'check']);
    Route::get('/posts/{id}/edit', [PostApiController::class, 'edit']);
    Route::patch('/posts/{id}/update', [PostApiController::class, 'update']);
    Route::delete('/posts/{id}/destroy', [PostApiController::class, 'destroy']);

    Route::post('/comments/posts/{id}', [CommentApiController::class, 'store']);
    Route::patch('/comments/posts/{id}/update', [CommentApiController::class, 'update']);
    Route::delete('comments/{id}/destroy', [CommentApiController::class, 'destroy']);

    Route::post('/logout', [AuthApiController::class, 'logout']);
});

















