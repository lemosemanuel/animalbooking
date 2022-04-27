import 'dart:convert';

import 'package:animal_booking/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;





final TextEditingController _search=TextEditingController();
final TextEditingController _start_date=TextEditingController();
final TextEditingController _end_date=TextEditingController();
String _pet_type='';
var respuesta;


class HosterScreen extends StatefulWidget {
   
  const HosterScreen({Key? key}) : super(key: key);

  @override
  State<HosterScreen> createState() => _HosterScreenState();
}

class _HosterScreenState extends State<HosterScreen> {
  @override
  Widget build(BuildContext context) {
    final hosterService=Provider.of<HosterService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
          toolbarHeight: 140, // Set this height
          flexibleSpace: Container(
            color: Colors.amber,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:30,left: 20,right: 20,bottom: 6),
                  child: AppBar(
                    shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30),
                            ),
                          ),
                    backgroundColor: Colors.white,
                    leading: Icon(Icons.location_on_outlined, color: Colors.amber,),
                    primary: false,
                    title: TextField(
                        controller: _search,
                        decoration: const InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey))
                            ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.amber), onPressed: () async{
                          print(_search);
                          print(_start_date);
                          print(_end_date);
                          print(_pet_type);
                          respuesta=await hosterService.checkAviable(_start_date.text, _end_date.text, _pet_type, _search.text);
                          print(respuesta.keys);
                          print(respuesta['12'][0]['image']);
                          setState(() {
                          });

                        },),
                      IconButton(icon: Icon(Icons.map_outlined, color: Colors.amber),
                        onPressed: () {},)
                    ],
                  ),
                ),

                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:10,left: 20),                        
                            height: 50.0,
                            width: 130,
                            child: TextFormField(
                              style: TextStyle(fontSize:11),
                              controller: _start_date,
                              // initialValue: '10/12/2033',
                              decoration: _TextBoxDecoration('desde', 'desde',Icons.calendar_today,null),
                            ),
                          ),



                    Container(
                      margin: EdgeInsets.only(top:10,left: 5),                        
                            height: 50.0,
                            width: 130,
                            child: TextFormField(
                              style: TextStyle(fontSize:11),
                              controller: _end_date,
                              // initialValue: '16/12/2033',
                              decoration: _TextBoxDecoration('desde', 'Hasta',Icons.calendar_today,null),
                            ),
                          ),

                    Container(
                    height: 50,
                    width: 80,
                      margin: EdgeInsets.only(top:10,left: 5),                        

                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 0, right: -33, bottom: 15, top: 15),
                          // labelText: "vacuna",
                          prefixIcon: Icon(Icons.pets,color: Colors.white,),
                          hintText: '',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder( // <--- this line
                            borderRadius: BorderRadius.circular(10), // <--- this line
                          ),
                        ),
                                  
                        items:const [
                          DropdownMenuItem(
                            value: 'PERRO',
                            child: Text('Perro'),),
                          DropdownMenuItem(
                            value: 'GATO',
                            child: Text('Gato'),),
                          DropdownMenuItem(
                            value: 'TORTUGA',
                            child: Text('Tortuga'),)
                        ], 
                        onChanged: (value)=> _pet_type=value!
                        ),
                  ),
                  ],
                )
              ],
            ),
          ),
        ),
      body: Container(
        color: Colors.white,
        child: _HosterBody()),
    );
  }

  InputDecoration _TextBoxDecoration(String? hinText,String? labelText,IconData? preIcon,IconData? suIcon,) {
    return InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                hintText: hinText,
                labelText: labelText,
                // helperText: "nombre del animal",
                // counterText: '3 caracteres',
                prefixIcon: Icon(preIcon,size: 24,color: Colors.white,),
                suffixIcon: (suIcon!=null)?Icon(suIcon):null,
              );
  }
}

class _HosterBody extends StatelessWidget {
  const _HosterBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hosterService=Provider.of<HosterService>(context);

    return ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (respuesta != null)?respuesta.keys.length:hosterService.hosters.length,
            itemBuilder: (context,index)=>GestureDetector(
              onTap: (){
                hosterService.selectedHoster=hosterService.hosters[index];
                Navigator.pushNamed(context, 'hosterinfo');
              },
              child: _cardBox(i:index)
            )
          );
          
  }
}

class _cardBox extends StatelessWidget {
  final int i;

  const _cardBox({
    Key? key, required this.i
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hosterService=Provider.of<HosterService>(context);
    String? nombre= hosterService.hosters[i].name;
    // String imagen=respuesta['12']['image'];
    String imagen='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';
    (respuesta != null)?imagen=respuesta['12'][0]['image']:imagen=imagen;
    var image2 = base64.decode(imagen);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20,bottom: 10),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
              boxShadow:  [BoxShadow(color: Colors.black12,blurRadius: 10,offset: Offset(0,7))]
              ),
            child: Container(
              decoration: BoxDecoration(
              color: Colors.amber.shade400,

                borderRadius:BorderRadius.circular(10)
                ),
                    
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(               
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)),
                    width: 150,
                    height: 175,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.memory(
                        image2,
                        fit: BoxFit.cover)
                        // FadeInImage(
                        // placeholder: const AssetImage('assets/img/animal.gif'),
                        // // image: NetworkImage('https://previews.123rf.com/images/rh2010/rh20101603/rh2010160300770/54120369-ritratto-di-un-coltello-da-macellaio-partecipazione-bello-in-piedi-sullo-sfondo-carcasse-di-maiale-a.jpg'),
                        // image: NetworkImage("${hosterService.hosters[i].housePicture[0].picture}"),
                        // fit: BoxFit.cover,
                        // ),
                      )
                    ),

                  Container(
                    margin: EdgeInsets.only(top: 14,bottom: 5),
                    // color: Colors.green,
                    width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 130,
                              child: Text("${hosterService.hosters[i].houseName}",overflow: TextOverflow.ellipsis,maxLines: 2,)),
                            const Icon(Icons.share)
                          ],
                        ),
                        
                        Row(
                          children:[
                          const Icon(Icons.star_outline),
                          const SizedBox(width: 10,),
                          Text("${hosterService.hosters[i].qualification}")
                          ],
                        ),

                        Row(
                          children: [
                            (hosterService.hosters[i].isWalking == true)
                            ? Row(children: [const Text("incluye Paseo"),Icon(Icons.directions_walk_outlined)],)
                            :Text('')
                          ],
                        ),

                        Row(
                          children: [
                            (hosterService.hosters[i].isShower == true)
                            ? Row(children: [const Text("incluye Ducha"),Icon(Icons.bathtub_rounded)],)
                            :Text('')
                          ],
                        ),


                        Row(
                          children: [
                            (hosterService.hosters[i].isFood == true)
                            ? Row(children: [const Text("incluye Comida"),Icon(Icons.emoji_food_beverage_outlined)],)
                            :Text('')
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\$${hosterService.hosters[i].price}",style: TextStyle(fontSize: 30),),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: MaterialButton(
                                  onPressed: (){
                                    hosterService.selectedHoster=hosterService.hosters[i];
                                    Navigator.pushNamed(context, 'hosterinfo');
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  disabledColor: Colors.indigo,
                                  elevation: 0,
                                  color: Colors.indigo,
                                  child:Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 3),
                                    child:const Text('Reservar')
                                    )
                                ),
                              )
                            ],
                          ),
                        )


                      ],
                    ),
                  )

                ],
              )),
          ),


          (hosterService.hosters[i].isBest==true)?
          Container(
            child: Positioned(
              top: 10,
              left: 0,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Container(
                  color: Colors.green,
                  width: 70,
                  height: 30,
                  child: Text('Best !!',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ):
          Text("")
        ],
      ),
      );
  }
}





class CustomBarWidget extends StatelessWidget {

      GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          key: _scaffoldKey,
          body: Container(
            height: 160.0,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      "Home",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 80.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5), width: 1.0),
                          color: Colors.white),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              print("your menu action here");
                              // _scaffoldKey.currentState.openDrawer();
                            },
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              print("your menu action here");
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              print("your menu action here");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    }