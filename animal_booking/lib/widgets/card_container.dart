import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: _createCardShape(),
        child: this.child,
      ),
    
    );
  }

  BoxDecoration _createCardShape() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 20,
          offset: Offset(0, 5)
        )
      ]

    );
  }
}