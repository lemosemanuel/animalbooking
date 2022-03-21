import 'package:animal_booking/screen/screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:awesome_card/awesome_card.dart';


class PaymentScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Metodo de pago',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Metodo de pago'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  late FocusNode _focusNode;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        actions: [],
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            CreditCard(
              cardNumber: cardNumber,
              cardExpiry: expiryDate,
              cardHolderName: cardHolderName,
              cvv: cvv,
              bankName: 'Tu banco',
              showBackSide: showBack,
              frontBackground: CardBackgrounds.black,
              backBackground: CardBackgrounds.white,
              showShadow: true,
              // mask: getCardTypeMask(cardType: CardType.americanExpress),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    controller: cardNumberCtrl,
                    decoration: InputDecoration(hintText: 'Numero de tarjeta'),
                    maxLength: 16,
                    onChanged: (value) {
                      final newCardNumber = value.trim();
                      var newStr = '';
                      final step = 4;

                      for (var i = 0; i < newCardNumber.length; i += step) {
                        newStr += newCardNumber.substring(
                            i, math.min(i + step, newCardNumber.length));
                        if (i + step < newCardNumber.length) newStr += ' ';
                      }

                      setState(() {
                        cardNumber = newStr;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    controller: expiryFieldCtrl,
                    decoration: InputDecoration(hintText: 'Fecha de Expiracion'),
                    maxLength: 5,
                    onChanged: (value) {
                      var newDateValue = value.trim();
                      final isPressingBackspace =
                          expiryDate.length > newDateValue.length;
                      final containsSlash = newDateValue.contains('/');

                      if (newDateValue.length >= 2 &&
                          !containsSlash &&
                          !isPressingBackspace) {
                        newDateValue = newDateValue.substring(0, 2) +
                            '/' +
                            newDateValue.substring(2);
                      }
                      setState(() {
                        expiryFieldCtrl.text = newDateValue;
                        expiryFieldCtrl.selection = TextSelection.fromPosition(
                            TextPosition(offset: newDateValue.length));
                        expiryDate = newDateValue;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Nombre de la Persona'),
                    onChanged: (value) {
                      setState(() {
                        cardHolderName = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'CVV'),
                    maxLength: 3,
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                    focusNode: _focusNode,
                  ),
                ),
              ],
            ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 140),
            child: MaterialButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoadingMonkeyScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.indigo,
                elevation: 0,
                height: 50,
                color: Colors.amber,
                child:Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                  child:const Text('Reservar',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                  )
              ),
          )
          ],
        ),
      ),
    );
  }
}



class SuccessfulPayment extends StatefulWidget {
  const SuccessfulPayment({Key? key}) : super(key: key);

  @override
  State<SuccessfulPayment> createState() => _SuccessfulPaymentState();
}

class _SuccessfulPaymentState extends State<SuccessfulPayment> {
  @override
  
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
            Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ReservationDetailsScreen()),
            (Route<dynamic> route) => false,
          );
        });
    
    return Scaffold(
             backgroundColor: Colors.white,
        body: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Container(              
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text("Perfecto !! tu pago se realizo con exito !",style: TextStyle(color: Colors.amber,fontSize: 30)),
              )
              ),

            const SizedBox(height: 50,),

            const Image(image: AssetImage('assets/img/paying_accepted.gif')),


           ]
        )
      )
      
    );
  }
}
