<?php

namespace App\Http\Controllers;

use App\Http\Requests\TodoRequest;
use App\Models\Todo;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class TodoController extends Controller
{
    public function index(Request $request)
    {
        $user_id = Auth::user()->id;

        $pages = Todo::where('user_id', $user_id)->orderBy('created_at')->paginate(10,['id', 'title', 'is_checked']);

        if($pages->currentPage() != 1 && empty($pages->items())){
            return Inertia::render('TodoList/FallbackTodo');
        }
        
        return Inertia::render('TodoList/Index', compact('pages'));
    }

    public function create(Request $request)
    {       
        return Inertia::render('TodoList/CreateTodo', [
            'user_id' => Auth::user()->id,
            'page' => $request->query('page'),
        ]);
    }

    public function store(TodoRequest $request): RedirectResponse
    {  
        $request->validated();

        Todo::create([
            'user_id' => $request->user_id,
            'title' => $request->title,
            'is_checked' => $request->is_checked,
        ]);

        return redirect(route('todo.index', ['page' => $request->page]));
    }

    public function updateCheck(Request $request, string $id)
    {   
        $request->validate([
            'is_checked' => 'boolean'
        ]);

        Todo::find($id)->update([
            'is_checked' => $request->is_checked
        ]);

        return back();
    }

    public function edit(Request $request, string $id)
    {   
        return Inertia::render('TodoList/EditTodo', [
            'item' => Todo::findOrFail($id),
            'page' => $request->query('page', '1'),
        ]);
    }

    public function update(TodoRequest $request, string $id): RedirectResponse
    {   
        $request->validated();

        Todo::find($id)->update([
            'title' => $request->title,
        ]);

        return redirect(route('todo.index', ['page' => $request->page]));
    }

    public function destroy(Request $request, string $id)
    {
        Todo::destroy($id);

        if($request->page != 1 && $request->itemCount - 1 === 0){
            return redirect(route('todo.index', ['page' => $request->page - 1]));
        }

        return back();
    }
}
