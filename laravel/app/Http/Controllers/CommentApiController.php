<?php

namespace App\Http\Controllers;

use App\Http\Requests\CommentRequest;
use App\Http\Resources\CommentsResource;
use App\Models\Comment;
use App\Traits\HttpResponses;
use Illuminate\Support\Facades\Gate;

class CommentApiController extends Controller
{   
    use HttpResponses;

    public function store (CommentRequest $request, string $id)
    {
        $request->validated();

        $user = auth()->user();

        $newComment = Comment::create([
            'post_id' => $id,
            'user_id' => $user->id,
            'user_username' => $user->username,
            'content' => $request->content,
        ]);

        $comment = Comment::find($newComment->id);
        
        return $this->success(new CommentsResource($comment), 'Comment Succesfully Created.');
    }

    public function update (CommentRequest $request)
    {   
        $request->validated();

        if(Gate::allows('access-comment', $request->id)){

            Comment::find($request->id)->update([
                'content' => $request->content,
            ]);

            $comment = Comment::find($request->id);

            return $this->success($comment, "Comment Successfully Updated.");

        }

        return $this->error("", "You are not authorized to make this request.", 403);
    }

    public function destroy (string $id)
    {
        if(Gate::allows('access-comment', $id)){
            
            Comment::destroy($id);

            return $this->success(null, "Comment Successfully Destroyed.", 204);
            
        }

        return $this->error("", "You are not authorized to make this request.", 403);
    }
}
