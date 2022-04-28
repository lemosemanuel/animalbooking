// import 'package:animal_booking/services/services.dart';
// import 'package:animal_booking/widgets/custom_bottonNavigationBar_home.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// import 'package:provider/provider.dart';


// class ReservationPetScreen extends StatelessWidget {
   
//   const ReservationPetScreen({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     final hosterService=Provider.of<HosterService>(context);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber.shade400,
//         title: Text('Tus Reservas'),),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height:35),
            
            
      
      
//             Container(
//               width: 275,
//               child: Text("Prepara a Luna para : ",style:TextStyle(fontWeight: FontWeight.bold,color: Colors.amber,fontSize: 25))),
//             SizedBox(height:20),
      
//             Expanded(
//               child: Container(
//                 child: ListView.builder(
      
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemCount:   hosterService.hosters.length,
//                   itemBuilder: (BuildContext context, int index) =>GestureDetector(
//                     onTap: (){
//                       // hosterService.selectedHoster=hosterService.hosters[index];
//                       // Navigator.pushNamed(context, 'hosterinfo');
//                     },
              
//                     child: _cardBox(i:index) ,
//                   )
                    
                  
//                 ),
//                 ),
//             ),
      
//             Text("Tu Historial",style:TextStyle(fontWeight: FontWeight.bold,color: Colors.amber,fontSize: 25)),
//             SizedBox(height:20),
      
//             Expanded(
//               child: Container(
//                 child: ListView.builder(
      
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemCount:   hosterService.hosters.length,
//                   itemBuilder: (BuildContext context, int index) =>GestureDetector(
//                     onTap: (){
//                       // hosterService.selectedHoster=hosterService.hosters[index];
//                       // Navigator.pushNamed(context, 'hosterinfo');
//                     },
              
//                     child: _cardBox(i:index) ,
//                   )
                    
                  
//                 ),
//                 ),
//             ),
            
      
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavigation(),
//     );
//   }
// }

// class _cardBox extends StatelessWidget {
//   final int i;

//   const _cardBox({
//     Key? key, required this.i
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final hosterService=Provider.of<HosterService>(context);
//     String? nombre= hosterService.hosters[i].name;

//     return Column(
//       children: [
//         Text('de 13/03/2021 al 17/03/2021',style: TextStyle(color: Colors.amber),),
//         Container(
//           width: 325,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: Stack(
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 20,bottom: 10),
//                   width: double.infinity,
//                   height: 180,
//                   decoration: BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow:  [BoxShadow(color: Colors.black12,blurRadius: 10,offset: Offset(0,7))]
//                     ),
//                   child: Container(
//                     decoration: BoxDecoration(
//                     color: Colors.amber.shade400,

//                       borderRadius:BorderRadius.circular(10)
//                       ),
                          
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(               
//                           margin: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             // color: Colors.amber,
//                             borderRadius: BorderRadius.circular(10)),
//                           width: 125,
//                           height: 150,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: FadeInImage(
//                             placeholder: const AssetImage('assets/img/animal.gif'),
//                             // image: NetworkImage('https://previews.123rf.com/images/rh2010/rh20101603/rh2010160300770/54120369-ritratto-di-un-coltello-da-macellaio-partecipazione-bello-in-piedi-sullo-sfondo-carcasse-di-maiale-a.jpg'),
//                             image: NetworkImage("${hosterService.hosters[i].housePicture[0].picture}"),
//                             fit: BoxFit.cover,
//                             ),)
//                           ),

//                         Container(
//                           margin: EdgeInsets.symmetric(vertical: 15),
//                           // color: Colors.green,
//                           width: 150,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width: 125,
//                                     child: Text("${hosterService.hosters[i].houseName}")
//                                     ),
//                                   // Text("$nombre"),
//                                   const Icon(Icons.share,)
//                                 ],
//                               ),
                              
//                               Row(
//                                 children:[
//                                 const Icon(Icons.star_outline),
//                                 const SizedBox(width: 10,),
//                                 Text("${hosterService.hosters[i].qualification}")
//                                 ],
//                               ),

//                               Row(
//                                 children: [
//                                   Text("Anfitrion: $nombre")
//                                 ],
//                               ),



//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text("del 13/03/2021 al 17/03/2021",style: TextStyle(fontSize: 10),),
                                
//                                 ],
//                               ),


//                               Text("Confirmada !",style: TextStyle(color:Colors.green),)


//                             ],
//                           ),
//                         )

//                       ],
//                     )),
//                 ),
//               ],
//             ),
//             ),
//         ),
//       ],
//     );
//   }
// }

