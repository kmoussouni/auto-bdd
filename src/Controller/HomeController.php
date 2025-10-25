<?php
namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

final class HomeController
{
    #[Route(path: '/', name: 'home')]
    public function __invoke(): Response
    {
        return new Response('XdXX');
    }
}
