<?php

namespace App\Controller;

use Pam\Controller\MainController;
use Pam\Model\Factory\ModelFactory;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Error\SyntaxError;

/**
 * Class PropertyController
 * @package App\Controller
 */
class PropertyController extends MainController
{
    /**
     * @return string
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    public function createMethod()
    {
        if ($this->getSecurity()->checkIsAdmin() !== true) {
            $this->redirect("home");
        }

        if (!empty($this->getPost()->getPostArray())) {
            $property = $this->getPost()->getPostArray();

            ModelFactory::getModel("Property")->createData($property);
            $this->getSession()->createAlert("New Property successfully created !", "green");
        }

        $classes = ModelFactory::getModel("Class")->listData();

        return $this->render("back/property/createProperty.twig", ["classes" => $classes]);
    }

    /**
     * @return string
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    public function updateMethod()
    {
        if ($this->getSecurity()->checkIsAdmin() !== true) {
            $this->redirect("home");
        }

        if (!empty($this->getPost()->getPostArray())) {
            $property = $this->getPost()->getPostArray();

            ModelFactory::getModel("Property")->updateData($this->getGet()->getGetVar("id"), $property);
            $this->getSession()->createAlert("Successful modification of the selected Property !", "blue");

            $this->redirect("admin");
        }

        $property   = ModelFactory::getModel("Property")->readData($this->getGet()->getGetVar("id"));
        $classes    = ModelFactory::getModel("Class")->listData();

        return $this->render("back/property/updateProperty.twig", [
            "property"  => $property,
            "classes"   => $classes
        ]);
    }

    public function deleteMethod()
    {
        if ($this->getSecurity()->checkIsAdmin() !== true) {
            $this->redirect("home");
        }

        ModelFactory::getModel("Property")->deleteData($this->getGet()->getGetVar("id"));
        $this->getSession()->createAlert("Property permanently deleted !", "red");

        $this->redirect("admin");

    }
}