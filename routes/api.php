<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\MyTixApiController;

/*
|--------------------------------------------------------------------------
| API Routes - MyTix App
|--------------------------------------------------------------------------
*/

Route::post('/register', [MyTixApiController::class, 'register']);
Route::get('/movies', [MyTixApiController::class, 'getMovies']);
Route::get('/promos', [MyTixApiController::class, 'getPromos']);