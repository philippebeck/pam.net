<?php

namespace App\Controller;

use Pam\Controller\MainController;
use Pam\Model\Factory\ModelFactory;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Error\SyntaxError;

/**
 * Class DocController
 * @package App\Controller
 */
class DocController extends MainController
{
    /**
     * @return string
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    public function defaultMethod()
    {
        $classes    = ModelFactory::getModel("Class")->listData();
        $properties = ModelFactory::getModel("Property")->listData();
        $methods    = ModelFactory::getModel("Method")->listData();

        return $this->render("doc/doc.twig", [
            "classes"       => $classes,
            "properties"    => $properties,
            "methods"       => $methods
        ]);
    }
}
