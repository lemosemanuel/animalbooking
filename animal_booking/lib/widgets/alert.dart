import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AndroidDialog extends StatelessWidget {
  String title;
  String description;
  AndroidDialog({Key? key,required this.title,required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
          title:  Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(description),
              const SizedBox(height:10),
            ],
          ),
          actions: [
            TextButton(
              onPressed: ()=> Navigator.pop(context), 
              child: const Text("Cancelar")
              ),
            TextButton(
              onPressed: ()=> Navigator.pop(context), 
              child: const Text("Aceptar")
              )
          ],
        );
      }
}

class IosDialog extends StatelessWidget {
  String title;
  String description;
  IosDialog({Key? key,required this.title,required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title:  Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(description),
            SizedBox(height:10)
            ],
        ),
        actions: [
            TextButton(
              onPressed: ()=> Navigator.pop(context), 
              child: const Text("Cancelar",style: TextStyle(color: Colors.red),)
              ),
            TextButton(
              onPressed: ()=> Navigator.pop(context), 
              child: const Text("Aceptar")
              )
          ],
    );
  }
}