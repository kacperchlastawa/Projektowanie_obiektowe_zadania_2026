<?php
namespace App\Controller;

use App\Entity\Customer;
use App\Repository\CustomerRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/customer')]
class CustomerController extends AbstractController {
    #[Route('', methods: ['GET'])]
    public function index(CustomerRepository $repo): JsonResponse {
        return $this->json($repo->findAll());
    }

    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $em): JsonResponse {
        $data = json_decode($request->getContent(), true);
        $customer = new Customer();
        $customer->setEmail($data['email'] ?? 'test@test.pl');
        $customer->setLastName($data['lastName'] ?? 'Anonim');
        $em->persist($customer);
        $em->flush();
        return $this->json(['status' => 'Customer created', 'id' => $customer->getId()], 201);
    }
}