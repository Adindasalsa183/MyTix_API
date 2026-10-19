<?php 
return Illuminate\Foundation\Application::configure(basePath: dirname(__DIR__))->withRouting(api: __DIR__.'/../routes/api.php', web: __DIR__.'/../routes/web.php', commands: __DIR__.'/../routes/console.php', health: '/up')->withMiddleware(function ($middleware) {})->withExceptions(function ($exceptions) {})->create();
