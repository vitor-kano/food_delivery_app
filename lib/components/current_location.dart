//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget {
  MyCurrentLocation({
    super.key,
  });

  final textController = TextEditingController();

  void openLocationSearchBox(BuildContext context){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sua localização aqui '),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Procurar Endereço: '
          ),
        ),
        actions: [
          //BOTÃO CANCELAR
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Cancelar"),
          ),
          //BOTÃO SALVAR
          MaterialButton(
            onPressed: () {
              //atualiza o endereço de entrega
              String newAddress = textController.text;
              context.read<Restaurant>().updateDeliveryAddress(newAddress);
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          ),
        ],
      )
    ); //show dialog
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Entregar agora',
            style: TextStyle(
              fontSize: 12.0,
              color: Theme.of(context).colorScheme.primary)
            ),
        ),
        //endereço
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                Consumer<Restaurant>(
                  builder: (context, restaurant, child) => Text(restaurant.deliveryAddress),
                ),
                Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).colorScheme.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}