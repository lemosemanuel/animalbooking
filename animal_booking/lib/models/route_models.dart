import 'package:flutter/material.dart';


class RoutesModel{
  final String route;
  final IconData icon;
  final String name;
  final Widget screen;

  RoutesModel({
    required this.route,
    required this.icon,
    required this.name,
    required this.screen
  });
}