<?php

namespace App\Controller;

use Pam\Controller\MainController;
use Pam\Model\Factory\ModelFactory;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Error\SyntaxError;

/**
 * Class AdminController
 * @package App\Controller
 */
class AdminController extends MainController
{
    /**
     * @return string
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    public function defaultMethod()
    {
        if ($this->getSecurity()->checkIsAdmin() !== true) {
            $this->redirect("home");
        }

        $classes    = ModelFactory::getModel("Class")->listData();
        $properties = ModelFactory::getModel("Property")->listData();
        $methods    = ModelFactory::getModel("Method")->listData();
        $users      = ModelFactory::getModel("User")->listData();

        return $this->render("back/admin/admin.twig", [
            "classes"       => $classes,
            "properties"    => $properties,
            "methods"       => $methods,
            "users"         => $users
        ]);
    }
}
