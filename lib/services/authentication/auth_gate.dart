import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/pages/home_page.dart';
import 'package:namer_app/services/authentication/login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user isn't logged in -> return login page
          if (!snapshot.hasData){
            return const LoginOrRegister();
          }
          //user is logged in -> return home page
          else {
            return const HomePage();
          }
        },
      )
    );
  }
}