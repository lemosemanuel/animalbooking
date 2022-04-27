import 'package:animal_booking/ux_ui/background/background_home.dart';
import 'package:animal_booking/widgets/custom_bottonNavigationBar_home.dart';
import 'package:flutter/material.dart';
import 'package:animal_booking/widgets/cards_tables_home.dart';


class HostChoice extends StatelessWidget {
  const HostChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Stack(
              children: [
                BackgroundHome(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Table(
                      children: [
                        TableRow(
                          children: [
                            SingleCard(page: "home", icon: Icon(Icons.vpn_key_outlined), color: Colors.greenAccent, text: "I'm Hoster"),
                            SingleCard(page: "hosters", icon: Icon(Icons.house), color: Colors.greenAccent, text: "Looking a Host"),
                          ],
                        ),
                        
                      ],
                    ),
                  ],
                )
              ],
            ),
            bottomNavigationBar: const CustomBottomNavigation(),

          );
  }
}