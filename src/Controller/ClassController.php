<?php

namespace App\Controller;

use Pam\Controller\MainController;
use Pam\Model\Factory\ModelFactory;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Error\SyntaxError;

/**
 * Class ClassController
 * @package App\Controller
 */
class ClassController extends MainController
{
    public function defaultMethod()
    {
        $this->redirect("home");
    }

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
            $class = $this->getPost()->getPostArray();

            ModelFactory::getModel("Class")->createData($class);
            $this->getSession()->createAlert("New Class successfully created !", "green");
        }

        return $this->render("back/class/createClass.twig");
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
            $class = $this->getPost()->getPostArray();

            ModelFactory::getModel("Class")->updateData($this->getGet()->getGetVar("id"), $class);
            $this->getSession()->createAlert("Successful modification of the selected Class !", "blue");

            $this->redirect("admin");
        }

        $class = ModelFactory::getModel("Class")->readData($this->getGet()->getGetVar("id"));

        return $this->render("back/class/updateClass.twig", ["class" => $class]);
    }

    public function deleteMethod()
    {
        if ($this->getSecurity()->checkIsAdmin() !== true) {
            $this->redirect("home");
        }

        $properties = ModelFactory::getModel("Property")->listData($this->getGet()->getGetVar("id"), "class_id");
        $methods    = ModelFactory::getModel("Method")->listData($this->getGet()->getGetVar("id"), "class_id");

        foreach ($properties as $property) {
            ModelFactory::getModel("Property")->deleteData($property["id"]);
        }

        foreach ($methods as $method) {
            ModelFactory::getModel("Method")->deleteData($method["id"]);
        }

        ModelFactory::getModel("Class")->deleteData($this->getGet()->getGetVar("id"));
        $this->getSession()->createAlert("Class permanently deleted !", "red");

        $this->redirect("admin");

    }
}