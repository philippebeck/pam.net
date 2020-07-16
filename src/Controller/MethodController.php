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
            $method = $this->getPost()->getPostArray();

            ModelFactory::getModel("Method")->createData($method);
            $this->getSession()->createAlert("New Method successfully created !", "green");
        }

        $classes = ModelFactory::getModel("Class")->listData();

        return $this->render("back/method/createMethod.twig", ["classes" => $classes]);
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
            $method = $this->getPost()->getPostArray();

            ModelFactory::getModel("Method")->updateData($this->getGet()->getGetVar("id"), $method);
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