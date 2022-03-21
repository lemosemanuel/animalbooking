
import 'package:animal_booking/providers/providers.dart';
import 'package:animal_booking/screen/screen.dart';
import 'package:animal_booking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CustomBottomNavigation extends StatelessWidget {
  
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final indexSelected=Provider.of<IndexBottonNavigation>(context);

    int currentIndex=indexSelected.selectedIndex;
    
    

    return BottomNavigationBar(
      
      onTap:(value) {
        indexSelected.setSelectedIndex=value;
        switch (value) {
          case 0:
            Navigator.popAndPushNamed(context, 'home');
            break;
          case 1:
            Navigator.popAndPushNamed(context, 'reservation');
            break;
          case 2:
            Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ScanButton()),
                    (Route<dynamic> route) => false,
                  );
            break;
          case 3:
            Navigator.popAndPushNamed(context, 'petscreen');
            break;
          case 4:
            Navigator.popAndPushNamed(context, 'profile');
            break;
          }
      },
      // showSelectedLabels: false,
      showUnselectedLabels: true,
      // iconSize: 30,
      // selectedItemColor: Colors.lightGreenAccent.shade400,

      selectedItemColor: Colors.amber,

      type: BottomNavigationBarType.fixed,
      // backgroundColor: const Color.fromRGBO(55, 57, 84, 1),
      backgroundColor: Colors.white,

      
      unselectedItemColor: const Color.fromRGBO(16, 117, 152, 1),
      currentIndex: currentIndex,
      items: const [

        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home'
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: 'Reservas'
        ),

        
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code),
          label: 'QR'
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.pets),
          label: 'MyPet'
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile'
        ),
      ]
    );
  }
}
