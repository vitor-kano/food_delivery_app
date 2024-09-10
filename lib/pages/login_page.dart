import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/components/login_button.dart';
import 'package:namer_app/components/text_field.dart';
//import 'package:namer_app/pages/home_page.dart';
import 'package:namer_app/services/authentication/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //method to login
  void login(BuildContext context) async{
    //get instance of auth service
    final authService = AuthService();

    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //try sign in
    try{
      if(context.mounted) Navigator.pop(context);
      await authService.signInWithEmailPassword(emailController.text, passwordController.text);   
    } on FirebaseAuthException {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Não existe esse usuário ou senha. Digite novamente."),
          )
        );
      }
    } catch (e){
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
            //SLOGAN DO APP
            const Text('Seu Aplicativo de Delivery'),

            const SizedBox(height: 25),

            //CAMPO DIGIT. EMAIL
            MyTextField(
              controller: emailController,
              hintText: 'Digite seu e-mail',
              obscureText: false,
            ),

            const SizedBox(height: 10),

            //CAMPO DIGIT. SENHA
            MyTextField(
              controller: passwordController,
              hintText: 'Digite sua senha',
              obscureText: true,
            ),

            const SizedBox(height: 25),

            //BOTÃO P/ LOGAR
            MyLoginButton(
              text: 'Entrar',
              onTap: () => login(context),
            ),
            //"AINDA NÃO É MEMBRO? CADASTRE-SE AGORA!"

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Não é membro ainda?
                Text(
                  'Não é membro ainda?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(width: 5),
                //Cadastre-se agora! -> REGISTER_PAGE
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Cadastre-se agora!',
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