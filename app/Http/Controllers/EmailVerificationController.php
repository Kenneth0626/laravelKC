<?php

namespace App\Http\Controllers;

use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Http\Request;
use Inertia\Inertia;

class EmailVerificationController extends Controller
{
    public function notice(Request $request)
    {   
        return $request->user()->hasVerifiedEmail() ? redirect(RouteServiceProvider::HOME) : Inertia::render('AuthTodo/VerifyEmail');
    }

    public function verify(EmailVerificationRequest $request)
    {   
        if(!$request->user()->hasVerifiedEmail()){
            $request->fulfill();
        }

        return redirect(RouteServiceProvider::HOME);
    }

    public function send(Request $request)
    {
        $request->user()->sendEmailVerificationNotification();
        
        return redirect()->back()->with('message', 'Verification Link Sent!');
    }
}
