import 'package:animal_booking/screen/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animal_booking/widgets/widgets.dart';
import 'dart:io';
import 'package:animal_booking/services/services.dart';
import 'package:collection/collection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


final TextEditingController _secondName = TextEditingController();
final TextEditingController _firstLastname = TextEditingController();
final TextEditingController _secondLastname = TextEditingController();
final TextEditingController _firstName = TextEditingController();

class RegisterIdentity extends StatelessWidget {
   
  const RegisterIdentity({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     body: Center(
       child: SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
              Text("Bien Comencemos..",style: TextStyle(color: Colors.amber,fontSize: 30),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        _BoxText(textController: _firstName, hinText: 'Primer Nombre', labelText: 'Primer Nombre', leftIcon: Icons.person,rightIcon: Icons.perm_contact_calendar_outlined,),
                        SizedBox(height: 15,),
                        _BoxText(textController: _secondName, hinText: 'Segundo Nombre', labelText: 'Segundo Nombre',leftIcon: Icons.person,rightIcon: Icons.perm_contact_calendar_outlined,),
                        SizedBox(height: 15,),
                        _BoxText(textController: _firstLastname, hinText: 'Primer Apellido', labelText: 'Primer Apellido',leftIcon: Icons.person,rightIcon: Icons.perm_contact_calendar_outlined,),
                        SizedBox(height: 15,),
                        _BoxText(textController: _secondLastname, hinText: 'Segundo Apellido', labelText: 'Segundo Apellido',leftIcon: Icons.person,rightIcon: Icons.perm_contact_calendar_outlined,),
                        SizedBox(height: 15,),

                        // lali(firstName: [_firstName,_secondName,_firstLastname,_secondLastname]),
                  
                        _RegisterButton(page: 'register email', listOfPossibleEmpty:[_firstName,_secondName,_firstLastname,_secondLastname])
                      ],
                    ),
                  )
                )
              )
           ],
         ),
       ),
     ),
    );
  }
}


class _RegisterButton extends StatelessWidget {
  List <TextEditingController> listOfText;
  String page;
  _RegisterButton({
    Key? key,
    required List <TextEditingController> listOfPossibleEmpty,
    required this.page,
  }) : listOfText= listOfPossibleEmpty, super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){
        print(listOfText);
        var listText=(listOfText.map((e) => e.text));
        print(listText);
        
        var listIsEmpty=(listText.contains(''));
        if (listIsEmpty){
          if (Platform.isAndroid){
              showDialog(
                context: context, 
                builder: (context){
                  return AndroidDialog(title: 'Ups !',description: "parece que hay un campo sin rellenar",);
                }
              );
            }else{
              showCupertinoDialog(
                    context: context, 
                    builder: (context)=>IosDialog(title: 'Ups !',description: "parece que hay un campo sin rellenar",)
              );
            }
        }else{
          Navigator.pushNamed(context, page);
        }
        // print(_firstName.text);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.amber,
      elevation: 0,
      color: Colors.amber,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
        child: const Text("Listo !",style: TextStyle(fontSize: 20),),
      ),                    
    );
  }
}

class _BoxText extends StatelessWidget {
  TextEditingController textController;
  String hinText;
  String labelText;
  IconData rightIcon;
  IconData leftIcon;

   _BoxText({
    Key? key,
    required this.hinText,
    required this.labelText,
    required this.rightIcon,
    required this.leftIcon,
    required this.textController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: (hinText == 'Password')?true:false,
      style: TextStyle(color: Colors.black,fontSize: 20),
        // initialValue: '',

        controller: textController,                
        decoration: _TextBoxDecoration(hinText, labelText, leftIcon, rightIcon),        
        onChanged: (value) =>{
          // primerNombre=value
        },
        validator: (value){
          return (value != null && value.length >=1)
          ? null 
          : "debe rellenar este campo";
        },
      );
  }
}



InputDecoration _TextBoxDecoration(String hinText,String labelText,IconData preIcon,IconData? suIcon,) {
  return InputDecoration(
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.amber,
                    width: 1.0,
                  ),
                ),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.amber,
                    width: 1.0,
                  ),
              ),

              hintText: hinText,
              hintStyle: TextStyle(color: Colors.amber),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.amber),
              // helperText: "nombre del animal",
              // counterText: '3 caracteres',
              prefixIcon: Icon(preIcon,color: Colors.amber,),
              suffixIcon: (suIcon!=null)?Icon(suIcon,color: Colors.amber,):null,
            );
}






final TextEditingController _email = TextEditingController();
final TextEditingController _repetEmail = TextEditingController();
final TextEditingController _password = TextEditingController();
final TextEditingController _repetPassword = TextEditingController();

class RegisterMail extends StatelessWidget {
  const RegisterMail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
            Text("Datos para tu Cuenta ..",style: TextStyle(color: Colors.amber,fontSize: 30),),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                child: Column(
                  children: [
                    _BoxText(hinText: "Email", labelText:"Email", rightIcon: Icons.alternate_email_sharp, leftIcon: Icons.email, textController: _email),
                    SizedBox(height: 15,),
                    _BoxText(hinText: "Repeat Email", labelText:"Repeat Email", rightIcon: Icons.alternate_email_sharp, leftIcon: Icons.email, textController: _repetEmail),
                    SizedBox(height: 15,),
                    _BoxText(hinText: "Password", labelText: 'Password', rightIcon: Icons.password, leftIcon: Icons.lock, textController: _password),
                    SizedBox(height: 15,),
                    _BoxText(hinText: "Password", labelText: 'Repeat Password', rightIcon: Icons.password ,leftIcon: Icons.lock, textController: _repetPassword),

                    SizedBox(height: 15,),

                    MaterialButton(
                      onPressed: ()async{
                        final authService=Provider.of<AuthService>(context,listen: false);
                        final resp= await authService.checkEmail(_email.text);
                        List listText=[_email.text,_repetEmail.text,_password.text,_repetPassword.text];
                        var listIsEmpty=(listText.contains(''));
                        if (listIsEmpty){
                        if (Platform.isAndroid){
                            showDialog(
                              context: context, 
                              builder: (context){
                                return AndroidDialog(title: 'Ups !',description: "parece que hay un campo sin rellenar",);
                              }
                            );
                          }else{
                            showCupertinoDialog(
                                  context: context, 
                                  builder: (context)=>IosDialog(title: 'Ups !',description: "parece que hay un campo sin rellenar",)
                            );
                          }
                        }else{
                            if (resp){
                              Navigator.pushNamed(context, "register id");
                            }else{
                              if (Platform.isAndroid){
                                showDialog(
                                  context: context, 
                                  builder: (context){
                                    return AndroidDialog(title: 'Ups !',description: "parece que el usuario ya existe",);
                                  }
                                );
                              }else{
                                showCupertinoDialog(
                                      context: context, 
                                      builder: (context)=>IosDialog(title: 'Ups !',description: "parece que el usuario ya existe",)
                                );
                              }
                            }
                          }
                        },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.amber,
                      elevation: 0,
                      color: Colors.amber,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                        child: Text("Listo !",style: TextStyle(fontSize: 20),),
                      ),                    
                    )                                      
                  ],
                )
              )
            )
         ],
       ),
     ),
    );
  }
}



final TextEditingController _idAvatar = TextEditingController();
final TextEditingController _typeId = TextEditingController(text: '');

class RegisterID extends StatefulWidget {
  
  const RegisterID({Key? key}) : super(key: key);

  @override
  State<RegisterID> createState() => _RegisterIDState();
}

class _RegisterIDState extends State<RegisterID> {
  @override
  Widget build(BuildContext context) {
    final listDropDownProvider= Provider.of<ListDropDown>(context,listen:false);

    return Scaffold(
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
            const Text("Bien Comencemos..",style: TextStyle(color: Colors.amber,fontSize: 30),),
            const SizedBox(height: 30,),
            Container(
              height: 50,
              width: 250,
              child:FutureBuilder(
                  future: listDropDownProvider.getDropDown("identification_type"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var yourResponseDataFromAsync = snapshot.data! as List;
                      // print(yourResponseDataFromAsync);
                      return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 40, right: -33, bottom: 15, top: 15),
                                  prefixIcon: const Icon(Icons.credit_card_outlined,),
                                  hintText: 'Tipo de Doc',
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: [
                                  
                                  for(var item in yourResponseDataFromAsync ) DropdownMenuItem(value: item,child: Text('$item'),),
                                ], 
                                onChanged: (value){
                                  if (value==Null){
                                    _typeId..text='';
                                  }else{
                                    _typeId..text=value.toString();
                                  }
                                  setState(() {
                                    
                                  });
                                }
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:65.0),
              child: TextFormField(
                style: TextStyle(color: Colors.black,fontSize: 20),
                  controller: _idAvatar,    
                  decoration: _TextBoxDecoration('Number', 'Number', Icons.credit_card_sharp, Icons.person),        
                  onChanged: (value) =>{
                  }
                ),
            ),
            SizedBox(height: 15,),
            
            _RegisterButton(page: "register birth", listOfPossibleEmpty: [_typeId,_idAvatar],),
        ]
       )
     )
    );
  }
}







TextEditingController _birthAvatar = TextEditingController();
void loadSubmitScreenPrefs(texto) async {
    _birthAvatar = await TextEditingController(text: texto);
  }

class RegisterBirth extends StatefulWidget {
  const RegisterBirth({Key? key}) : super(key: key);

  @override
  State<RegisterBirth> createState() => _RegisterBirthState();
}

class _RegisterBirthState extends State<RegisterBirth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Container(              
              child: Text("Indica tu cumple :)",style: TextStyle(color: Colors.amber,fontSize: 30))
              ),

            SizedBox(height: 20,),

            Container(
              width: 300,
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(1969, 1, 1),
                onDateTimeChanged: (DateTime newDateTime)async {
                  loadSubmitScreenPrefs(newDateTime.toString());
                  setState(() {
                    
                  });
                 
                  // _birthAvatar..text =  TextEditingController(text: newDateTime.toString());
                  print(_birthAvatar);
                  // _birthAvatar = newDateTime as TextEditingController ;
                },
              ),
            ),
            SizedBox(height: 50,),

            _RegisterButton(page: "register phone", listOfPossibleEmpty: [_birthAvatar],),
           ]
        )
      )
    );
  }
}



final TextEditingController _mobileNumber= TextEditingController();
final TextEditingController _phoneNumber= TextEditingController();

class RegisterPhone extends StatelessWidget {
  const RegisterPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tus telefono por favor :) ..",style: TextStyle(color: Colors.amber,fontSize: 30),),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                child: Column(
                  children: [
                    _BoxText(hinText: "House Phone", labelText: "House Pone", rightIcon: Icons.format_list_numbered_rounded, leftIcon: Icons.phone, textController: _phoneNumber),
                     SizedBox(height: 20,),
                    _BoxText(hinText: "Mobile Phone", labelText: "Mobile Pone", rightIcon: Icons.format_list_numbered_rounded, leftIcon: Icons.phone_android,textController: _mobileNumber),
                     SizedBox(height: 50,),
                     _RegisterButton(page: "register country", listOfPossibleEmpty: [_mobileNumber,_phoneNumber],),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}





final TextEditingController _cp= TextEditingController();
final TextEditingController _street= TextEditingController();

String country="Argentina";
String city='Buenos Aires';
var _district;

class RegisterCountry extends StatefulWidget {
  const RegisterCountry({Key? key}) : super(key: key);

  @override
  State<RegisterCountry> createState() => _RegisterCountryState();
}

class _RegisterCountryState extends State<RegisterCountry> {
  @override
  Widget build(BuildContext context) {    
    final listDropDownProvider= Provider.of<ListDropDown> (context,listen:false);
    final sendPinToEmail= Provider.of<SendEmailPin>(context,listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Donde vives?..",style: TextStyle(color: Colors.amber,fontSize: 30),),
            const SizedBox(height: 30,),
            ListDropDownCountries(listDropDownProvider,'Country'),
            SizedBox(height: 10,),
            ListDropDownCityAndDist(listDropDownProvider,'City','country',country),
            SizedBox(height: 10,),
            ListDropDownCityAndDist(listDropDownProvider,'District','city',city),
            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal:68.0),
              child: _BoxText(hinText: "CP", labelText: "CP", rightIcon: Icons.mail, leftIcon: Icons.mail, textController: _cp),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: _BoxText(hinText: "Street", labelText: "Street", rightIcon: Icons.house,leftIcon: Icons.settings_ethernet_sharp, textController: _street),
            ),

            SizedBox(height: 50,),
            
            MaterialButton(
              onPressed: ()async{
                print(country);
                print(city);
                print(_district);
                print(_cp);
                print(_street);
                _emailPin= await sendPinToEmail.sendPin("lemos.ema@gmail.com") as List;
                print(_emailPin);
                Navigator.pushNamed(context, 'register secretcode');

              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.amber,
              elevation: 0,
              color: Colors.amber,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                child: Text("Listo !",style: TextStyle(fontSize: 20),),
              ),                    
            )
          ],
        ),
      ),
    );
  }

  Container ListDropDownCityAndDist(ListDropDown listDropDownProvider,String textBox,String typeOfPlace,var place) {
    return Container(
              height: 50,
              width: 250,
              child:FutureBuilder(
                  future: listDropDownProvider.getCountriesData(typeOfPlace, place),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var yourResponseDataFromAsync = snapshot.data! as List;
                      // print(yourResponseDataFromAsync);
                      return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 40, right: -33, bottom: 15, top: 15),
                                  prefixIcon: const Icon(Icons.credit_card_outlined,),
                                  hintText: textBox,
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: [
                                  
                                  for(var item in yourResponseDataFromAsync ) DropdownMenuItem(value: item,child: Text('$item'),),
                                ], 
                                onChanged: (value){
                                  if (typeOfPlace == 'country'){
                                    city=value!;
                                    setState(() {
                                      
                                    });

                                  }else{
                                    _district=value;
                                    setState(() {
                                      
                                    });
                                  }
                                }
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
            );
  }

  Container ListDropDownCountries(ListDropDown listDropDownProvider, String textOfBox) {
    return Container(
    height: 50,
    width: 250,
    child:FutureBuilder(
        future: listDropDownProvider.getDropDown("countries"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var yourResponseDataFromAsync = snapshot.data! as List;
            // print(yourResponseDataFromAsync);
            return DropdownButtonFormField<String>(
                decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 40, right: -33, bottom: 15, top: 15),
                        prefixIcon: const Icon(Icons.credit_card_outlined,),
                        hintText: textOfBox,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: [
                        
                        for(var item in yourResponseDataFromAsync ) DropdownMenuItem(value: item,child: Text('$item'),),
                      ], 
                      onChanged: (value){
                        country=value!;
                        setState(() {
                          
                        });
                        print(value);

                        // _country=value;
                      }
            );
          }
          return CircularProgressIndicator();
        },
      ),
  );
  }
}





List _emailPin=[];
final TextEditingController _number1= TextEditingController();
final TextEditingController _number2= TextEditingController();
final TextEditingController _number3= TextEditingController();
final TextEditingController _number4= TextEditingController();
final TextEditingController _number5= TextEditingController();

class RegisterPin extends StatelessWidget {
  const RegisterPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _registerProvider=Provider.of<AuthService>(context,listen: false);

    List _numberList=[];
    String userToken;


        return Scaffold(
             backgroundColor: Colors.white,
        body: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Container(              
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text("Ya casi terminamos ! :) solo escribe el numero que te acabo de enviar a tu telefono",style: TextStyle(color: Colors.amber,fontSize: 30)),
              )
              ),

            const SizedBox(height: 50,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  boxPin(_number1),
                  SizedBox(width: 7,),
                  boxPin(_number2),
                  SizedBox(width: 7,),
                  boxPin(_number3),
                  SizedBox(width: 7,),
                  boxPin(_number4),
                  SizedBox(width: 7,),
                  boxPin(_number5),
              ],
            ),
 
            SizedBox(height: 20,),

            MaterialButton(
              onPressed: ()async{
                // List _nuevaLista=['3','4','5','5'];
                _numberList.addAll([int.parse(_number1.text),int.parse(_number2.text),int.parse(_number3.text),int.parse(_number4.text),int.parse(_number5.text)]);
                if( ListEquality().equals(_numberList, _emailPin)){
                  print('son iguales');
                  Navigator.pushNamed(context, "home");

                  final storage = new FlutterSecureStorage();

                  FutureBuilder(
                    future: _registerProvider.register(
                                _firstName.text,
                                _secondName.text,
                                _firstLastname.text,
                                _secondLastname.text,
                                _typeId.text,
                                _idAvatar.text,
                                _birthAvatar.text,
                                "+54",
                                _phoneNumber.text,
                                _mobileNumber.text,
                                country,
                                // String countries_id,
                                city,
                                // String city_id,
                                _district,
                                // String district_id,
                                _cp.text,
                                // String cp_id,
                                _street.text,
                                // String street,
                                "1841",
                                // String num_street,
                                _email.text,
                                _password.text
                            ),
                    builder: (context, snapshot) {
                      var userToken=snapshot.data! as String;
                      print("el token es el siguiente :---- ${userToken}");
                      storage.write(key: 'jwt', value: userToken );
                      return Container();

                    });

                  // print(storage.read(key: 'jwt'));


                  Navigator.pushNamed(context, 'register_successful');
                }else{
                  _numberList=[];
                  if (Platform.isAndroid){
                            showDialog(
                              context: context, 
                              builder: (context){
                                return AndroidDialog(title: 'Ups !',description: "parece que el codigo esta mal",);
                              }
                            );
                          }else{
                            showCupertinoDialog(
                                  context: context, 
                                  builder: (context){
                                    return IosDialog(title: 'Ups !',description: "parece que el codigo esta mal",);
                                }
                            );
                  }
                }           // print(_numberList);
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.amber,
              elevation: 0,
              color: Colors.amber,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                child: Text("Listo !",style: TextStyle(fontSize: 20),),
              ),
            )      
           
           ]
        )
      )
    );
  }

  Container boxPin(_number) {
    return Container(
                  height: 100,
                  width: 50,
                  child: TextFormField(
                    controller: _number,
                    maxLength: 1,
                    style: TextStyle(color: Colors.black,fontSize: 20),
                    keyboardType: TextInputType.number,
                    // initialValue: '',                
                    decoration: _TextBoxDecoration(),        
                    onChanged: (value) =>{}
                  ),
                );
  }
  InputDecoration _TextBoxDecoration() {
    return const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.amber,
                    width: 1.0,
                  ),
                ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.amber,
                    width: 1.0,
                  ),
                
              ),
              contentPadding: EdgeInsets.only(
                left: 18,
                top: 10,
                right: 15,
                bottom: 0
              ),
            );
  }
}



class SuccessfulRegister extends StatefulWidget {
  const SuccessfulRegister({Key? key}) : super(key: key);

  @override
  State<SuccessfulRegister> createState() => _SuccessfulRegisterState();
}

class _SuccessfulRegisterState extends State<SuccessfulRegister> {
  @override
  
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
            Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false,
          );
        });
    
    return Scaffold(
             backgroundColor: Colors.white,
        body: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Container(              
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text("BIEN !! ya eres parte de la comunidad !",style: TextStyle(color: Colors.amber,fontSize: 30)),
              )
              ),

            const SizedBox(height: 50,),

            const Image(image: AssetImage('assets/img/successful.gif')),


           ]
        )
      )
      
    );
  }
}