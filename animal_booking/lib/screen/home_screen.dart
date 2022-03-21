import 'package:animal_booking/ux_ui/background/background_home.dart';
import 'package:animal_booking/widgets/widgets.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const[
          BackgroundHome(),
          _HomeBody()
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 40,),
          // title
          _PageTitle(),

          SizedBox(height: 40,),

          // Cards
          CardsTablesHome()
        ],
      ),
    );
  }
}



class _PageTitle extends StatelessWidget {
  const _PageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 10,),
            Text('Bienvenido a Animal Booking',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(16, 117, 152, 1)),),
            SizedBox(height: 10,),
            Text('La felicidad tiene 4 patas',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color:Color.fromRGBO(16, 117, 152, 1)))
          ],
        ),
      ),
    );
  }
}

