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
     * @var array
     */
    private $property = []; 

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
            $this->setPropertyData();

            ModelFactory::getModel("Property")->createData(
                $this->property
            );

            $this->getSession()->createAlert(
                "New Property successfully created !", 
                "green"
            );

            $this->redirect("admin");
        }

        $classes = ModelFactory::getModel("Class")->listData();

        return $this->render("back/property/createProperty.twig", [
            "classes" => $classes
        ]);
    }

    private function setPropertyData()
    {
        $this->property = $this->getPost()->getPostArray();
        
        $this->property["property"] = (string) trim(
            $this->property["property"]
        );

        $this->property["visibility"] = (string) trim(
            $this->property["visibility"]
        );

        $this->property["value_type"] = (string) trim(
            $this->property["value_type"]
        );

        $this->property["constant"]   = (int) $this->property["constant"];
        $this->property["static"]     = (int) $this->property["static"];
        $this->property["class_id"]   = (int) $this->property["class_id"];
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
            $this->setPropertyData();

            ModelFactory::getModel("Property")->updateData(
                $this->getGet()->getGetVar("id"), 
                $this->property
            );

            $this->getSession()->createAlert(
                "Successful modification of the selected Property !", 
                "blue"
            );

            $this->redirect("admin");
        }

        $property = ModelFactory::getModel("Property")->readData(
            $this->getGet()->getGetVar("id")
        );

        $classes = ModelFactory::getModel("Class")->listData();

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

        ModelFactory::getModel("Property")->deleteData(
            $this->getGet()->getGetVar("id")
        );

        $this->getSession()->createAlert(
            "Property permanently deleted !", 
            "red"
        );

        $this->redirect("admin");

    }
}