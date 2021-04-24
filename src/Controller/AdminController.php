<?php

namespace App\Controller;

use Pam\Controller\MainController;
use Pam\Model\ModelFactory;
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
        if ($this->checkAdmin() !== true) {
            $this->redirect("home");
        }

        $constants  = ModelFactory::getModel("Constant")->listData();
        $classes    = ModelFactory::getModel("Class")->listData();
        $properties = ModelFactory::getModel("Property")->listData();
        $methods    = ModelFactory::getModel("Method")->listData();
        $users      = ModelFactory::getModel("User")->listData();

        return $this->render("back/admin.twig", [
            "constants"     => $constants,
            "classes"       => $classes,
            "properties"    => $properties,
            "methods"       => $methods,
            "users"         => $users
        ]);
    }
}
