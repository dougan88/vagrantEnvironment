<?php
/**
 * Created by PhpStorm.
 * User: Eugene
 * Date: 09.12.2016
 * Time: 16:32
 */
namespace ProductShop\Product;
use ProductShop\PriceManipulation;

class Strawberry implements Product {

    use PriceManipulation;

    public $price;

    public function getProductPrice()
    {
        return $this->price;
    }

    public function getProductDescription()
    {
        // TODO: Implement getProductDescription() method.
    }
}