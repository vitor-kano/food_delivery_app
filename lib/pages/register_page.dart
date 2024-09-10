// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:namer_app/components/login_button.dart';
import 'package:namer_app/components/text_field.dart';
import 'package:namer_app/services/authentication/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  void register(BuildContext context) async{
    //get auth service
    final authService = AuthService();
    //show loading circle
    showDialog(context: context ,builder: (context) => const Center(child: CircularProgressIndicator()));
    //check if passwords match -> create user
    if(passwordController.text != confirmPasswordController.text){
      if(context.mounted) Navigator.pop(context);
      showDialog(
        context: context,
        builder: ((context) => const AlertDialog(
          title: Text("As senhas não coincidem... Digite-as novamente."),
        ))
      );
    }
    else{
      try{
        if(context.mounted) Navigator.pop(context);
        await authService.signUpWithEmailPassword(emailController.text, passwordController.text);
      }
      catch (e){
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            )
          );
        }
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //LOGOTIPO
            Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary
            ),
            //SLOGAN
            const Text('Vamos criar uma conta para você!'),

            const SizedBox(height: 25),

            //CAMPO EMAIL
            MyTextField(
              controller: emailController,
              hintText: 'Digite seu e-mail',
              obscureText: false,
            ),

            const SizedBox(height: 10),

            //CAMPO SENHA
            MyTextField(
              controller: passwordController,
              hintText: 'Digite sua senha',
              obscureText: true,
            ),

            const SizedBox(height: 10),
            //CAMPO CONFIRMAR SENHA
            MyTextField(
              controller: confirmPasswordController,
              hintText: 'Confirme sua senha',
              obscureText: true,
            ),

            const SizedBox(height: 25),

            //BOTÃO REGISTRE-SE 
            MyLoginButton(
              text: 'Cadastrar',
              onTap: () => register(context),
            ),
            //JÁ TEM UMA CONTA? FAÇA LOGIN AQUI: 
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //"JÁ TEM UMA CONTA? FAÇA LOGIN.."
                Text(
                  'Já tem uma conta? Faça login',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(width: 5),
                //Register_page -> Login_page
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'AQUI',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ]
        ),
      )
    );
  }
} 