<?php

namespace App\Controller;

use Pam\Controller\MainController;
use Pam\Model\ModelFactory;
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

    private function setMethodData()
    {
        $this->method["method"]     = (string) trim($this->getPost("method"));
        $this->method["visibility"] = (string) trim($this->getPost("visibility"));
        $this->method["parameters"] = (string) trim($this->getPost("parameters"));
        $this->method["return"]     = (string) trim($this->getPost("return"));
        $this->method["detail"]     = (string) trim($this->getPost("detail"));

        $this->method["static"]     = (int) $this->getPost("static");
        $this->method["class_id"]   = (int) $this->getPost("class_id");
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
            $this->setMethodData();

            ModelFactory::getModel("Method")->createData($this->method);

            $this->setSession([
                "message"   => "New Method successfully created !", 
                "type"      => "green"
            ]);

            $this->redirect("admin");
        }

        $classes = ModelFactory::getModel("Class")->listData();

        return $this->render("back/createMethod.twig", ["classes" => $classes]);
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
            $this->setMethodData();

            ModelFactory::getModel("Method")->updateData(
                $this->getGet("id"), 
                $this->method
            );

            $this->setSession([
                "message"   => "Successful modification of the selected Method !", 
                "type"      => "blue"
            ]);

            $this->redirect("admin");
        }

        $method     = ModelFactory::getModel("Method")->readData($this->getGet("id"));
        $classes    = ModelFactory::getModel("Class")->listData();

        return $this->render("back/updateMethod.twig", [
            "method"    => $method,
            "classes"   => $classes
        ]);
    }

    public function deleteMethod()
    {
        if ($this->checkAdmin() !== true) {
            $this->redirect("home");
        }

        ModelFactory::getModel("Method")->deleteData($this->getGet("id"));

        $this->setSession([
            "message"   => "Method permanently deleted !", 
            "type"      => "red"
        ]);

        $this->redirect("admin");

    }
}