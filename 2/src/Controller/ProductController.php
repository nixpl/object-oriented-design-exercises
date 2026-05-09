<?php
namespace App\Controller;

use App\Entity\Product;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/products')]
class ProductController extends AbstractController
{
    private const ROUTE_ID = '/{id}';
    private const NOT_FOUND_MSG = 'Not found';

    #[Route('', methods: ['GET'])]
    public function index(EntityManagerInterface $em): JsonResponse
    {
        $products = $em->getRepository(Product::class)->findAll();
        $data = array_map(fn($p) => ['id' => $p->getId(), 'name' => $p->getName(), 'price' => $p->getPrice()], $products);
        return $this->json($data);
    }

    #[Route(self::ROUTE_ID, methods: ['GET'])]
    public function show(Product $product = null): JsonResponse
    {
        if (!$product) {
            return $this->json(['message' => self::NOT_FOUND_MSG], 404);
        }
        return $this->json(['id' => $product->getId(), 'name' => $product->getName(), 'price' => $product->getPrice()]);
    }

    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $product = new Product();
        $product->setName($data['name'] ?? 'Nowy produkt');
        $product->setPrice($data['price'] ?? 0.0);
        
        $em->persist($product);
        $em->flush();
        
        return $this->json(['message' => 'Created', 'id' => $product->getId()], 201);
    }

    #[Route(self::ROUTE_ID, methods: ['PUT'])]
    public function update(Request $request, EntityManagerInterface $em, Product $product = null): JsonResponse
    {
        if (!$product) {
            return $this->json(['message' => self::NOT_FOUND_MSG], 404);
        }
        $data = json_decode($request->getContent(), true);
        if (isset($data['name'])) {
            $product->setName($data['name']);
        }
        if (isset($data['price'])) {
            $product->setPrice($data['price']);
        }

        $em->flush();
        return $this->json(['message' => 'Updated']);
    }

    #[Route(self::ROUTE_ID, methods: ['DELETE'])]
    public function delete(EntityManagerInterface $em, Product $product = null): JsonResponse
    {
        if (!$product) {
            return $this->json(['message' => self::NOT_FOUND_MSG], 404);
        }
        $em->remove($product);
        $em->flush();
        return $this->json(['message' => 'Deleted']);
    }
}
