import 'package:flutter/material.dart';
import 'package:namer_app/components/my_button.dart';
import 'package:namer_app/models/food.dart';
import 'package:namer_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};

  FoodPage({
    super.key,
    required this.food,
  }){
    //INICIALIZA OS COMPLEMENTOS SELECIONADOS COMO "FALSE"
    for (Addon addon in food.availableAddons){
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  //MÉTODO ADICIONA AO CARRINHO
  void addToCart(Food food, Map<Addon, bool> selectedAddons){
    
    //FECHA A PÁGINA ATUAL DO "ITEM SELECIONADO" PARA VOLTAR À HOMEPAGE
    Navigator.pop(context);

    //FORMATA OS COMPLEMENTOS SELECIONADOS
    List<Addon> currentlySelectedAddons = [];
    for(Addon addon in widget.food.availableAddons){
      if(widget.selectedAddons[addon] == true){
        currentlySelectedAddons.add(addon);
      }
    }

    //ADICIONA AO CARRINHO
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //IMAGEM DO ITEM (FOOD)
            Image.asset(widget.food.imagePath),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //NOME DO ITEM
                  Text(
                    widget.food.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 21.0,
                      decoration: TextDecoration.underline
                    )
                  ),
                  //PREÇO DO ITEM
                  Text(
                    'R\$${widget.food.price}',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 10.0),
                  //DESCRIÇÃO DO ITEM
                  Text(
                    widget.food.description,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  const SizedBox(height: 15.0),
                  Divider(
                    color: Theme.of(context).colorScheme.primary,
                    //endIndent: 5.0,
                    //indent: 5.0,
                  ),
                  const SizedBox(height: 15.0),

                  Text(
                    'Adicionais:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w700,
                    )
                  ),
                  const SizedBox(height: 8.0),
                  //COMPLEMENTOS
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.secondary,),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.food.availableAddons.length,
                      itemBuilder: ((context, index) {
                        //SEPARA UM COMPLEMENTO INDIVIDUAL
                        Addon addon = widget.food.availableAddons[index];
                                  
                        //RETORNA A UI DO CHECKBOX
                        return CheckboxListTile(
                          title: Text(addon.name),
                          subtitle: Text('R\$${addon.price}'),
                          value: widget.selectedAddons[addon],
                          onChanged: ((bool? value) {
                            setState(() {
                              widget.selectedAddons[addon] = value!;
                            });
                          })
                        );
                      })),
                  ),
                  const SizedBox(height: 25.0),
                  //BOTÃO P/ ADICIONAR O ITEM AO CARRINHO
                  AddToCartButton(
                    onTap: () => addToCart(widget.food, widget.selectedAddons),
                    text: 'Adicionar ao carrinho',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}