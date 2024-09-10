//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:namer_app/components/my_quant_selector.dart';
import 'package:namer_app/models/cart_item.dart';
//import 'package:namer_app/models/food.dart';
import 'package:namer_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  
  const MyCartTile({
    super.key,
    required this.cartItem
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                //IMAGEM DO ITEM
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      alignment: Alignment.center,
                      cartItem.food.imagePath,
                      height: 80,
                      width: 80,
                    )
                  ),
                ),
                //NOME E PREÇO
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //NOME DO ITEM DO CARRINHO
                        Text(cartItem.food.name, textWidthBasis: TextWidthBasis.parent,),
                        //PREÇO DO ITEM DO CARRINHO
                        Text('R\$${cartItem.food.price}', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                      ],),
                  ),
                ),
                //INCREMENTO OU DECREMENTO DA QUANTIDADE DE ITENS
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: MyQuantSelector(
                      quantity: cartItem.quantity,
                      food: cartItem.food,
                      onDecrement: () {
                        restaurant.removeFromCart(cartItem);
                      },
                      onIncrement: () {
                        restaurant.addToCart(cartItem.food, cartItem.selectedAddons);
                      },
                    ),
                  ),
                ),
              ]
            ),
            
            //COMPLEMENTOS
            SizedBox(
              height: cartItem.selectedAddons.isEmpty ? 0 : 60,
              child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: cartItem.selectedAddons.map(
                  (addon) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Row(
                        children: [
                          Text(addon.name),
                          Text(' R\$${addon.price}')
                        ],
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      onSelected: (value) {},
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ).toList(),
              )
            )
          ]  
        ),
      )
    );
  }
}