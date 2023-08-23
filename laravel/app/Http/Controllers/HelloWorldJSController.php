<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

class HelloWorldJSController extends Controller
{
    public function index()
    {
        return Inertia::render('HelloWorld');
    }
}
