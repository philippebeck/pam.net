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
        $constants  = ModelFactory::getModel("Constant")->listData();
        $classes    = ModelFactory::getModel("Class")->listData();
        $properties = ModelFactory::getModel("Property")->listPropertiesWithClass();
        $methods    = ModelFactory::getModel("Method")->listMethodsWithClass();

        return $this->render("doc/doc.twig", [
            "constants"     => $constants,
            "classes"       => $classes,
            "properties"    => $properties,
            "methods"       => $methods
        ]);
    }
}
