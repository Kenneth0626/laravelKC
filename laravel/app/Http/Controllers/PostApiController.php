<?php

namespace App\Http\Controllers;

use App\Http\Requests\PostRequest;
use App\Http\Resources\CommentsResource;
use App\Http\Resources\PostsResource;
use App\Http\Resources\ShowPostResource;
use App\Models\Comment;
use App\Models\Post;
use App\Traits\HttpResponses;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;

class PostApiController extends Controller
{
    use HttpResponses;

    public function index () 
    {
        $user = auth('sanctum')->user();

        $posts = Post::orderBy('created_at', 'desc')->paginate(10);

        return response()->json([
            'data' => [
                'posts' => PostsResource::collection($posts),
                'lastPage' => $posts->lastPage(),
                'guest_id' => $user === null ? null : $user->id
            ],
        ]);
    }

    public function store (PostRequest $request)
    {
        $request->validated();

        $user = auth('sanctum')->user();

        $post = Post::create([
            'user_id' => $user->id,
            'user_username' => $user->username,
            'title' => $request->title,
            'content' => $request->content,
        ]);

        return $this->success($post, 'Post Succesfully Created.');
    }

    public function show (Request $request, string $id)
    {   
        $user = auth('sanctum')->user();
        
        $post = Post::find($id);

        if($post === null){
            return $this->error($post, "Page Not Found.", 404);
        }

        return response()->json([
            'data' => [
                'post' => new ShowPostResource($post),
                'guest_id' => $user === null ? null : $user->id,
            ],
        ]);
    }

    public function comments (string $id)
    {   
        $comments = Comment::where('post_id', $id)->orderBy('created_at', 'desc')->paginate(10);
        
        return response()->json([
            'data' => [
                'comments' => CommentsResource::collection($comments),
                'lastPage' => $comments->lastPage(),
            ],
        ]);
    }


    public function check (string $id)
    {
        $user = auth('sanctum')->user();

        return response()->json([
            'isOwner' => $user->posts->contains('id', $id) ? true : false
        ]);
    }

    public function edit (string $id) 
    {   
        if(Gate::allows('access-post', $id)){

            $post = Post::find($id);

            return response()->json([
                'data' => [
                    'title' => $post->title,
                    'content' => $post->content,
                ]
            ]);

        }

        return $this->error("", "You are not authorized to make this request.", 403);
    }

    public function update (PostRequest $request, string $id)
    {   
        $request->validated();

        if(Gate::allows('access-post', $id)){
            
            Post::find($id)->update([
                'title' => $request->title,
                'content' => $request->content,
            ]);

            $post = Post::find($id);

            return $this->success($post, "Post Successfully Updated.");
            
        }

        return $this->error($id, "You are not authorized to make this request.", 403);
    }

    public function destroy (string $id)
    {
        if(Gate::allows('access-post', $id)){
            
            Post::destroy($id);

            return $this->success(null, "Post Successfully Destroyed.", 204);
        }

        return $this->error("", "You are not authorized to make this request.", 403);
    }

}
