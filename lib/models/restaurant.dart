
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/models/cart_item.dart';
import 'package:namer_app/models/food.dart';

class Restaurant extends ChangeNotifier{

  //LISTA "MENU" DE "FOODS"
  final List<Food> _menu = [
    
    //HAMBURGUERS
    Food(
      name: 'El Classico',
      description: "Um hamburguer de 150gr com cheddar derretido, uma folha de alface e duas rodelas de tomate",
      imagePath: 'lib/images/cheese_burger_AI_generated.png',
      price: 15.99,
      category: FoodCategory.lanches,
      availableAddons: [
        Addon(name: "Burger Adicional", price: 4.99),
        Addon(name: "Tomate", price: 1.99),
        Addon(name: "Queijo Adicional", price: 2.99),
        Addon(name: "Ovo adicional", price: 3.99),
      ]
    ),
    Food(
      name: 'El Duplo Classico',
      description: "Dois hamburgueres de 150gr com cheddar derretido, uma folha de alface e duas rodelas de tomate",
      imagePath: 'lib/images/double_cheeseburger_AI_generated.png',
      price: 18.99,
      category: FoodCategory.lanches,
      availableAddons: [
        Addon(name: "Burger Adicional", price: 4.99),
        Addon(name: "Tomate", price: 1.99),
        Addon(name: "Queijo Adicional", price: 2.99),
        Addon(name: "Ovo adicional", price: 3.99),
      ]
    ),
    Food(
      name: 'Ribs on Pattys',
      description: "Carne de Costela Bovina de 160gr com blue cheese derretido, agrião, picles e molho ranch",
      imagePath: 'lib/images/COSTELA-BOVINA.png',
      price: 20.99,
      category: FoodCategory.lanches,
      availableAddons: [
        Addon(name: "Burger Adicional", price: 4.99),
        Addon(name: "Tomate", price: 1.99),
        Addon(name: "Queijo Adicional", price: 2.99),
        Addon(name: "Ovo adicional", price: 3.99),
      ]
    ),
    Food(
      name: 'Master Bacon Crocante',
      description: "Um hamburguer de 150gr com cheddar derretido, muitas fatias de bacon crocante e molho bbq especial da casa",
      imagePath: 'lib/images/MASTER-BACON-CROCANTE.png',
      price: 19.99,
      category: FoodCategory.lanches,
      availableAddons: [
        Addon(name: "Burger Adicional", price: 4.99),
        Addon(name: "Tomate", price: 1.99),
        Addon(name: "Queijo Adicional", price: 2.99),
        Addon(name: "Ovo adicional", price: 3.99),
      ]
    ),
    Food(
      name: 'SUPREME',
      description: "Um hamburguer de 180gr com cheddar derretido, alface, tomate, cebola caramelizada, onion rings, bacon, molho especial da casa",
      imagePath: 'lib/images/SUPREME.png',
      price: 22.99,
      category: FoodCategory.lanches,
      availableAddons: [
        Addon(name: "Burger Adicional", price: 4.99),
        Addon(name: "Tomate", price: 1.99),
        Addon(name: "Queijo Adicional", price: 2.99),
        Addon(name: "Ovo adicional", price: 3.99),
      ]
    ),
    
    //PORÇÕES
    Food(
      name: 'Batata Frita',
      description: "Batata Frita crocante e fininha, temperada com sal, pimenta do reino e páprica",
      imagePath: 'lib/images/BATATA-FRITA.png',
      price: 7.99,
      category: FoodCategory.porcoes,
      availableAddons: [
        Addon(name: "Cheddar Adicional", price: 2.99),
        Addon(name: "Bacon Adicional", price: 4.99),
      ]
    ),
    Food(
      name: 'Batata Frita C/ Cheddar e Bacon',
      description: "Batata Frita crocante e fininha, temperada com sal, pimenta do reino e páprica, com cheddar e bacon por cima",
      imagePath: 'lib/images/BATATA-COM-CHEDDAR-E-BACON.png',
      price: 12.99,
      category: FoodCategory.porcoes,
      availableAddons: [
        Addon(name: "Cheddar Adicional", price: 2.99),
        Addon(name: "Bacon Adicional", price: 4.99),
      ]
    ),
    //SOBREMESAS

    //DRINKS

  ];
  
  //ENDEREÇO DE ENTREGA
  String _deliveryAddress = 'Avenida Brasil, 1322';
  /*
  * G E T T E R S
  */

  List<Food> get menu => _menu;

  List<CartItem> get cart => _cart;

  String get deliveryAddress => _deliveryAddress;

  /*
  * O P E R A T I O N S
  */

  //CRIAR O CARRINHO DO USUARIO
  final List<CartItem> _cart = [];
  
  //ADICIONAR ÀO CARRINHO 
  void addToCart(Food food, List<Addon> selectedAddons ){
    //see if there is a cart item already with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item){
      //check if the food items are the same
      bool isSameFood = item.food == food;

      //check if the list of selected addons are the same
      bool isSameAddons = 
        const ListEquality().equals(item.selectedAddons, selectedAddons);
      
      return isSameFood && isSameAddons; 
    });

    //if the item already exists on the cart, increase quantity:
    if (cartItem != null){
      cartItem.quantity++;
    }
    //otherwise add new cart item
    else{
      _cart.add(
        CartItem(food: food, selectedAddons: selectedAddons),
      );
    }
    notifyListeners();
  }
  
  //REMOVER DO CARRINHO
  void removeFromCart(CartItem cartItem){
    int cartIndex = _cart.indexOf(cartItem);

    if(cartIndex != -1){
      if(_cart[cartIndex].quantity > 1){
        _cart[cartIndex].quantity--;
      }
      else{
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }
  
  //GET O PREÇO TOTAL DO CARRINHO
  double getTotalPrice(){
    double total = 0.0;

    for(CartItem cartItem in _cart){
      double itemTotal = cartItem.food.price;

      for(Addon addon in cartItem.selectedAddons){
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }
  
  //GET O Nº TOTAL DE ITENS NO CARRINHO
  int getTotalItemCount(){
    int totalItemCount = 0;

    for (CartItem cartItem in _cart){
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }
  
  //"LIMPAR" O CARRINHO
  void clearCart(){
    _cart.clear();
    notifyListeners();
  }

  // ATUALIZAR O ENDEREÇO
  void updateDeliveryAddress(String newAddress){
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  /*
  * H E L P E R S
  */

  //GERAR UM COMPROVANTE
  String displayCartReceipt(){
    final receipt = StringBuffer();
    receipt.writeln(("Aqui está o seu pedido:"));
    receipt.writeln();

    //format the date to include up to seconds only
    String formattedDate = DateFormat('yyyy-M-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("---------------------------");

    for(final cartItem in _cart){
      receipt.writeln(
        "${cartItem.quantity} x ${cartItem.food.name} - R${_formatPrice(cartItem.food.price)}"
      );
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln("     Complementos: ${_formatAddons(cartItem.selectedAddons)}");
        receipt.writeln();
      }
    }

    receipt.writeln("---------------------------");
    receipt.writeln();
    receipt.writeln("Total itens: ${getTotalItemCount()}");
    receipt.writeln("Total preço: R${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Entregando para: $deliveryAddress");

    return receipt.toString();
  }
  
  //FORMATAR O VALOR "DOUBLE" EM DINHEIRO
  String _formatPrice(double price){
    return "\$${price.toStringAsFixed(2)}";
  }
  
  //FORMATAR LISTA DE COMPLEMENTOS EM UMA STRING
  String _formatAddons(List<Addon> addons){
    return addons
      .map((addon) => "${addon.name} (R${_formatPrice(addon.price)})")
      .join(", ");
  }
}