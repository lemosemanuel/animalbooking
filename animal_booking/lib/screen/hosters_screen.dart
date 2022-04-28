import 'dart:convert';

import 'package:animal_booking/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;





final TextEditingController _search=TextEditingController();
final TextEditingController _start_date= TextEditingController();
final TextEditingController _end_date=TextEditingController();
String _pet_type="";
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

    return FutureBuilder(
      future: (_start_date.text!="")?hosterService.checkAviable(_start_date.text, _end_date.text, _pet_type, _search.text):respuesta=hosterService.checkAviable("2022-3-28", "2022-3-29", "PERRO", "Buenos Aires"),
      builder: (context,snapshot){
        respuesta=snapshot.data;
        if (snapshot.hasData){
          return ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: respuesta.keys.length,
                  itemBuilder: (context,index)=>GestureDetector(
                    onTap: (){
                      hosterService.selectedHoster=hosterService.hosters[index];
                      Navigator.pushNamed(context, 'hosterinfo');
                    },
                    child: _cardBox(i:index)
                  )
              );
        }
        return Center(child: CircularProgressIndicator());
        }
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
    String nombre= respuesta[respuesta.keys.toList()[i]]['name'];
    String imagen=respuesta[respuesta.keys.toList()[i]]['image'];
    double? price=respuesta[respuesta.keys.toList()[i]]['price'];
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
                              child: Text("${nombre}",overflow: TextOverflow.ellipsis,maxLines: 2,)),
                            const Icon(Icons.share)
                          ],
                        ),
                        
                        Row(
                          children:[
                          const Icon(Icons.star_outline),
                          const SizedBox(width: 10,),
                          Text("${respuesta[respuesta.keys.toList()[i]]['calification']}")
                          ],
                        ),

                        Row(
                          children: [
                            (respuesta[respuesta.keys.toList()[i]]['services'].contains("PASEO"))
                            ? Row(children: [const Text("incluye Paseo"),Icon(Icons.directions_walk_outlined)],)
                            :Text('')
                          ],
                        ),

                        Row(
                          children: [
                            (respuesta[respuesta.keys.toList()[i]]['services'].contains("DUCHA"))
                            ? Row(children: [const Text("incluye Ducha"),Icon(Icons.bathtub_rounded)],)
                            :Text('')
                          ],
                        ),


                        Row(
                          children: [
                            (respuesta[respuesta.keys.toList()[i]]['services'].contains("COMIDA"))
                            ? Row(children: [const Text("incluye Comida"),Icon(Icons.emoji_food_beverage_outlined)],)
                            :Text('')
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\$${price}",style: TextStyle(fontSize: 30),),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: MaterialButton(
                                  onPressed: (){
                                    hosterService.id_hoster=respuesta[respuesta.keys.toList()[i]]['house_id'];
                                    // Navigator.pushNamed(context, 'hosterinfo');
                                    print(hosterService.id_hoster);
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