import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReservationDetailsScreen extends StatelessWidget {
   
  const ReservationDetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade400,
        actions:const [
          Icon(Icons.question_answer_rounded)
        ],
        title: const Text('Confirmacion de reserva'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Confirmada",style:TextStyle(color: Colors.green),),
              Text("Reserva de alojamiento",style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
              Container(
                child: Text("Listo! Te hemos enviado el e-mail defirmacion a : Lemos.ema@gmail.com" ,style:TextStyle(color: Colors.black),),
              ),
              SizedBox(height: 10,),

              Container(
                width: double.infinity,
                height: 100,

                decoration:  BoxDecoration(
                      border: Border.all(color: Colors.greenAccent),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color:Colors.greenAccent.shade100
                    ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Numero de confirmacion:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          Text("3892387492",style: TextStyle(color: Colors.black),),
                          SizedBox(height: 13,),
                          Container(
                            width: 200,
                            child: Text("Recuerda escanear el QR en el Lugar cuando dejes tu animal",style: TextStyle(color: Colors.red),)),

                        ],
                      ),
                    ),

                    Container(             
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)),
                    width: 80,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                        onTap: ()=> showCupertinoDialog(
                                  context: context, 
                                  builder: (context)=> CupertinoAlertDialog(
                                    title: const Text("QR"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text("muestra este qr"),
                                        SizedBox(height:10),
                                        Image(
                                          image: AssetImage('assets/img/qr.png'),
                                        // placeholder: const AssetImage('assets/img/animal.gif'),
                                        // image: NetworkImage('https://previews.123rf.com/images/rh2010/rh20101603/rh2010160300770/54120369-ritratto-di-un-coltello-da-macellaio-partecipazione-bello-in-piedi-sullo-sfondo-carcasse-di-maiale-a.jpg'),
                                        // image: NetworkImage("${hosterService.hosters[i].housePicture[0].picture}"),
                                        fit: BoxFit.cover,
                                        ),
                                        // FlutterLogo(size: 1000,)
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
                                  )),
                        child: const Image(
                          image: AssetImage('assets/img/qr.png'),
                        // placeholder: const AssetImage('assets/img/animal.gif'),
                        // image: NetworkImage('https://previews.123rf.com/images/rh2010/rh20101603/rh2010160300770/54120369-ritratto-di-un-coltello-da-macellaio-partecipazione-bello-in-piedi-sullo-sfondo-carcasse-di-maiale-a.jpg'),
                        // image: NetworkImage("${hosterService.hosters[i].housePicture[0].picture}"),
                        fit: BoxFit.cover,
                        ),
                      ),)
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20,),

              Text("La casa del Tio Sam en Parque Patricios",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:30)),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.calendar_today_outlined,color: Colors.black,),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),

                      Text('viernes, 16 de mar. 2022 - martes, 18 de mar. 2022',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:13)),
                      Text('Check-in: de 15:00 a 20:00',style: TextStyle(color: Colors.black,)),
                      Text('Check-out: de 07:00 a 11:00',style: TextStyle(color: Colors.black,)),
                      TextButton(
                        onPressed: (){}, 
                        child: Text("Cambiar las fechas",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 18))
                        )
                    ],
                  )
                ],
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.access_time,color: Colors.black,),
                    ],
                  ),

                  Container(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Text('Tu hora de llegada',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:13)),
                        Text('Diles a que hora tienes pensado llegar para que puedan organizar bien el check-in',style: TextStyle(color: Colors.black,)),
                        TextButton(
                          onPressed: (){}, 
                          child: Text("Anadir hora de llegada",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 18))
                          )
                      ],
                    ),
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.location_on_outlined,color: Colors.black,),
                    ],
                  ),

                  Container(
                    width: 300,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Text('Direccion del alojamiento',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:13)),
                        Text('Esteban de luca 1851, 3B, 1246 , Argentina , Capital Federal',style: TextStyle(color: Colors.black,)),
                        TextButton(
                          onPressed: (){}, 
                          child: Text("Como llegar",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 18))
                          )
                      ],
                    ),
                  )
                ],
              ),

              
            ],
          ),
        ),
      )

    );
  }
}