<?php
namespace App\Controller\Web;

use App\Repository\CategoryRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/categories')]
class CategoryWebController extends AbstractController
{
    #[Route('', name: 'app_category_index', methods: ['GET'])]
    public function index(CategoryRepository $repo): Response
    {
        return $this->render('category/index.html.twig', [
            'categories' => $repo->findAll(),
        ]);
    }
}
