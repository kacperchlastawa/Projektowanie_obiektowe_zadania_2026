<?php
namespace App\Controller;

use App\Entity\Category;
use App\Repository\CategoryRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/category')]
class CategoryController extends AbstractController {
    #[Route('', methods: ['GET'])]
    public function index(CategoryRepository $repo): JsonResponse {
        return $this->json($repo->findAll());
    }

    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $em): JsonResponse {
        $data = json_decode($request->getContent(), true);
        $category = new Category();
        $category->setName($data['name'] ?? 'Nowa Kategoria');
        $em->persist($category);
        $em->flush();
        return $this->json(['status' => 'Category created', 'id' => $category->getId()], 201);
    }
}