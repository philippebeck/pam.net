<?php

namespace App\Controller;

use Pam\Controller\MainController;
use Pam\Model\Factory\ModelFactory;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Error\SyntaxError;

/**
 * Class MethodController
 * @package App\Controller
 */
class MethodController extends MainController
{
    /**
     * @var array
     */
    private $method = [];

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
            $this->setMethodData();

            ModelFactory::getModel("Method")->createData($this->method);
            $this->getSession()->createAlert("New Method successfully created !", "green");

            $this->redirect("admin");
        }

        $classes = ModelFactory::getModel("Class")->listData();

        return $this->render("back/method/createMethod.twig", ["classes" => $classes]);
    }

    private function setMethodData()
    {
        $this->method = $this->getPost()->getPostArray();

        $this->method["method"]     = (string) trim($this->method["method"]);
        $this->method["parameters"] = (string) trim($this->method["parameters"]);
        $this->method["return"]     = (string) trim($this->method["return"]);

        $this->method["static"]     = (int) $this->method["static"];
        $this->method["class_id"]   = (int) $this->method["class_id"];
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
            $this->setMethodData();

            ModelFactory::getModel("Method")->updateData($this->getGet()->getGetVar("id"), $this->method);
            $this->getSession()->createAlert("Successful modification of the selected Method !", "blue");

            $this->redirect("admin");
        }

        $method     = ModelFactory::getModel("Method")->readData($this->getGet()->getGetVar("id"));
        $classes    = ModelFactory::getModel("Class")->listData();


        return $this->render("back/method/updateMethod.twig", [
            "method"    => $method,
            "classes"   => $classes
        ]);
    }

    public function deleteMethod()
    {
        if ($this->getSecurity()->checkIsAdmin() !== true) {
            $this->redirect("home");
        }

        ModelFactory::getModel("Method")->deleteData($this->getGet()->getGetVar("id"));
        $this->getSession()->createAlert("Method permanently deleted !", "red");

        $this->redirect("admin");

    }
}