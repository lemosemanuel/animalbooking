import 'package:animal_booking/screen/payment_screen.dart';
import 'package:animal_booking/ux_ui/background/background_home.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
   
  const LoadingScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:const [
          
            BackgroundHome(),
            Center(
              child: Image(image: AssetImage('assets/img/gato-volando.gif'),)
            ),

          
        ],
      ),
    );
  }
}


class LoadingMonkeyScreen extends StatelessWidget {
   
  const LoadingMonkeyScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SuccessfulPayment()),
        (Route<dynamic> route) => false,
      );
    });
    return Scaffold(
      body: Stack(
        children:[
          
            const BackgroundHome(),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 30,),

                    Text("Estamos procesando tu Pago",style: TextStyle(color: Colors.black,fontSize: 35),),
                    SizedBox(height: 20,),
                    Image(image: AssetImage('assets/img/loading_monkey.gif'),),

                  ],
                ),
              )
            ),

          
        ],
      ),
    );
  }
}