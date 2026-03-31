<?php

namespace App\Controller\Admin;

use App\Entity\Product;
use App\Entity\Category;
use App\Entity\Customer;
use EasyCorp\Bundle\EasyAdminBundle\Config\Dashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\MenuItem;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractDashboardController;
use EasyCorp\Bundle\EasyAdminBundle\Router\AdminUrlGenerator; // Dodany import
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route; // Kluczowy import dla atrybutu Route

class DashboardController extends AbstractDashboardController
{
    #[Route('/admin', name: 'admin')]
    public function index(): Response
    {
        // Ta część sprawia, że po wejściu w /admin nie widzisz strony powitalnej,
        // tylko od razu zostajesz przekierowany do listy produktów.
        $adminUrlGenerator = $this->container->get(AdminUrlGenerator::class);
        return $this->redirect($adminUrlGenerator->setController(ProductCrudController::class)->generateUrl());
    }

    public function configureDashboard(): Dashboard
    {
        return Dashboard::new()
            ->setTitle('Panel Projektu PHP');
    }

    public function configureMenuItems(): iterable
    {
        // Główny powrót
        yield MenuItem::linkToDashboard('Dashboard', 'fa fa-home');

        // Sekcja zarządzania danymi
        yield MenuItem::section('Zarządzanie');
        yield MenuItem::linkToCrud('Produkty', 'fas fa-shopping-basket', Product::class);
        yield MenuItem::linkToCrud('Kategorie', 'fas fa-tags', Category::class);
        yield MenuItem::linkToCrud('Klienci', 'fas fa-users', Customer::class);

        // Opcjonalny link powrotny do Twoich widoków Twig
        yield MenuItem::section('System');
        yield MenuItem::linkToUrl('Widok Twig (Produkty)', 'fas fa-eye', '/api/product/view');
    }
}