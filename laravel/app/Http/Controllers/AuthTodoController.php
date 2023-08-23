<?php

namespace App\Http\Controllers;

use App\Http\Requests\AuthTodoRequest;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rules\Password;
use Inertia\Inertia;

class AuthTodoController extends Controller
{   
    public function local()
    {
        return redirect(route('todo.login'));
    }

    public function register()
    {
        return Inertia::render('AuthTodo/RegisterTodo');
    }

    public function registerStore(AuthTodoRequest $request): RedirectResponse
    {    
        $request->validated();

        $user = User::create([
            'username' => $request->username,
            'email' => $request->email,
            'password' => $request->password,
        ]);
        
        event(new Registered($user));

        Auth::login($user);

        return redirect(route('todo.login'));
    }

    public function login()
    {
        return Inertia::render('AuthTodo/LoginTodo');
    }

    public function loginStore(Request $request): RedirectResponse
    {   
        $credentials = $request->validate([
            'email' => ['required', 'string', 'email', 'max:255'],
            'password' => ['required', Password::min(8)->numbers()],
        ]);

        if(Auth::attempt($credentials)){
            return redirect(route('todo.home'));
        }

        return back()->withErrors([
            'password' => 'Email or Password is incorrect'
        ])->onlyInput('password');
    }

    public function home()
    {   
        $user = Auth::user();

        $todos = $user->todos;
        $posts = $user->posts;
        $comments = $user->comments;

        $todo_count = $todos->count();
        $post_count = $posts->count();
        $comment_count = $comments->count();
        
        $unfinished_count = $todos->where('is_checked', 0)->count();

        // $item = $todos->where('is_checked', 1)->sortByDesc('updated_at')->first();
        // $todo_title = $item === null ? null : $item->title;

        return Inertia::render('AuthTodo/HomeTodo', [
            'username' => $user->username,
            'todo' => [
                'todo_count' => $todo_count,
                'unfinished_count' => $unfinished_count,
                'finished_count' => $todo_count - $unfinished_count,
                'post_count' => $post_count,
                'comment_count' => $comment_count,
                // 'last_finished_title' => $todo_title,
            ]
        ]);
    }

    public function profile()
    {   
        $user = Auth::user();

        return Inertia::render('AuthTodo/ProfileTodo', [
            'username' => $user->username,
        ]);
    }

    public function update(Request $request)
    {
        $request->validate([
            'username' => ['required', 'string', 'alpha_num', 'min:3', 'max:255']
        ]);

        User::find(Auth::user()->id)->update([
            'username' => $request->username
        ]);

        return redirect(route('todo.home'));
    }

    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect(route('todo.login'));
    }
}
