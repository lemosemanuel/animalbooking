import 'dart:ui';

import 'package:flutter/material.dart';

class CardsTablesHome extends StatelessWidget {
  dynamic avatarType;
  CardsTablesHome({Key? key,required this.avatarType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children:  [

        const TableRow(
          
          children: [
            SingleCard(page: 'petscreen',icon: Icon(Icons.pets), color: Colors.cyan, text: "my pets"),
            SingleCard(page:'HostChoice',icon: Icon(Icons.house), color: Colors.greenAccent, text: "Hospedaje"),
          ]
        ),

        TableRow(
          children: [
            if(avatarType.contains("walker"))...[              
              SingleCard(page: 'walkers',icon: Image(image: AssetImage('assets/paseador.png'),width: 30,height:30), color: Colors.yellow.shade400, text: "Paseador"),
            ]else...[
            SingleCard(page:'findHost',icon: Icon(Icons.medical_services_outlined), color: Colors.red.shade200, text: "Veterinario"),
              SingleCard(page: 'walkers',icon: Image(image: AssetImage('assets/paseador.png'),width: 30,height:30), color: Colors.grey.shade700, text: "Paseador"),
            ],
            SingleCard(page:'findHost',icon: Icon(Icons.medical_services_outlined), color: Colors.red.shade200, text: "Veterinario"),
          ]
        )
      ],
    );
  }
}


class SingleCard extends StatelessWidget {
  final String page;
  final dynamic? icon;
  final Color color;
  final String text;

  const SingleCard({Key? key,required this.page, required this.icon, required this.color, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, page),
      child: Container(
        margin: const EdgeInsets.all(15),
        child:ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(62, 66, 107, 0.7),
                borderRadius: BorderRadius.circular(20)
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  CircleAvatar(
                    backgroundColor: color,
                    child: icon,
                    // child: Icon(icon),
                    radius: 30,
                  ),
                  const SizedBox(height: 10,),
                  Text( text ,style: TextStyle(color: color,fontSize: 18),)
                ],
              ),
              ),
            ),
        )
      ),
    );
  }
}