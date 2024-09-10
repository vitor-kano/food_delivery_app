import 'package:flutter/material.dart';
import 'package:namer_app/components/current_location.dart';
import 'package:namer_app/components/description_box.dart';
import 'package:namer_app/components/drawer.dart';
import 'package:namer_app/components/my_food_tile.dart';
import 'package:namer_app/components/sliver_app_bar.dart';
import 'package:namer_app/components/tab_bar.dart';
import 'package:namer_app/models/food.dart';
import 'package:namer_app/models/restaurant.dart';
import 'package:namer_app/pages/food_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  //CONTROLLER TAB BAR
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();

  }
  //função que filtra e retorna os itens de comida que pertencem a uma categoria específica
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu){
    return fullMenu.where((food) => food.category == category).toList();
  }

  //função que retorna uma lista de comidas de uma certa categoria
  List<Widget> getFoodInThisCategory(List<Food> fullMenu){
    return FoodCategory.values.map((category) {

      //separa o menu de uma categoria específica
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);
      
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          //separa UM ITEM individual
          final food = categoryMenu[index];

          //retorna o Tile de UM ITEM
          return FoodTile(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodPage(food: food),)
            ),
          );
        },
      );
    }).toList();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(indent: 25, endIndent: 25, color: Theme.of(context).colorScheme.tertiary),

                //LOCALIZAÇÃO ATUAL
                MyCurrentLocation(),

                //BOX DE DESCRIÇÃO
                const MyDescriptionBox(),
              ],
            )
          ),
        ]),
        body: Consumer<Restaurant>(
          builder: (context, restaurant, child) => 
            TabBarView(
              controller: _tabController,
              children: getFoodInThisCategory(restaurant.menu),
            ),
        ),
        reverse: false,
      ),
    );
  }
}