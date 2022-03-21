import 'package:flutter/material.dart';
import 'dart:math';


class BackgroundHome extends StatelessWidget {
  const BackgroundHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const boxDecoration = BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2,0.8],
          colors: [
            // Color(0xff2E305F),
            // Color(0xff202333)
            Colors.white,
            Colors.white
          ]
        )
      );
    return Stack(
      children: [
        Container(
          decoration: boxDecoration
        ),
        const Positioned(
          top: -100,
          left: -30,
          child: _DecorationBox()
          )
      ],
    );
  }
}

class _DecorationBox extends StatelessWidget {
  const _DecorationBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 5,
      child: Container(
        width: 360,
        height: 360,
        // color: Colors.pink,
        decoration: BoxDecoration(
    
          borderRadius: BorderRadius.circular(80),
          gradient:  LinearGradient(
            colors: [
              Colors.amber,
              Colors.yellow.shade100
              // Color.fromRGBO(73,255,0,1),
              // Color.fromRGBO(255,255,255,1),
            ]
          )
        ),
      ),
    );
  }
}