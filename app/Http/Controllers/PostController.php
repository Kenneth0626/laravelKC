<?php

namespace App\Http\Controllers;

use App\Http\Requests\CommentRequest;
use App\Http\Requests\PostRequest;
use App\Models\Comment;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Inertia\Inertia;

class PostController extends Controller
{
    public function index()
    {
        $guest = Auth::user();
        if(!$guest){
            $guest = Auth::guest();
        }

        $post = Post::paginate(10);

        return Inertia::render('PostTodo/IndexPost', [
            'postData' => $post,
            'guest' => [
                'is_member' => Auth::check(),
                'id' => is_bool($guest) ? null : Auth::user()->id,
            ],
            'currentPage' => $post->currentPage(),
        ]);
    }

    public function createPost(Request $request)
    {
        $owner = Auth::user();

        return Inertia::render('PostTodo/CreatePost', [
            'owner' => [
                'id' => $owner->id,
                'username' => $owner->username,
            ],
            'page' => $request->query('page'),
        ]);
    }

    public function storePost(PostRequest $request)
    {    
        $request->validated();

        Post::create([
            'user_id' => $request->owner_id,
            'user_username' => $request->owner_username,
            'title' => $request->title,
            'content' => $request->content,
        ]);

        return redirect(route('post.index', ['page' => $request->page]));
    }


    public function show(Request $request, string $id)
    {
        $guest = Auth::user();
        if(!$guest){
            $guest = Auth::guest();
        }

        $post = Post::findOrFail($id);

        $comments = $post->comments()->orderBy('created_at')->paginate(10);

        return Inertia::render('PostTodo/ShowPost', [
            'postData' => [
                'id' => $id,
                'user_id' => $post->user_id,
                'username' => $post->user_username,
                'title' => $post->title,
                'content' => $post->content,
                'created_at' => $post->created_at,
                'is_edited' => $post->created_at != $post->updated_at,
            ],
            'guest'=> [
                'is_member' => Auth::check(),
                'id' => is_bool($guest) ? null : $guest->id,
                'username' => is_bool($guest) ? null : $guest->username,
            ],
            'comments' => $comments,
            'commentPage' => $comments->currentPage()
        ]);
    }

    public function editPost(string $id)
    {
        if(Gate::allows('access-post', $id)){

            $post = Auth::user()->posts->find($id);

            return Inertia::render('PostTodo/EditPost', [
                'postData' => [
                    'id' => $id,
                    'title' => $post->title,
                    'content' => $post->content,
                ],
            ]);

        }

        abort(403); 
    }

    public function destroyPost(string $id)
    {
        if(Gate::allows('access-post', $id)){

            Post::destroy($id);

            return redirect(route('post.index'));

        }

        abort(403);
    }

    public function patchPost(PostRequest $request, string $id)
    {
        $request->validated();

        if(Gate::allows('access-post', $id)){

            Post::find($id)->update([
                'title' => $request->title,
                'content' => $request->content,
            ]);
    
            return redirect(route('post.show', [$id]));
            
        }
        
        abort(403);
    }

    public function storeComment(CommentRequest $request, string $id)
    {
        $request->validated();

        Comment::create([
            'post_id' => $id,
            'user_id' => $request->user_id,
            'user_username' => $request->user_username,
            'content' => $request->content,
        ]);

        return redirect()->back();
    }

    public function patchComment(Request $request)
    {
        $request->validate([
            'content' => ['required', 'max:255'],
        ]);

        if(Gate::allows('access-comment', $request->id)){

            Comment::find($request->id)->update([
                'content' => $request->content
            ]);

            return redirect()->back();

        }

        abort(403);
    }

    public function destroyComment(Request $request, string $id)
    {
        if(Gate::allows('access-comment', $request->comment_id)){

            Comment::destroy($request->comment_id);

            if($request->page != 1 && $request->itemCount - 1 === 0){
                return redirect(route('post.show', ['id' => $id, 'page' => $request->page - 1]));
            }

            return redirect()->back();

        }

        abort(403);
    }
}
