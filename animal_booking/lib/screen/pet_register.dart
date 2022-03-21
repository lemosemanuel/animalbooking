import 'package:animal_booking/providers/providers.dart';
import 'package:animal_booking/services/services.dart';
import 'package:animal_booking/ux_ui/input_decorations/input_decorations.dart';
import 'package:animal_booking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class PetRegisterScreen extends StatelessWidget {
   
  const PetRegisterScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final petService=Provider.of<PetsService>(context);
    return ChangeNotifierProvider(
      create: (_)=>PetFormProvider(petService.selectedPet),
      child:_petRegisterBody(petService: petService),
      );
  }
}

class _petRegisterBody extends StatelessWidget {
  final PetsService petService;
  const _petRegisterBody({
    Key? key, required this.petService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final petform=Provider.of<PetFormProvider>(context);
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                PetImage(url: petService.selectedPet.picture,),
                
                // arrow to go back
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed:()=>Navigator.of(context).pop(),
                    icon:const Icon(Icons.arrow_back_ios_new,size: 40,color: Colors.white,)
                    )
                ),

                // camera
                Positioned(
                  top: 60,
                  right: 30,
                  child: IconButton(
                    onPressed: ()async{
                      final picker= new ImagePicker();
                      final pickedFile=await picker.getImage(
                        source: ImageSource.camera,
                        imageQuality: 100);

                      if (pickedFile == null){
                        // dont selected nothing
                        return;
                      }
                      print('tenesmos imagen ${pickedFile.path}');
                      petService.updateSelectedPetImage(pickedFile.path);

                    }, 
                    icon:const Icon(Icons.camera_alt_outlined,size: 40,color: Colors.white,)
                    )
                ),


              ],
            ),
           _PetForm(petService:petService),
          const SizedBox(height: 100,)


          ],
        ),
      ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: petService.isSaving
        ? const CircularProgressIndicator(color: Colors.white,)
        : const Icon(Icons.save_outlined),
        onPressed: petService.isSaving
        ? null
        : () async {
          // if (!petform.isValidForm())return;
          final String? imageUrl= await petService.uploadImage();

          if (imageUrl != null)petform.pet.picture=imageUrl;
          petService.saveOrCreatePet(petform.pet);
        },
        ),
    );
  }
}

class _PetForm extends StatelessWidget {
  final PetsService petService;
  const _PetForm({Key? key, required this.petService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        // height: 300,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 30,),



              TextFormField(                
                initialValue: petService.selectedPet.name,                
                decoration: _TextBoxDecoration('Nombre', 'Escriba el Nombre', Icons.pets, Icons.perm_contact_calendar_outlined),        
                onChanged: (value) =>petService.selectedPet.name= value
              ),


              const SizedBox(height: 30,),
              




               Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                        //  color: Colors.amber,
                         height: 50.0,
                         width: 150,
                         child: TextFormField(
                           initialValue: '14',
                              decoration: _TextBoxDecoration('edad', 'edad', Icons.cake_rounded,null),
                         ),
                          ),

                          Container(
                            // color: Colors.amber,
                            height: 50.0,
                            width: 150.0,
                            child: TextFormField(
                              initialValue: '32kg',
                              decoration: _TextBoxDecoration('peso', 'peso', Icons.monitor_weight_outlined,null),
                            ),
                          ),
                ],
              ),
              
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  Container(
                    height: 50,
                    width: 150,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 40, right: -33, bottom: 15, top: 15),
                          // labelText: "vacuna",
                          prefixIcon: Icon(Icons.medical_services_outlined,),
                          hintText: 'Habitad',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder( // <--- this line
                            borderRadius: BorderRadius.circular(10), // <--- this line
                          ),
                        ),
                                  
                        items:const [
                          DropdownMenuItem(
                            value: 'Admin',
                            child: Text('Calle'),),
                          DropdownMenuItem(
                            value: 'empleado',
                            child: Text('Depto'),)
                        ], 
                        onChanged: (value){
                        }
                        ),
                  ),

                  Container(
                    height: 50,
                    width: 150,
                    child: SwitchListTile.adaptive(
                      title: const Text('Vacunado',style: TextStyle(color: Colors.white),),
                      value: true, 
                      onChanged: (value)=>petService.selectedPet.surgeries= value
                    ),
                  ),
                ]
              ),
              

              const SizedBox(height: 20,),

              TextFormField(                
                initialValue: 'Pasteur y Lijo Lopez',                
                decoration: _TextBoxDecoration('Lugar de Recidencia', 'Lugar de Recidencia', Icons.place_outlined, Icons.plagiarism_rounded),        
                onChanged: (value) =>petService.selectedPet.location= value,
              ),



              const SizedBox(height: 20,),


            
            ],
          ) ,
        ),
      ),
    );
  }

  InputDecoration _TextBoxDecoration(String hinText,String labelText,IconData preIcon,IconData? suIcon,) {
    return InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                hintText: hinText,
                labelText: labelText,
                // helperText: "nombre del animal",
                // counterText: '3 caracteres',
                prefixIcon: Icon(preIcon),
                suffixIcon: (suIcon!=null)?Icon(suIcon):null,
              );
  }
  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Color.fromRGBO(16, 117, 152, 0.5),
    borderRadius:const  BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
      color: Colors.black.withOpacity(0.05),
      offset: const Offset(0,5),
      blurRadius: 5
    )]
  );
}