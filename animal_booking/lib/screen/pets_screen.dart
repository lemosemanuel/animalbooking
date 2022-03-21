import 'package:animal_booking/screen/screen.dart';
import 'package:animal_booking/services/services.dart';
import 'package:animal_booking/ux_ui/background/background_home.dart';
import 'package:animal_booking/ux_ui/text_style.dart';
import 'package:animal_booking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:animal_booking/models/modes.dart';
import 'package:provider/provider.dart';

class PetsScreen extends StatelessWidget {
   
  const PetsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final petService = Provider.of<PetsService>(context);

    if(petService.isLoading)return LoadingScreen();

    
    return Scaffold(
      body: Stack(
        children: const [
          BackgroundHome(),
          // GradientAppBar(title: 'My Pets'),
        
          _AnimalRegisterBody()
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          petService.selectedPet= new Pet(age: 'age', diseases: '', email: 'email', habitat: 'habitat', location: 'location', name: 'name', origin: 'origin', owner: 'owner', phone: 'phone', race: 'race', reproductiveStatus: 'reproductiveStatus', sex: 'sex', surgeries: false, type: 'type', vaccination:false, weight: 'weight');
          Navigator.pushNamed(context, 'petregister');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _AnimalRegisterBody extends StatelessWidget {
  const _AnimalRegisterBody({Key? key}) : super(key: key);

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
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                (context,index)=> _AnimalSummary(pet: petService.pets[index]),
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



class _AnimalSummary extends StatelessWidget {
  final Pet pet;
  final bool horizontal;

  const _AnimalSummary({Key? key, required this.pet, this.horizontal=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final petService = Provider.of<PetsService>(context);
    final petsThumbnail = Container(
      margin: const EdgeInsets.symmetric(
      vertical: 16.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: Hero(
          tag: "planet-hero-${pet.id}",
          child: Container(
             decoration: BoxDecoration(
                // border: Border.all(color:Colors.grey.shade400) ,
                // borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                
                ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              
              child: FadeInImage(
                placeholder: AssetImage('assets/img/animal.gif'),
                image: 

                NetworkImage(pet.picture!)
                ,
                height: 92.0,
                width: 110.0,
                fit: BoxFit.cover,
                    ),
            ),
          ),
      ),
    );

    Widget _petValue({required String value, required String image}) {
      return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(image, height: 17.0,color: Colors.lightGreen,),
            Container(width: 2.0),
            Text(pet.weight,style: Style.smallTextStyle,overflow: TextOverflow.ellipsis),
          ]
        ),
      );
    }
    
    final petCardContent = Container(
      margin: EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: const BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: 4.0),
          Text(pet.name,style: Style.titleTextStyle,),
          Container(height: 10.0),
          Text(pet.description!,style: Style.commonTextStyle,overflow: TextOverflow.ellipsis,maxLines: 1,),
          Separator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: horizontal ? 1 : 0,
                child: _petValue(
                  value: pet.distance!,
                  image: 'assets/ic_distance.png')

              ),
              Container(
                width: horizontal ? 8.0 : 32.0,
              ),
              Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _petValue(
                  value: pet.weight,
                  image: 'assets/ic_gravity.png')
              )
            ],
          ),
        ],
      ),
    );

    final petCard = Container(
      child: petCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
        ? const EdgeInsets.only(left: 46.0)
        : const EdgeInsets.only(top: 72.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(62, 66, 107, 0.7),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
    );



    return GestureDetector(
      onTap: horizontal ? (){
        petService.selectedPet=pet;
        Navigator.pushNamed(context, 'petregister');
        
      }:null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
        child: Stack(
          children: [
            petCard,
            petsThumbnail,
            
          ],
        ),
      ),

    );
  }
}