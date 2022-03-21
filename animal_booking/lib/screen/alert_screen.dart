import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget {
   
  const AlertScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed:() => Navigator.of(context).pop(),)
      ),
      body: Center(
         child: Text('AlertScreen'),
      ),
    );
  }
}