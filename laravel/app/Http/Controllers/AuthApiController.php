<?php

namespace App\Http\Controllers;

use App\Http\Requests\AuthTodoRequest;
use App\Models\User;
use App\Traits\HttpResponses;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthApiController extends Controller
{
    use HttpResponses;

    public function login (Request $request)
    {
        $checkUser = auth('sanctum')->user();

        if($checkUser === null){
            
            $request->validate([
                'email' => ['required', 'string', 'email', 'max:255'],
                'password' => ['required'],
            ]);
    
            $user = User::where('email', $request->email)->first();
     
            if (! $user || ! Hash::check($request->password, $user->password)) {
                throw ValidationException::withMessages([
                    'password' => ['The provided credentials are incorrect.'],
                ]);
            }
    
            return $this->success([
                'token' => $user->createToken('tokenby' . $user->id)->plainTextToken,
            ]);

        }      
    }

    public function register (AuthTodoRequest $request)
    {
        $request->validated();

        $user = User::create([
            'username' => $request->username,
            'email' => $request->email,
            'password' => $request->password,
        ]);

        return $this->success([
            'token' => $user->createToken('tokenby' . $user->id)->plainTextToken
        ]);
    }

    public function logout (Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return $this->success($request, "You are now logged out.");
    }
}
