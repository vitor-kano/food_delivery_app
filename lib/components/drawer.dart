import 'package:flutter/material.dart';
import 'package:namer_app/components/my_drawer_tile.dart';
//import 'package:namer_app/pages/login_page.dart';
import 'package:namer_app/pages/settings_page.dart';
import 'package:namer_app/services/authentication/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //app LOGO icon
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.lock_open_rounded,
              color: Theme.of(context).colorScheme.tertiary,
              size: 40,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              indent: 3.0,
              color: Theme.of(context).colorScheme.inversePrimary,
              thickness: 3.0,
            ),
          ),
          //Home List Tile
          MyDrawerTile(
            text: 'HOME',
            icon: Icons.home_rounded,
            onTap: () => Navigator.pop(context),
          ),
          //settings list tile
          MyDrawerTile(
            text: 'OPÇÕES',
            icon: Icons.settings_rounded,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: ((context) => const SettingsPage())));
            },
          ),

          const Spacer(flex: 10),

          //logout list tile
          MyDrawerTile(
            text: 'SAIR',
            icon: Icons.logout_rounded,
            onTap: logout,
          ),
        ]
      )
    );
  }
}