import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          style: BorderStyle.solid
        ), 
      ),
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  'R\$4.99',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Taxa de Entrega',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            Column(
              children: [
                Text('30 a 40min', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500)),
                Text('Previsão de Entrega', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500))
              ],
            ),   
          ]
        )
    );
  }
}