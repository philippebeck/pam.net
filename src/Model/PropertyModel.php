<?php

namespace App\Model;

use Pam\Model\MainModel;

/**
 * Class PropertyModel
 * @package App\Model
 */
class PropertyModel extends MainModel
{
    public function listPropertiesWithClass()
    {
        $query = "SELECT * FROM Property
                INNER JOIN Class ON Property.class_id = Class.id
                ORDER BY Property.id";

        return $this->database->getAllData($query);
    }
}
