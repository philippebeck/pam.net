<?php

namespace App\Controller;

use Pam\Controller\MainController;
use Pam\Model\ModelFactory;
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

    private function setConstantData()
    {       
        $this->constant["name"]     = (string) trim($this->getPost("name"));
        $this->constant["category"] = (string) trim($this->getPost("category"));
        $this->constant["valor"]    = (string) trim($this->getPost("valor"));

        $this->constant["to_replace"] = (int) $this->getPost("to_replace");
    }

    /**
     * @return string
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    public function createMethod()
    {
        if ($this->checkAdmin() !== true) {
            $this->redirect("home");
        }

        if ($this->checkArray($this->getPost())) {
            $this->setConstantData();

            ModelFactory::getModel("Constant")->createData($this->constant);

            $this->setSession([
                "New Constant successfully created !", 
                "green"
            ]);

            $this->redirect("admin");
        }

        return $this->render("back/createConstant.twig");
    }

    /**
     * @return string
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    public function updateMethod()
    {
        if ($this->checkAdmin() !== true) {
            $this->redirect("home");
        }

        if ($this->checkArray($this->getPost())) {
            $this->setConstantData();

            ModelFactory::getModel("Constant")->updateData(
                $this->getGet("id"), 
                $this->constant
            );

            $this->setSession([
                "Successful modification of the selected Constant !", 
                "blue"
            ]);

            $this->redirect("admin");
        }

        $constant = ModelFactory::getModel("Constant")->readData($this->getGet("id"));

        return $this->render("back/updateConstant.twig", ["constant" => $constant]);
    }

    public function deleteMethod()
    {
        if ($this->checkAdmin() !== true) {
            $this->redirect("home");
        }

        ModelFactory::getModel("Constant")->deleteData($this->getGet("id"));

        $this->setSession([
            "Constant permanently deleted !", 
            "red"
        ]);

        $this->redirect("admin");
    }
}
