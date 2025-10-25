<?php

use Symfony\Component\Dotenv\Dotenv;

require dirname(__DIR__) . '/vendor/autoload.php';

if (file_exists(dirname(__DIR__) . '/.env')) {
    (new Dotenv())
        ->usePutenv()
        ->bootEnv(dirname(__DIR__) . '/.env'); // charge .env, .env.local, .env.$APP_ENV, etc.
}
