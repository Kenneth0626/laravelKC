<!<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Laravel</title>
        @viteReactRefresh 
        @vite(['resources/css/app.css', 'resources/js/app.jsx'])
        <!-- As you can see, we will use vite with jsx syntax for React-->
        @inertiaHead
    </head>
    <body class="bg-cyan-400">
        <div id="app" class="h-full flex whitespace-nowrap" data-page="{{ json_encode($page) }}"></div>
    </body>
</html>