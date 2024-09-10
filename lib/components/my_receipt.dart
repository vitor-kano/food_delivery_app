import 'package:flutter/material.dart';
import 'package:namer_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Obrigado pelo seu pedido!",
          ),
          const SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(25.0),
              child: Consumer<Restaurant>(
                builder: (context, restaurant, child) => Text(restaurant.displayCartReceipt()),
              ),
            ),
          const SizedBox(height: 25.0),
          const Text("Hora estimada da entrega: 20:30h ~ 20:40h"),
        ]
      ),
    );
  }
}