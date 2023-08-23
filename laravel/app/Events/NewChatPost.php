<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class NewChatPost implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $data;
    public $index;
    /**
     * Create a new event instance.
     */
    public function __construct($message, $sendIndex)
    {
        $this->data = $message;
        $this->index = $sendIndex;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return array<int, \Illuminate\Broadcasting\Channel>
     */
    public function broadcastOn(): array
    {

        return [
            new PresenceChannel('general-chat'),
        ];
    }

    public function broadcastAs()
    {
        return 'chat.general.post';
    }

    public function broadcastWith()
    {
        return [
            'id' => $this->data->id,
            'user_id' => $this->data->user_id,
            'username' => $this->data->user_username,
            'content' => $this->data->content,
            'created_at' => $this->data->created_at,
            'is_message' => true,
            'index' => $this->index,
        ];
    }

}
