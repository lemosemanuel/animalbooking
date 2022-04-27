import 'package:animal_booking/providers/providers.dart';
import 'package:animal_booking/routes/routes.dart';
import 'package:animal_booking/services/services.dart';
// import 'package:animal_booking/ux_ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AuthService()),
        ChangeNotifierProvider(create: (_)=>IndexBottonNavigation()),
        ChangeNotifierProvider(create: (_)=>PetsService()),
        ChangeNotifierProvider(create: (_)=>ListDropDown()),
        ChangeNotifierProvider(create: (_)=>SendEmailPin()),

        ChangeNotifierProvider(create: (_)=>HosterService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animal Booking',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.allRoutes(),
      onGenerateRoute:(settings) => ErrorRoute.onGenerateRoute(settings),
      // theme: AppTheme.myAppTheme,
    );
  }
}







