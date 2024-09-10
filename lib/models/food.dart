//import 'package:flutter/material.dart';

class Food{
  final String name;            //xburguer
  final String description;     //pao, hamburguer, queijo cheddar, molho
  final String imagePath;       //lib/images/xburguer.png
  final double price;           //$20.50
  final FoodCategory category;  //Lanches
  List<Addon> availableAddons;  //Adicionais: hamburguer, picles, cebola, cebola roxa, ketchup, mostarda...

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });
}

//CATEGORIAS DE "FOOD"
enum FoodCategory{
  lanches,
  porcoes,
  sobremesas,
  bebidas,
}

//COMPLEMENTOS DISPONÍVEIS
class Addon {
  String name;
  double price;
  
  Addon({
    required this.name,
    required this.price,
  });
}