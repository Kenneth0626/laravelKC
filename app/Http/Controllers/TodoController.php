<?php

namespace App\Http\Controllers;

use App\Http\Requests\TodoRequest;
use App\Models\Todo;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;

class TodoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $pages = Todo::orderBy('created_at')->paginate(10,['id', 'title', 'is_checked']);

        if($pages->currentPage() != 1 && empty($pages->items()))
            return Inertia::render('TodoList/FallbackTodo');

        return Inertia::render('TodoList/Index', compact('pages'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return Inertia::render('TodoList/CreateTodo');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(TodoRequest $request): RedirectResponse
    {   
        $request->validated();

        Todo::create([
            'title' => $request->title,
            'is_checked' => $request->is_checked,
        ]);

        return redirect(route('todo.index'));
    }

    /**
     * Update the specified resource in storage.
     */
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


    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {   
        return Inertia::render('TodoList/EditTodo', [
            'item' => Todo::findOrFail($id)
        ]);
    }

    public function update(TodoRequest $request, $id): RedirectResponse
    {   
        $request->validated();

        Todo::find($id)->update([
            'title' => $request->title,
        ]);

        return redirect(route('todo.index'));
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        Todo::destroy($id);

        return redirect(route('todo.index'));
    }
}
