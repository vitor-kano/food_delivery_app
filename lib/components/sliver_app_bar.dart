import 'package:flutter/material.dart';
import 'package:namer_app/models/restaurant.dart';
import 'package:namer_app/pages/cart_page.dart';
import 'package:provider/provider.dart';
//import 'package:badges/badges.dart' as badges;


class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  
  const MySliverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        Consumer<Restaurant>(
          builder: (context, restaurant, child) => 
          Text(restaurant.getTotalItemCount().toString()),
        ),
        IconButton(
          onPressed: () => {
            //VAI P/ Cart_page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyCartPage())
            ),
          }, 
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: const Text("COLOSSAL BURGUER", style: TextStyle(fontSize: 18.0, fontFamily: AutofillHints.name)),
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: FlexibleSpaceBar(
          background: child,
          title: title,
          centerTitle: true,
          titlePadding: const EdgeInsets.only(left: 1, right: 1, top: 1),
          expandedTitleScale: 1,
        ),
      )
    );
  }
}
