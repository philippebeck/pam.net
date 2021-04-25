<?php

namespace App\Controller;

use Pam\Controller\MainController;
use Pam\Model\ModelFactory;
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
     * @var array
     */
    private $property = []; 

    public function defaultMethod()
    {
        $this->redirect("home");
    }

    private function setPropertyData()
    {   
        $this->property["property"]     = (string) trim($this->getPost("property"));
        $this->property["visibility"]   = (string) trim($this->getPost("visibility"));
        $this->property["value_type"]   = (string) trim($this->getPost("value_type"));

        $this->property["static"]   = (int) $this->getPost("static");
        $this->property["class_id"] = (int) $this->getPost("class_id");
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
            $this->setPropertyData();

            ModelFactory::getModel("Property")->createData($this->property);

            $this->setSession([
                "New Property successfully created !", 
                "green"
            ]);

            $this->redirect("admin");
        }

        $classes = ModelFactory::getModel("Class")->listData();

        return $this->render("back/createProperty.twig", ["classes" => $classes]);
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
            $this->setPropertyData();

            ModelFactory::getModel("Property")->updateData(
                $this->getGet("id"), 
                $this->property
            );

            $this->setSession([
                "Successful modification of the selected Property !", 
                "blue"
            ]);

            $this->redirect("admin");
        }

        $property   = ModelFactory::getModel("Property")->readData($this->getGet("id"));
        $classes    = ModelFactory::getModel("Class")->listData();

        return $this->render("back/updateProperty.twig", [
            "property"  => $property,
            "classes"   => $classes
        ]);
    }

    public function deleteMethod()
    {
        if ($this->checkAdmin() !== true) {
            $this->redirect("home");
        }

        ModelFactory::getModel("Property")->deleteData($this->getGet("id"));

        $this->setSession([
            "Property permanently deleted !", 
            "red"
        ]);

        $this->redirect("admin");

    }
}