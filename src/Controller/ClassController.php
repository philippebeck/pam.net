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
    /**
     * @var array
     */
    private $class = [];

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
            $this->setClassData();

            ModelFactory::getModel("Class")->createData(
                $this->class
            );

            $this->getSession()->createAlert(
                "New Class successfully created !", 
                "green"
            );

            $this->redirect("admin");
        }

        return $this->render("back/class/createClass.twig");
    }

    private function setClassData()
    {
        $this->class = $this->getPost()->getPostArray();

        $this->class["class"] = (string) trim(
            $this->class["class"]
        );

        $this->class["path"] = (string) trim(
            $this->class["path"]
        );

        $this->class["parameters"] = (string) trim(
            $this->class["parameters"]
        );

        $this->class["extends"] = (string) trim(
            $this->class["extends"]
        );

        $this->class["implements"] = (string) trim(
            $this->class["implements"]
        );

        $this->class["definition"] = (string) trim(
            $this->class["definition"]
        );

        $this->class["abstract"]    = (int) $this->class["abstract"];
        $this->class["interface"]   = (int) $this->class["interface"];
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
            $this->setClassData();

            ModelFactory::getModel("Class")->updateData(
                $this->getGet()->getGetVar("id"), 
                $this->class
            );

            $this->getSession()->createAlert(
                "Successful modification of the selected Class !", 
                "blue"
            );

            $this->redirect("admin");
        }

        $class = ModelFactory::getModel("Class")->readData(
            $this->getGet()->getGetVar("id")
        );

        return $this->render("back/class/updateClass.twig", [
            "class" => $class
        ]);
    }

    public function deleteMethod()
    {
        if ($this->getSecurity()->checkIsAdmin() !== true) {
            $this->redirect("home");
        }

        $properties = ModelFactory::getModel("Property")->listData(
            $this->getGet()->getGetVar("id"), 
            "class_id"
        );

        $methods = ModelFactory::getModel("Method")->listData(
            $this->getGet()->getGetVar("id"), 
            "class_id"
        );

        foreach ($properties as $property) {
            ModelFactory::getModel("Property")->deleteData(
                $property["id"]
            );
        }

        foreach ($methods as $method) {
            ModelFactory::getModel("Method")->deleteData(
                $method["id"]
            );
        }

        ModelFactory::getModel("Class")->deleteData(
            $this->getGet()->getGetVar("id")
        );

        $this->getSession()->createAlert(
            "Class permanently deleted !", 
            "red"
        );

        $this->redirect("admin");

    }
}