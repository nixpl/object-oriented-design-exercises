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
    #[Route('', methods: ['GET'])]
    public function index(EntityManagerInterface $em): JsonResponse
    {
        $users = $em->getRepository(User::class)->findAll();
        $data = array_map(fn($u) => ['id' => $u->getId(), 'email' => $u->getEmail()], $users);
        return $this->json($data);
    }

    #[Route('/{id}', methods: ['GET'])]
    public function show(User $user = null): JsonResponse
    {
        if (!$user) return $this->json(['message' => 'Not found'], 404);
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

    #[Route('/{id}', methods: ['PUT'])]
    public function update(Request $request, User $user = null, EntityManagerInterface $em): JsonResponse
    {
        if (!$user) return $this->json(['message' => 'Not found'], 404);
        $data = json_decode($request->getContent(), true);
        if (isset($data['email'])) $user->setEmail($data['email']);
        
        $em->flush();
        return $this->json(['message' => 'Updated']);
    }

    #[Route('/{id}', methods: ['DELETE'])]
    public function delete(User $user = null, EntityManagerInterface $em): JsonResponse
    {
        if (!$user) return $this->json(['message' => 'Not found'], 404);
        $em->remove($user);
        $em->flush();
        return $this->json(['message' => 'Deleted']);
    }
}
