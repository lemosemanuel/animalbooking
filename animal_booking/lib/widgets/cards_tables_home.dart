import 'dart:ui';

import 'package:flutter/material.dart';

class CardsTablesHome extends StatelessWidget {
  const CardsTablesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children:  [

        const TableRow(
          children: [
            _SingleCard(page: 'petscreen',icon: Icons.pets, color: Colors.cyan, text: "Registro"),
            _SingleCard(page:'hosters',icon: Icons.house, color: Colors.greenAccent, text: "Hospedaje"),
          ]
        ),

        TableRow(
          children: [
            _SingleCard(page: 'walkers',icon: Icons.nordic_walking, color: Colors.yellow.shade400, text: "Paseador"),
            _SingleCard(page:'findHost',icon: Icons.volunteer_activism, color: Colors.red.shade200, text: "Veterinario"),
          ]
        )
      ],
    );
  }
}


class _SingleCard extends StatelessWidget {
  final String page;
  final IconData icon;
  final Color color;
  final String text;

  const _SingleCard({Key? key,required this.page, required this.icon, required this.color, required this.text}) : super(key: key);

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
                    child: Icon(icon),
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