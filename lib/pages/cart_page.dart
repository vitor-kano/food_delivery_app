import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:namer_app/components/my_button.dart';
import 'package:namer_app/components/my_cart_tile.dart';
import 'package:namer_app/models/restaurant.dart';
import 'package:namer_app/pages/payment_page.dart';
import 'package:provider/provider.dart';
//import 'package:badges/badges.dart' as badges;

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        //CARRINHO
        final userCart = restaurant.cart;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Carrinho'),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              //BOTÃO P/ LIMPAR O CARRINHO
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Tem certeza que quer esvaziar seu carrinho?"),
                      actions: [
                        //BOTÃO "CANCEL"
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancelar"),
                        ),
                        //BOTÃO "SIM"
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();
                          },
                          child: const Text("Sim"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ]
          ),
          body: Column(
            children: [
              //LISTA DO CARRINHO
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty 
                    ? const Expanded(child: Center(child: Text("Seu Carrinho está vazio...")))
                    : Expanded(
                      child: ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          //SEPARA UM ITEM INDIVIDUAL DO CARRINHO
                          final cartItem = userCart[index];
                          
                          //RETORNA O UI DO TILE DO CARRINHO 
                          return MyCartTile(cartItem: cartItem);
                        },
                      ),
                    )
                  ],
                ),
              ),
              //BOTÃO PARA PAGAR
              AddToCartButton(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => const PaymentPage()))),
                text: "Ir para o pagamento"
              ),
              const SizedBox(height: 10.0),
            ],
          )
        );
      },
    );
  }
}