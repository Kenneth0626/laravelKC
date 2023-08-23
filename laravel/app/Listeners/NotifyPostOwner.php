<?php

namespace App\Listeners;

use App\Events\GuestCommented;
use App\Notifications\GuestCommentedOnPost;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Support\Facades\Notification;

class NotifyPostOwner implements ShouldQueue
{
    /**
     * Create the event listener.
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     */
    public function handle(GuestCommented $event): void
    {   
        $comment_data = $event->comment;

        if($comment_data->user_id != $comment_data->post->user_id){
            
            $postOwner = $comment_data->post->user;

            $postOwner->notify(new GuestCommentedOnPost($comment_data));

        }
    }
}
