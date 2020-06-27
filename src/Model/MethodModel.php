<?php

namespace App\Model;

use Pam\Model\MainModel;

/**
 * Class MethodModel
 * @package App\Model
 */
class MethodModel extends MainModel
{
    public function listMethodsWithClass()
    {
        $query = "SELECT * FROM Method
                INNER JOIN Class ON Method.class_id = Class.id
                ORDER BY Method.id";

        return $this->database->getAllData($query);
    }
}
