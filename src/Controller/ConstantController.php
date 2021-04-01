<?php

namespace App\Controller;

use Pam\Controller\MainController;
use Pam\Model\Factory\ModelFactory;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Error\SyntaxError;

/**
 * Class ConstantController
 * @package App\Controller
 */
class ConstantController extends MainController
{
    /**
     * @var array
     */
    private $constant = []; 

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
            $this->setConstantData();

            ModelFactory::getModel("Constant")->createData($this->constant);
            $this->getSession()->createAlert("New Constant successfully created !", "green");

            $this->redirect("admin");
        }

        return $this->render("back/constant/createConstant.twig");
    }

    private function setConstantData()
    {       
        $this->constant["name"]     = (string) trim($this->getPost()->getPostVar("name"));
        $this->constant["category"] = (string) trim($this->getPost()->getPostVar("category"));
        $this->constant["valor"]    = (string) trim($this->getPost()->getPostVar("valor"));

        $this->constant["to_replace"] = (int) $this->getPost()->getPostVar("to_replace");
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
            $this->setConstantData();

            ModelFactory::getModel("Constant")->updateData($this->getGet()->getGetVar("id"), $this->constant);
            $this->getSession()->createAlert("Successful modification of the selected Constant !", "blue");

            $this->redirect("admin");
        }

        $constant = ModelFactory::getModel("Constant")->readData($this->getGet()->getGetVar("id"));

        return $this->render("back/constant/updateConstant.twig", [
            "constant"  => $constant
        ]);
    }

    public function deleteMethod()
    {
        if ($this->getSecurity()->checkIsAdmin() !== true) {
            $this->redirect("home");
        }

        ModelFactory::getModel("Constant")->deleteData($this->getGet()->getGetVar("id"));
        $this->getSession()->createAlert("Constant permanently deleted !", "red");

        $this->redirect("admin");
    }
}
