import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:namer_app/models/food.dart';

// ignore: must_be_immutable
class FoodTile extends StatelessWidget {
  final Food food;
  void Function()? onTap;

  FoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                //DETALHES DO ITEM (TEXTO)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(food.name),
                      Text(
                        'R\$${food.price}',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary)
                      ),
                      const SizedBox(height: 10),
                      Text(
                        food.description,
                        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)
                      ),
                    ],
                  ),
                ),
                //IMAGEM DO ITEM
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(
                    food.imagePath,
                    height: 120,
                    width: 120,
                  ),
                ),
              ],
            ),
          )
        ),
        //divider
        Divider(color: Theme.of(context).colorScheme.secondary),
      ],
    );
  }
}