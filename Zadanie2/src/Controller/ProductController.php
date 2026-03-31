<?php
namespace App\Controller;

use App\Entity\Product;
use App\Repository\ProductRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/product')]
class ProductController extends AbstractController
{
    // LISTA PRODUKTÓW (READ)
    #[Route('', methods: ['GET'])]
    public function index(ProductRepository $repo): JsonResponse
    {
        $products = $repo->findAll();
        $data = array_map(fn($p) => [
            'id' => $p->getId(),
            'name' => $p->getName(),
            'price' => $p->getPrice(),
            'description' => $p->getDescription()
        ], $products);

        return $this->json($data);
    }

    // DODAWANIE PRODUKTU (CREATE)
    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        
        $product = new Product();
        $product->setName($data['name'] ?? 'Produkt bez nazwy');
        $product->setPrice((float)($data['price'] ?? 0));
        $product->setDescription($data['description'] ?? null);

        $em->persist($product);
        $em->flush();

        return $this->json(['status' => 'Created', 'id' => $product->getId()], 201);
    }
}