import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children:[
          // above box
          const _AboveBox(),
          
          // image stack Abovebox
          const _HeaderIcon(),

          this.child,
      ],
      )
    );
  }
}

class _AboveBox extends StatelessWidget {
  const _AboveBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get size of screen
    final size= MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height*0.4,
      decoration: _boxDecorationBackGround(),
      child: Stack(
        children: const[
          Positioned(
            top: 90,
            left: 30,
            child: _Bubble()
          ),

          Positioned(
            top: -40,
            left: -30,
            child: _Bubble()
          ),

          Positioned(
            top: 20,
            left: 300,
            child: _Bubble()
          ),
          
          Positioned(
            top: 200,
            left: 250,
            child: _Bubble()
          ),

          Positioned(
            top: 280,
            left: 20,
            child: _Bubble()
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecorationBackGround()=>
  const BoxDecoration(gradient: LinearGradient(
    colors: [
      Color.fromRGBO(255, 191, 90, 1),
      
      Color.fromRGBO(90, 70, 178, 1)
    ]));
}


class _Bubble extends StatelessWidget {
  const _Bubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:Color.fromRGBO(255, 255, 255, 0.05)
      ),
      child: Icon(Icons.pets,color:Color.fromRGBO(255, 255, 255, 0.05),size: 50,),
    );
  }
}


class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children:[
            Icon(Icons.pets,color: Colors.amber,size: 100,),
            Text("Animal Booking",style: TextStyle(fontSize:20,color: Colors.amber ),)
          ],
        ),
      ),
    );
  }
}