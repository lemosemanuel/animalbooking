// import 'package:animal_booking/screen/screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

// class RegisterTwoPetScreen extends StatelessWidget {
   
//   const RegisterTwoPetScreen({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(   
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Text("Bien Comencemos..",style: TextStyle(color: Colors.amber,fontSize: 30),),
             
//              SizedBox(height: 20,),
            
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Container(
//                 child: Column(
//                   children: [

//                     TextFormField(
//                       style: TextStyle(color: Colors.black,fontSize: 20),
//                         initialValue: '',                
//                         decoration: _TextBoxDecoration('Nombre', 'Escriba su Nombre', Icons.person, Icons.perm_contact_calendar_outlined),        
//                         onChanged: (value) =>{}
//                       ),
//                     SizedBox(height: 20,),


//                     TextFormField(
//                       style: TextStyle(color: Colors.black,fontSize: 20),
//                         initialValue: '',                
//                         decoration: _TextBoxDecoration('Apellido', 'Escriba su Apellido', Icons.person, Icons.perm_contact_calendar_outlined),        
//                         onChanged: (value) =>{}
//                       ),
//                     SizedBox(height: 20,),
                    

//                     TextFormField(
//                       style: TextStyle(color: Colors.black,fontSize: 20),
//                         initialValue: '',                
//                         decoration: _TextBoxDecoration('DNI', 'Escriba su Documento', Icons.insert_drive_file, Icons.perm_contact_calendar_outlined),        
//                         onChanged: (value) =>{}
//                       ),
//                     SizedBox(height: 50,),
                    
//                     MaterialButton(
//                       onPressed: ()=> Navigator.pushNamed(context, 'register_two_pet_birth'),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       disabledColor: Colors.amber,
//                       elevation: 0,
//                       color: Colors.amber,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
//                         child: Text("Listo !",style: TextStyle(fontSize: 20),),
//                       ),
//                     )
                    
//                   ],
//                 ),
//               ),
//             ),
             
//            ],
//          )
//       ),
//     );
//   }
//   InputDecoration _TextBoxDecoration(String hinText,String labelText,IconData preIcon,IconData? suIcon,) {
//   return InputDecoration(
//               focusedBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     color: Colors.amber,
//                     width: 1.0,
//                   ),
//                 ),
//               enabledBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     color: Colors.amber,
//                     width: 1.0,
//                   ),
//               ),

//               hintText: hinText,
//               hintStyle: TextStyle(color: Colors.amber),
//               labelText: labelText,
//               labelStyle: TextStyle(color: Colors.amber),
//               // helperText: "nombre del animal",
//               // counterText: '3 caracteres',
//               prefixIcon: Icon(preIcon,color: Colors.amber,),
//               suffixIcon: (suIcon!=null)?Icon(suIcon,color: Colors.amber,):null,
//             );
// }
// }


// class RegisterBirth extends StatelessWidget {
//   const RegisterBirth({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//             Container(              
//               child: Text("Indica tu cumple :)",style: TextStyle(color: Colors.amber,fontSize: 30))
//               ),

//             SizedBox(height: 20,),

//             Container(
//               width: 300,
//               height: 200,
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime: DateTime(1969, 1, 1),
//                 onDateTimeChanged: (DateTime newDateTime) {
//                   // print(newDateTime);
//                 },
//               ),
//             ),
//             SizedBox(height: 50,),


//             MaterialButton(
//               onPressed: ()=> Navigator.pushNamed(context, 'register_two_pet_mail'),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               disabledColor: Colors.amber,
//               elevation: 0,
//               color: Colors.amber,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
//                 child: Text("Listo !",style: TextStyle(fontSize: 20),),
//               ),
//                     )
//            ]
//         )
//       )
//     );
//   }
// }
// class RegisterMail extends StatelessWidget {
//   const RegisterMail({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//              backgroundColor: Colors.white,
//         body: Center(
//           child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//             Container(              
//               child: Text("Cual es tu Email?",style: TextStyle(color: Colors.amber,fontSize: 30))
//               ),

//             SizedBox(height: 20,),

//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 children: [
//                   TextFormField(
//                     style: TextStyle(color: Colors.black,fontSize: 20),
//                       initialValue: '',                
//                       decoration: _TextBoxDecoration('Email', 'Escriba su Email', Icons.mail, Icons.alternate_email),        
//                       onChanged: (value) =>{}
//                     ),

//                   SizedBox(height: 20,),

//                   TextFormField(
//                     style: TextStyle(color: Colors.black,fontSize: 20),
//                     initialValue: '',                
//                     decoration: _TextBoxDecoration('Email', 'Repita su Email', Icons.mail, Icons.alternate_email),        
//                     onChanged: (value) =>{}
//                 ),
//                 ],
//               ),
//             ),


 
//             SizedBox(height: 50,),

//             MaterialButton(
//               onPressed: ()=> Navigator.pushNamed(context, 'register_two_pet_pass'),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               disabledColor: Colors.amber,
//               elevation: 0,
//               color: Colors.amber,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
//                 child: Text("Listo !",style: TextStyle(fontSize: 20),),
//               ),
//                     )
//            ]
//         )
//       )
//     );
//   }
//   InputDecoration _TextBoxDecoration(String hinText,String labelText,IconData preIcon,IconData? suIcon,) {
//     return InputDecoration(
//               focusedBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     color: Colors.amber,
//                     width: 1.0,
//                   ),
//                 ),
//               enabledBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     color: Colors.amber,
//                     width: 1.0,
//                   ),
//               ),

//               hintText: hinText,
//               hintStyle: TextStyle(color: Colors.amber),
//               labelText: labelText,
//               labelStyle: TextStyle(color: Colors.amber),
//               // helperText: "nombre del animal",
//               // counterText: '3 caracteres',
//               prefixIcon: Icon(preIcon,color: Colors.amber,),
//               suffixIcon: (suIcon!=null)?Icon(suIcon,color: Colors.amber,):null,
//             );
// }
// }




// class RegisterPass extends StatelessWidget {
//   const RegisterPass({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//              backgroundColor: Colors.white,
//         body: Center(
//           child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//             Container(              
//               child: Text("Escoge una password",style: TextStyle(color: Colors.amber,fontSize: 30))
//               ),

//             SizedBox(height: 20,),

//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 children: [
//                   TextFormField(
//                     style: TextStyle(color: Colors.black,fontSize: 20),
//                       initialValue: '',                
//                       decoration: _TextBoxDecoration('Password', 'Escriba su Password', Icons.lock,Icons.security_outlined),        
//                       onChanged: (value) =>{}
//                     ),

//                   SizedBox(height: 20,),

//                   TextFormField(
//                     style: TextStyle(color: Colors.black,fontSize: 20),
//                     initialValue: '',                
//                     decoration: _TextBoxDecoration('Password', 'Repita su Password', Icons.lock, Icons.security_outlined),        
//                     onChanged: (value) =>{}
//                 ),
//                 ],
//               ),
//             ),


 
//             SizedBox(height: 50,),

//             MaterialButton(
//               onPressed: ()=> Navigator.pushNamed(context, 'register_two_pet_pin'),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               disabledColor: Colors.amber,
//               elevation: 0,
//               color: Colors.amber,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
//                 child: Text("Listo !",style: TextStyle(fontSize: 20),),
//               ),
//                     )
//            ]
//         )
//       )
//     );
//   }
//   InputDecoration _TextBoxDecoration(String hinText,String labelText,IconData preIcon,IconData? suIcon,) {
//     return InputDecoration(
//               focusedBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     color: Colors.amber,
//                     width: 1.0,
//                   ),
//                 ),
//               enabledBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     color: Colors.amber,
//                     width: 1.0,
//                   ),
//               ),

//               hintText: hinText,
//               hintStyle: TextStyle(color: Colors.amber),
//               labelText: labelText,
//               labelStyle: TextStyle(color: Colors.amber),
//               // helperText: "nombre del animal",
//               // counterText: '3 caracteres',
//               prefixIcon: Icon(preIcon,color: Colors.amber,),
//               suffixIcon: (suIcon!=null)?Icon(suIcon,color: Colors.amber,):null,
//             );
// }
// }


// class RegisterPin extends StatelessWidget {
//   const RegisterPin({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//         return Scaffold(
//              backgroundColor: Colors.white,
//         body: Center(
//           child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//             Container(              
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 50),
//                 child: Text("Ya casi terminamos ! :) solo escribe el numero que te acabo de enviar a tu telefono",style: TextStyle(color: Colors.amber,fontSize: 30)),
//               )
//               ),

//             SizedBox(height: 50,),

            

//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                   Container(
//                     height: 100,
//                     width: 50,
//                     child: TextFormField(
//                       maxLength: 1,
//                       style: TextStyle(color: Colors.black,fontSize: 20),
//                       keyboardType: TextInputType.number,
//                       initialValue: '',                
//                       decoration: _TextBoxDecoration(),        
//                       onChanged: (value) =>{}
//                     ),
//                   ),
//                   SizedBox(width: 7,),


//                   Container(
//                     height: 100,
//                     width: 50,
//                     child: TextFormField(
//                       maxLength: 1,
//                       style: TextStyle(color: Colors.black,fontSize: 20),
//                       keyboardType: TextInputType.number,
//                       initialValue: '',                
//                       decoration: _TextBoxDecoration(),        
//                       onChanged: (value) =>{}
//                     ),
//                   ),
//                   SizedBox(width: 7,),

                  
//                   Container(
//                     height: 100,
//                     width: 50,
//                     child: TextFormField(
//                       maxLength: 1,
//                       style: TextStyle(color: Colors.black,fontSize: 20),
//                       keyboardType: TextInputType.number,
//                       initialValue: '',                
//                       decoration: _TextBoxDecoration(),        
//                       onChanged: (value) =>{}
//                     ),
//                   ),
//                   SizedBox(width: 7,),


//                   Container(
//                     height: 100,
//                     width: 50,
//                     child: TextFormField(
//                       maxLength: 1,
//                       style: TextStyle(color: Colors.black,fontSize: 20),
//                       keyboardType: TextInputType.number,
//                       initialValue: '',                
//                       decoration: _TextBoxDecoration(),        
//                       onChanged: (value) =>{}
//                     ),
//                   ),
//               ],
//             ),


 
//             SizedBox(height: 20,),

//             MaterialButton(
//               onPressed: ()=> Navigator.pushNamed(context, 'register_two_pet_successful'),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               disabledColor: Colors.amber,
//               elevation: 0,
//               color: Colors.amber,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
//                 child: Text("Listo !",style: TextStyle(fontSize: 20),),
//               ),
//                     )
//            ]
//         )
//       )
//     );
//   }
//   InputDecoration _TextBoxDecoration() {
//     return const InputDecoration(
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     color: Colors.amber,
//                     width: 1.0,
//                   ),
//                 ),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     color: Colors.amber,
//                     width: 1.0,
//                   ),
                
//               ),
//               contentPadding: EdgeInsets.only(
//                 left: 18,
//                 top: 10,
//                 right: 15,
//                 bottom: 0
//               ),
//             );
//   }
// }

// class SuccessfulRegister extends StatefulWidget {
//   const SuccessfulRegister({Key? key}) : super(key: key);

//   @override
//   State<SuccessfulRegister> createState() => _SuccessfulRegisterState();
// }

// class _SuccessfulRegisterState extends State<SuccessfulRegister> {
//   @override
  
//   Widget build(BuildContext context) {
//     Future.delayed(Duration(seconds: 3), () {
//             Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => HomeScreen()),
//             (Route<dynamic> route) => false,
//           );
//         });
    
//     return Scaffold(
//              backgroundColor: Colors.white,
//         body: Center(
//           child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//             Container(              
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 50),
//                 child: Text("BIEN !! ya eres parte de la comunidad !",style: TextStyle(color: Colors.amber,fontSize: 30)),
//               )
//               ),

//             const SizedBox(height: 50,),

//             const Image(image: AssetImage('assets/img/successful.gif')),


//            ]
//         )
//       )
      
//     );
//   }
// }