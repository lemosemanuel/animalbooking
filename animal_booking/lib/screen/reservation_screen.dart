import 'package:animal_booking/models/modes.dart';
import 'package:animal_booking/services/services.dart';
import 'package:animal_booking/widgets/custom_bottonNavigationBar_home.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

class ReservationScreen extends StatelessWidget {
   
  const ReservationScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
          toolbarHeight: 80, // Set this height
          flexibleSpace: const _CustomAppbar(),
        ),
      body: SafeArea(
        child: Column(
           children: const [      
             _ReservationBody()
           ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

class _CustomAppbar extends StatelessWidget {
  const _CustomAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top:35,left: 20,right: 20),
            child: AppBar(
              shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
              backgroundColor: Colors.white,
              leading: Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor,),
              primary: false,
              title: const TextField(
                  decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey))),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search, color: Theme.of(context).primaryColor), onPressed: () {},),
                IconButton(icon: Icon(Icons.map_outlined, color: Theme.of(context).primaryColor),
                  onPressed: () {},)
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class _ReservationBody extends StatelessWidget {
  const _ReservationBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final petService = Provider.of<PetsService>(context);

    return Expanded(
      child: Container(
        // color: const Color(0xFF76AB7),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 53),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
                delegate: SliverChildBuilderDelegate(
                (context,index)=> _SingleCard(pet: petService.pets[index]),
                childCount:petService.pets.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SingleCard extends StatelessWidget {
  final Pet pet;


  const _SingleCard({Key? key,required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'reservation_pet'),
      child: Container(
        decoration: BoxDecoration(
                border: Border.all(color:Colors.grey.shade400) ,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                
                ),
        margin: const EdgeInsets.all(15),
        child:ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
            child: Container(
              height: 180,
              child: Stack(
                children: [
                  ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: FadeInImage(
                            placeholder: AssetImage('assets/img/animal.gif'),
                            image: NetworkImage(pet.picture!),
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                                ),
                        ),
                  Center(child: Text(pet.name,style: TextStyle(color: Colors.amber,fontSize: 30,fontWeight: FontWeight.bold),)),
                  
                ],
              ),
              ),
            ),
        )
      ),
    );
  }
}