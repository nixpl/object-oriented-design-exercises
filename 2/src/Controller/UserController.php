<?php
namespace App\Controller;

use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/users')]
class UserController extends AbstractController
{
    private const ROUTE_ID = '/{id}';
    private const NOT_FOUND_MSG = 'Not found';

    #[Route('', methods: ['GET'])]
    public function index(EntityManagerInterface $em): JsonResponse
    {
        $users = $em->getRepository(User::class)->findAll();
        $data = array_map(fn($u) => ['id' => $u->getId(), 'email' => $u->getEmail()], $users);
        return $this->json($data);
    }

    #[Route(self::ROUTE_ID, methods: ['GET'])]
    public function show(User $user = null): JsonResponse
    {
        if (!$user) {
            return $this->json(['message' => self::NOT_FOUND_MSG], 404);
        }
        return $this->json(['id' => $user->getId(), 'email' => $user->getEmail()]);
    }

    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $user = new User();
        $user->setEmail($data['email'] ?? 'user@example.com');
        
        $em->persist($user);
        $em->flush();
        
        return $this->json(['message' => 'Created', 'id' => $user->getId()], 201);
    }

    #[Route(self::ROUTE_ID, methods: ['PUT'])]
    public function update(Request $request, EntityManagerInterface $em, User $user = null): JsonResponse
    {
        if (!$user) {
            return $this->json(['message' => self::NOT_FOUND_MSG], 404);
        }
        $data = json_decode($request->getContent(), true);
        if (isset($data['email'])) {
            $user->setEmail($data['email']);
        }

        $em->flush();
        return $this->json(['message' => 'Updated']);
    }

    #[Route(self::ROUTE_ID, methods: ['DELETE'])]
    public function delete(EntityManagerInterface $em, User $user = null): JsonResponse
    {
        if (!$user) {
            return $this->json(['message' => self::NOT_FOUND_MSG], 404);
        }
        $em->remove($user);
        $em->flush();
        return $this->json(['message' => 'Deleted']);
    }
}
