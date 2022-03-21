import 'package:flutter/material.dart';

class RegisterOneScreen extends StatelessWidget {
   
  const RegisterOneScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(   
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text("Quiero..",style: TextStyle(color: Colors.amber,fontSize: 30),),
             SizedBox(height: 20,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: const [
                 _CardBox(text:"Ser Anfitrion",page:"register_two_anfitrion"),
                 _CardBox(text:"Buscar un lugar para mi Mascota",page: "register_two_pet",)
         
         
               ],
             ),
           ],
         )
      ),
    );
  }
}

class _CardBox extends StatelessWidget {
  final String text;
  final String page;

  const _CardBox({
    Key? key, required this.text, required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, page),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
        color: Colors.amber,
        elevation: 5,
        child: Container(
          height: 150,
          width: 150,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(19.0),
              child: Text(text,style: TextStyle(fontSize: 14),),
            )
            )
          ),
      ),
    );
  }
}