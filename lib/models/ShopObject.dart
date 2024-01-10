import 'package:flutter/material.dart';

class ShopObject {
  String title;
  String description;
  String type;
  String name;
  Widget? widget;
  int price;
  Function? function;

  ShopObject({
    required this.title,
    required this.description,
    required this.name,
    required this.type,
    required this.price,
    this.widget,
    this.function,
  });


}