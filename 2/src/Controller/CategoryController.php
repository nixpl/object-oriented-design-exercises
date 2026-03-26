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
    #[Route('', methods: ['GET'])]
    public function index(EntityManagerInterface $em): JsonResponse
    {
        $categories = $em->getRepository(Category::class)->findAll();
        $data = array_map(fn($c) => ['id' => $c->getId(), 'name' => $c->getName()], $categories);
        return $this->json($data);
    }

    #[Route('/{id}', methods: ['GET'])]
    public function show(Category $category = null): JsonResponse
    {
        if (!$category) return $this->json(['message' => 'Not found'], 404);
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

    #[Route('/{id}', methods: ['PUT'])]
    public function update(Request $request, Category $category = null, EntityManagerInterface $em): JsonResponse
    {
        if (!$category) return $this->json(['message' => 'Not found'], 404);
        $data = json_decode($request->getContent(), true);
        if (isset($data['name'])) $category->setName($data['name']);
        
        $em->flush();
        return $this->json(['message' => 'Updated']);
    }

    #[Route('/{id}', methods: ['DELETE'])]
    public function delete(Category $category = null, EntityManagerInterface $em): JsonResponse
    {
        if (!$category) return $this->json(['message' => 'Not found'], 404);
        $em->remove($category);
        $em->flush();
        return $this->json(['message' => 'Deleted']);
    }
}
