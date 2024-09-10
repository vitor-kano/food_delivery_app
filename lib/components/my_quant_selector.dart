import 'package:flutter/material.dart';
import 'package:namer_app/models/food.dart';

class MyQuantSelector extends StatelessWidget {
  final int quantity;
  final Food food;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const MyQuantSelector({
    super.key,
    required this.quantity,
    required this.food,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.surface
      ),
      padding: const EdgeInsets.all(9),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //BOTÃO "-" DIMINUI QTD.
          GestureDetector(
            onTap: onDecrement,
            child: Icon(
              Icons.remove,
              size: 20,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          //CONTADOR DE QTD. DE ITENS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: 20,
              child: Center(
                child: Text(quantity.toString())
              ),
            ),
          ),

          //BOTÃO "+" AUMENTA QTD.
          GestureDetector(
            onTap: onIncrement,
            child: Icon(
              Icons.add,
              size: 20,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ],
      )
    );
  }
}