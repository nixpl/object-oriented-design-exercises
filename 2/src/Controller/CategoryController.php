<?php
namespace App\Controller;

use App\Entity\Category;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/categories')]
class CategoryController extends AbstractController
{
    private const ROUTE_ID = '/{id}';
    private const NOT_FOUND_MSG = 'Not found';
    
    #[Route('', methods: ['GET'])]
    public function index(EntityManagerInterface $em): JsonResponse
    {
        $categories = $em->getRepository(Category::class)->findAll();
        $data = array_map(fn($c) => ['id' => $c->getId(), 'name' => $c->getName()], $categories);
        return $this->json($data);
    }

    #[Route(self::ROUTE_ID, methods: ['GET'])]
    public function show(Category $category = null): JsonResponse
    {
        if (!$category) {
            return $this->json(['message' => self::NOT_FOUND_MSG], 404);
        }
        return $this->json(['id' => $category->getId(), 'name' => $category->getName()]);
    }

    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $category = new Category();
        $category->setName($data['name'] ?? 'New Category');
        
        $em->persist($category);
        $em->flush();
        
        return $this->json(['message' => 'Created', 'id' => $category->getId()], 201);
    }

    #[Route(self::ROUTE_ID, methods: ['PUT'])]
    public function update(Request $request, EntityManagerInterface $em, Category $category = null): JsonResponse
    {
        if (!$category) {
            return $this->json(['message' => self::NOT_FOUND_MSG], 404);
        }
        $data = json_decode($request->getContent(), true);
        if (isset($data['name'])) {
            $category->setName($data['name']);
        }
        
        $em->flush();
        return $this->json(['message' => 'Updated']);
    }

    #[Route(self::ROUTE_ID, methods: ['DELETE'])]
    public function delete(EntityManagerInterface $em, Category $category = null): JsonResponse
    {
        if (!$category) {
            return $this->json(['message' => self::NOT_FOUND_MSG], 404);
        }
        $em->remove($category);
        $em->flush();
        return $this->json(['message' => 'Deleted']);
    }
}
