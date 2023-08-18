<?php

namespace App\Http\Controllers;

use App\Events\NewChatPost;
use App\Http\Requests\PublicMessageRequest;
use App\Models\PublicMessage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class PublicMessageController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {   
        $user = Auth::user();

        return Inertia::render('ChatTodo/GeneralChat', [
            'guest' => [
                'id' => $user->id,
                'username' => $user->username,
            ]
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(PublicMessageRequest $request)
    {
        $request->validated();

        $message = PublicMessage::create([
            'user_id' => $request->user_id,
            'user_username' => $request->user_username,
            'content' => $request->content,
        ]);

        event(new NewChatPost($message, $request->send_index));

        return redirect()->back();
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, PublicMessage $publicMessage)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(PublicMessage $publicMessage)
    {
        //
    }
}
