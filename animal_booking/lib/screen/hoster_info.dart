import 'package:animal_booking/services/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_vertical_calendar/simple_vertical_calendar.dart';

class HosterInfoScreen extends StatelessWidget {
   
  const HosterInfoScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final hosterService= Provider.of<HosterService>(context);
    // print(hosterService.selectedHoster.housePicture[0].picture);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        iconTheme: IconThemeData(color: Colors.black),
        
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.ios_share_outlined)),
          IconButton(onPressed: (){}, icon: Icon(Icons.share)),

        ],
        ),
      body:  SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _PicturesBox(hosterService: hosterService),
            
            Expanded(
              child: ListView.builder(
              itemCount: 7,
              itemBuilder: (_, i) {
                if (i ==0 )
                  return _InfoBox(hosterService: hosterService);
                if (i==1)
                  return _AnfitrionInfo(hosterService: hosterService);
                if (i == 2)
                  return _DescriptionBox(hosterService: hosterService);
                if (i == 3)
                  return _includedBox(color: Colors.green);
                else if (i == 4)
                  return _ReviewsBox(hosterService: hosterService);
                else if (i ==5)
                  return _MapBox(hosterService: hosterService);
                else
                  return Calendar();
              },
            ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: _ReservedButton(hosterService: hosterService))
          ],
        ),
      ),
    );
  }

  Widget _includedBox({Color? color}) => 
      Container(
      constraints: BoxConstraints(
        maxHeight: double.infinity,),
      decoration:const  BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 1,color:Colors.black)),
        color: Colors.white
      ),
        // margin: EdgeInsets.all(),
        // height: 200, 
        width: 200, 
        // color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('¿Qué ofrece este lugar?',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold ,fontSize: 20),),
              _includContainer()
            ],
          ),
        ),
      );
  


}

class _ReservedButton extends StatelessWidget {
  const _ReservedButton({
    Key? key,
    required this.hosterService,
  }) : super(key: key);

  final HosterService hosterService;

  @override
  Widget build(BuildContext context) {
    return Container(     
      decoration:const  BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 0.5,color:Colors.black)),
        color: Colors.white
      ),        
      // color: Colors.amber,
      width: double.infinity,
      height: 70,
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("\$${hosterService.selectedHoster.price}",style: TextStyle(fontSize: 30,color: Colors.black),),
            MaterialButton(
              onPressed: (){
                Navigator.pushNamed(context, "payment");
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.indigo,
              elevation: 0,
              height: 50,
              color: Colors.amber,
              child:Container(
                padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                child:const Text('Reservar',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                )
            )
        ],),
      )
    
            );
  }
}

class _PicturesBox extends StatelessWidget {
  const _PicturesBox({
    Key? key,
    required this.hosterService,
  }) : super(key: key);

  final HosterService hosterService;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: hosterService.selectedHoster.housePicture.length,
        itemBuilder: (BuildContext context, int index) => Card(
              child: Center(child: Container(
                width: width-10,
                height: double.infinity,
                color: Colors.white,
                child: Image(
                  image: NetworkImage("${hosterService.selectedHoster.housePicture[index].picture}"),
                  fit: BoxFit.cover,
                  )
                
              )),
            ),
      ),
    );
  }
}

class Calendar extends StatelessWidget {
  const Calendar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 1,color:Colors.black)),
        color: Colors.grey.shade300
      ),
        // color: Colors.red,
        height: 300,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 15),
        child: SimpleVerticalCalendar(
          numOfMonth: 1,
          headerStyle: const HeaderStyle(
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlgin: TextAlign.left,
            monthFormat: MonthFormats.FULL,
          ),
          calendarOption: CalendarOptions.RANGE_SELECTION,
          dayOfWeekHeaderStyle: DayOfWeekHeaderStyle(),
          dayStyle: DayHeaderStyle(
            textColor: Colors.black,
          ),
          onDateTap: (start, end) {
            print(start);
            print(end);
          },
        ),
      ),
    );
  }
}

class _ReviewsBox extends StatelessWidget {
  final HosterService hosterService;
  const _ReviewsBox({
    Key? key, required this.hosterService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const  BoxDecoration(
        // border: Border.symmetric(horizontal: BorderSide(width: 1,color:Colors.black)),
        color: Colors.white
      ),
      width: double.infinity,
      // color: Colors.red,
      height: 180,
      child: Expanded(
        child: ListView.builder(
          itemCount: hosterService.selectedHoster.reviews.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index){
            return Card(
              color: Colors.amber.shade200,
              child: Container(
                height: 140,
                width: 290,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                    children: [
                      // SizedBox(width: 50,),
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('https://static.wikia.nocookie.net/spiderman/images/8/87/Stan_Lee.png/revision/latest/top-crop/width/360/height/450?cb=20131218184054&path-prefix=es'),
                      ),
                      const SizedBox(width: 20,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(Icons.star_rate_rounded),
                              Icon(Icons.star_rate_rounded),
                              Icon(Icons.star_half_outlined),
                              Icon(Icons.star_outline),
                            ],
                          ),
                          Container(
                            // color: Colors.red,
                            height: 120,
                            width: 123,
                            child: Text('"${hosterService.selectedHoster.reviews[index].comment}"',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 5,
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // color: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DescriptionBox extends StatelessWidget {
  final HosterService hosterService;
  const _DescriptionBox({
    Key? key, required this.hosterService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
      decoration:const  BoxDecoration(
        // border: Border.symmetric(horizontal: BorderSide(width: 1,color:Colors.black)),
        color: Colors.white
      ),
        height: 190,
        width: double.infinity,
        // color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '" ${hosterService.selectedHoster.placeDescription} "',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                overflow: TextOverflow.ellipsis
                ),
              maxLines: 6,
            ),

            TextButton(
              onPressed: (){}, 
              child: Text("Mostrar mas >",style: TextStyle(fontSize: 20,color: Colors.black),)
            )
          ],
        )
      ),
    );
  }
}

class _AnfitrionInfo extends StatelessWidget {
  final HosterService hosterService;
  const _AnfitrionInfo({
    Key? key, required this.hosterService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const  BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 1,color:Colors.black)),
        color: Colors.white
      ),
      height: 120,
      width: double.infinity,
      // color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [


            // house name, anfitrion name and photo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Establecimiento tipo : ${hosterService.selectedHoster.typeOfHouse}",style: TextStyle(color: Colors.black),),
                    SizedBox(height: 8,),
                    Text("Anfitrion: ${hosterService.selectedHoster.name}  ${hosterService.selectedHoster.lastname}",style: TextStyle(color: Colors.black),)
                  ],
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage("${hosterService.selectedHoster.profilePicture}"),
                  )
              ],
            ),

            Text("5 Perros - 2 Cuchas - Separadas - 1 Jardin",style: TextStyle(color: Colors.black),)



          ],
        ),
      ),
    );
  }
}

class _MapBox extends StatelessWidget { 
  final HosterService hosterService;
  const _MapBox({
    Key? key, required this.hosterService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(" Mapa:",style: TextStyle(fontSize: 20,color: Colors.black),),
          SizedBox(height: 14,),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white
                    ),
                    height: 275,
                    width: double.infinity,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(30),
                    //   border: Border.all(
                    //     style: BorderStyle.solid,
                    //   ),
                    // ),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      // markers: Marker(position:  LatLng(39.9042, 116.4074), markerId: null,),
                      initialCameraPosition: CameraPosition(
                        target: 
                        LatLng( double.parse("${hosterService.selectedHoster.lat}"),
                         double.parse("${hosterService.selectedHoster.log}")
                        ) ,
                        zoom: 17),
            )
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final HosterService hosterService;
  const _InfoBox({
    Key? key,required this.hosterService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    constraints: BoxConstraints(
        maxHeight: double.infinity,),
      // height: 210,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child:  Column(
          children: [

            Text(
              '${hosterService.selectedHoster.houseName}',
              style: const TextStyle(fontSize: 27,color: Colors.black),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(Icons.star_outlined,color: Colors.amber,),
                    SizedBox(width: 3,),
                     // puntuation
                    Text("${hosterService.selectedHoster.qualification}",style: TextStyle(color: Colors.black),),
                  ],
                ),

                // cant de evaluaciones por el publico
                TextButton(
                      onPressed: (){},
                      // style: TextStyle(fontSize: 24),
                      child: Text(
                        '${hosterService.selectedHoster.reviews.length} evaluaciones',
                        style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                ),
                // es super Anfitrion
                Row(
                  children:[
                    Icon(Icons.takeout_dining_outlined,color: Colors.amber,),
                    (hosterService.selectedHoster.isBest == true)
                    ? Text('Superanfitrion',style: TextStyle(color: Colors.black),)
                    : Text('Anfitrion Normal',style: TextStyle(color: Colors.black))
                    
                  ],
                ),
              ],
            ),
          
          
          // location 
          TextButton(
                onPressed: (){},
                child: Text(
                  "${hosterService.selectedHoster.street}",
                  style:const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold
                    ),
                  ),
          ),
          ],
        ),
        
        ),
    );
  }
}

class _includContainer extends StatelessWidget {
  const _includContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _listOfIncludes(),
        
        _listOfIncludes()
      ],
    );
  }

  Expanded _listOfIncludes() {
    return Expanded(
        child: Container(
          // color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.shower,color: Colors.black),
                    Text("incluye Ducha",style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.no_food_sharp,color: Colors.black,),
                    Text("incluye Comida",style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.car_rental,color: Colors.black,),
                    Text("incluye Translado",style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.directions_walk_outlined,color: Colors.black,),
                    Text("incluye paseo",style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),

            ],
          )),
      );
  }
}

