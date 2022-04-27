import 'package:animal_booking/providers/decodeJWT.dart';
import 'package:animal_booking/ux_ui/background/background_home.dart';
import 'package:animal_booking/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // final storage = new FlutterSecureStorage();
    // var token2=  storage.read(key: "jwt") as List;

    return FutureBuilder(
      future: decodeJwt(),
      builder: (context,dynamic snapshot){
        if (snapshot.hasData){
          return Scaffold(
            body: Stack(
              children: [
                BackgroundHome(),
                _HomeBody(name: snapshot.data['name'], avatarType: snapshot.data['avatar_type'],)
              ],
            ),
            bottomNavigationBar: const CustomBottomNavigation(),
          );

        }else{
          return Container();
        }
      },
    );
  }
}

class _HomeBody extends StatelessWidget {
  dynamic avatarType;
  dynamic name;
  _HomeBody({Key? key,required this.name,required this.avatarType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40,),
          // title
          _PageTitle(name:name,),

          SizedBox(height: 40,),

          // Cards
          CardsTablesHome(avatarType:avatarType! ,)
        ],
      ),
    );
  }
}



class _PageTitle extends StatelessWidget {
  dynamic name;
  _PageTitle({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            SizedBox(height: 10,),
            Text('Bienvenido ${name}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(16, 117, 152, 1)),),
            SizedBox(height: 10,),
            Text('La felicidad tiene 4 patas',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color:Color.fromRGBO(16, 117, 152, 1))),

          ],
        ),
      ),
    );
  }
}

