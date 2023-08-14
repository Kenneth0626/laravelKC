<?php

namespace App\Providers;

use App\Models\Post;
use App\Models\User;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Gate::define('access-post', function ($user, $post_id) {
            return $user->posts->contains('id', $post_id);
        });

        Gate::define('access-comment', function ($user, $comment_id) {
            return $user->comments->contains('id', $comment_id);
        });
    }
}
