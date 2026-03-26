<?php
namespace App\Controller\Web;

use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/users')]
class UserWebController extends AbstractController
{
    #[Route('', name: 'app_user_index', methods: ['GET'])]
    public function index(UserRepository $repo): Response
    {
        return $this->render('user/index.html.twig', [
            'users' => $repo->findAll(),
        ]);
    }
}
