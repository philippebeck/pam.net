<?php

namespace App\Controller;

use Pam\Controller\MainController;
use Pam\Model\ModelFactory;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Error\SyntaxError;

/**
 * Class AuthController
 * @package App\Controller
 */
class AuthController extends MainController
{
    /**
     * @var array
     */
    private $user = [];

    /**
     * @return string
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    public function defaultMethod()
    {
        if ($this->checkGlobal($this->getPost())) {

            $this->user = $this->getPost();
            $this->CheckSecurity();
        }

        return $this->render("front/login.twig");
    }

    private function CheckSecurity()
    {
        if (isset($this->user["g-recaptcha-response"]) && !empty($this->user["g-recaptcha-response"])) {

            if ($this->checkRecaptcha($this->user["g-recaptcha-response"])) {
                $this->checkLogin();
            }
        }

        $this->setSession([
            "Check the reCAPTCHA !", 
            "red"
        ]);

        $this->redirect("user");
    }

    private function checkLogin()
    {
        $user = ModelFactory::getModel("User")->readData(
            $this->user["email"], 
            "email"
        );

        if (!password_verify($this->user["pass"], $user["pass"])) {
            $this->setSession([
                "Failed authentication !", 
                "black"
            ]);

            $this->redirect("user");
        }

        $this->setSession($user, true);
        
        $this->setSession([
            "Successful authentication, welcome " . $user["name"] . " !", 
            "violet"
        ]);

        $this->redirect("admin");
    }

    public function logoutMethod()
    {
        $this->getSession()->destroySession();

        $this->redirect("home");
    }
}
