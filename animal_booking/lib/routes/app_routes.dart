import 'package:animal_booking/screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:animal_booking/models/modes.dart';


class AppRoutes{
  static const initialRoute = 'register';
  static final menuOption=<RoutesModel>[
      RoutesModel(route: 'home',icon: Icons.home,name: 'Details page',screen: const HomeScreen()),
      RoutesModel(route: 'register', icon: Icons.app_registration_rounded, name: 'Register Screen', screen: const RegisterScreen()),
      RoutesModel(route: 'petscreen', icon: Icons.pets, name: 'Pets', screen: const PetsScreen()),
      RoutesModel(route: 'petregister', icon: Icons.pets, name: 'Animal Register', screen: const PetRegisterScreen()),
      RoutesModel(route: 'qr', icon: Icons.pets, name: 'qr screen', screen: const QrScreen()),
      RoutesModel(route: 'reservation', icon: Icons.pets, name: 'Reservation Screen', screen: const ReservationScreen()),
      RoutesModel(route: 'reservation_pet', icon: Icons.app_registration, name: 'Reservation Screen', screen: ReservationPetScreen()),
      RoutesModel(route: 'reservation_pet_details', icon: Icons.app_registration, name: 'Reservation Details Screen', screen: ReservationDetailsScreen()),
      RoutesModel(route: 'profile', icon: Icons.pets, name: 'Profile Screen', screen: const ProfileScreen()),
      RoutesModel(route: 'hosters', icon: Icons.house, name: 'Hosters Screen', screen: const HosterScreen()),
      RoutesModel(route: 'hosterinfo', icon: Icons.house, name: 'Hoster Info Screen', screen: const HosterInfoScreen()),
      RoutesModel(route: 'payment', icon: Icons.card_giftcard, name: 'Payment Screen', screen: PaymentScreen()),
      RoutesModel(route: 'registerone', icon: Icons.app_registration, name: 'Register one Screen', screen: RegisterOneScreen()),
      RoutesModel(route: 'register_two_pet', icon: Icons.app_registration, name: 'Register Two Pet Screen', screen: RegisterTwoPetScreen()),
      RoutesModel(route: 'register_two_pet_birth', icon: Icons.app_registration, name: 'Register Two Pet Screen', screen: RegisterBirth()),
      RoutesModel(route: 'register_two_pet_mail', icon: Icons.app_registration, name: 'Register Two Pet Screen', screen: RegisterMail()),
      RoutesModel(route: 'register_two_pet_pass', icon: Icons.app_registration, name: 'Register Two Pet Screen', screen: RegisterPass()),
      RoutesModel(route: 'register_two_pet_pin', icon: Icons.app_registration, name: 'Register Two Pet Screen', screen: RegisterPin()),
      RoutesModel(route: 'register_two_pet_successful', icon: Icons.app_registration, name: 'Register Two Pet Screen', screen: SuccessfulRegister()),
      RoutesModel(route: 'walkers', icon: Icons.app_registration, name: 'Walkers Screen', screen: WalkersScreen()),

















      
  ];

  static Map<String,Widget Function(BuildContext)> allRoutes(){
    Map<String,Widget Function(BuildContext)> listOfRoutes={};

    listOfRoutes.addAll({
      'login':(BuildContext context)=> const LoginScreen(),
      });

    for (final i in menuOption){
      listOfRoutes.addAll({
        i.route: (BuildContext context)=>i.screen
        });
    }

    return listOfRoutes;
  }

}

class ErrorRoute{
  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    return MaterialPageRoute(builder: (context)=>const AlertScreen());
  }
}