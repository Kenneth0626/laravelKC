<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class GuestCommentedOnPost extends Notification implements ShouldQueue
{
    use Queueable;

    public $data;
    /**
     * Create a new notification instance.
     */
    public function __construct($comment_data)
    {
        $this->data = $comment_data;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
                    ->subject('A user commented on your post.')
                    ->greeting('user '.$this->data->user_username.' commented on your post.')
                    ->line($this->data->user_username.' commented:')
                    ->line('"'.$this->data->content.'"')
                    ->action('Visit Post', url(route('post.show', ['id' => $this->data->post->id])))
                    ->line('commented on '.$this->data->created_at);
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            //
        ];
    }
}
