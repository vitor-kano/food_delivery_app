//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:namer_app/components/my_button.dart';
import 'package:namer_app/pages/delivery_progress_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '' ;
  String cvvCode = '';
  String cardHolderName = '';
  bool isCvvFocused = false;
  String onCreditCardWidgetChange = '';

  //MÉTODO P/ USUÁRIO EFETUAR PAGAMENTO
  void userPayMethod(){
    if(formKey.currentState!.validate()){
      //SÓ APARECE O DIÁLOGO SE O FORM. FOR VÁLIDO
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirmar as informações para o Pagamento"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Nº do Cartão: $cardNumber"),
                Text("Data de Venc.: $expiryDate"),
                Text("Código Segurança (CVV): $cvvCode"),
                Text("Nome do Titular do Cartão: $cardHolderName"),
              ]
            )
          ),
          actions: [
            //BOTÃO CANCELAR
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            //BOTÃO PAGAR
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeliveryProgressPage()),
              ),
              child: const Text("Pagar"),
            ),
          ]
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Insira os dados do cartão."),
      ),
      body: CustomScrollView(
        shrinkWrap: false,
        slivers: [
          //CreditCardPackage
          SliverToBoxAdapter(
            child: CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cvvCode: cvvCode,
              cardHolderName: cardHolderName,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (p0){},
            ),
          ),
        
          //CreditCardForm
          SliverToBoxAdapter(
            //height: 200,
            child: CreditCardForm(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: (data){
                setState(() {
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cardHolderName = data.cardHolderName;
                  cvvCode = data.cvvCode;
                });
              },
              formKey: formKey,
            ),
          ),
          //const Spacer(),
          SliverToBoxAdapter(
            child: AddToCartButton(
              onTap: userPayMethod, 
              text: "Pagar com este cartão"
            )
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
        ],
      ),
    );
  }
}