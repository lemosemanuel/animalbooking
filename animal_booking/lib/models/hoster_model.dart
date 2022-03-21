// To parse this JSON data, do
//
//     final hosters = hostersFromMap(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';

// class Hoster {
//     Hoster({
//         this.housePicture,
//         this.id,
//         required this.isBest,
//         required this.isFood,
//         required this.isShower,
//         this.isWalking,
//         this.lastname,
//         this.name,
//         this.price,
//         this.qualification,
//         this.street,
//         this.typeOfHouse,
//     });

//     String? housePicture;
//     String? id;
//     bool isBest;
//     bool isFood;
//     bool isShower;
//     bool? isWalking;
//     String? lastname;
//     String? name;
//     String? price;
//     String? qualification;
//     String? street;
//     String? typeOfHouse;

//     factory Hoster.fromJson(String str) => Hoster.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Hoster.fromMap(Map<String, dynamic> json) => Hoster(
//         housePicture: json["house_picture"],
//         id: json["id"],
//         isBest: json["isBest"],
//         isFood: json["isFood"],
//         isShower: json["isShower"],
//         isWalking: json["isWalking"],
//         lastname: json["lastname"],
//         name: json["name"],
//         price: json["price"],
//         qualification: json["qualification"],
//         street: json["street"],
//         typeOfHouse: json["typeOfHouse"],
//     );

//     Map<String, dynamic> toMap() => {
//         "house_picture": housePicture,
//         "id": id,
//         "isBest": isBest,
//         "isFood": isFood,
//         "isShower": isShower,
//         "isWalking": isWalking,
//         "lastname": lastname,
//         "name": name,
//         "price": price,
//         "qualification": qualification,
//         "street": street,
//         "typeOfHouse": typeOfHouse,
//     };
// }




// To parse this JSON data, do
//
//     final hosters = hostersFromMap(jsonString);


// To parse this JSON data, do
//
//     final hosters = hostersFromMap(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final hosters = hostersFromMap(jsonString);

import 'dart:convert';

class Hoster {
    Hoster({
        this.houseName,
        required this.housePicture,
        this.id,
        this.isBest,
        this.isFood,
        this.isShower,
        this.isWalking,
        this.lastname,
        this.lat,
        this.log,
        this.name,
        this.placeDescription,
        this.price,
        this.profilePicture,
        this.qualification,
        required this.reviews,
        this.street,
        this.typeOfHouse,
    });

    String? houseName;
    List<HousePicture> housePicture;
    String? id;
    bool? isBest;
    bool? isFood;
    bool? isShower;
    bool? isWalking;
    String? lastname;
    String? lat;
    String? log;
    String? name;
    String? placeDescription;
    String? price;
    String? profilePicture;
    String? qualification;
    List<Review> reviews;
    String? street;
    String? typeOfHouse;

    factory Hoster.fromJson(String str) => Hoster.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Hoster.fromMap(Map<String, dynamic> json) => Hoster(
        houseName: json["house_name"],
        housePicture: List<HousePicture>.from(json["house_picture"].map((x) => HousePicture.fromMap(x))),
        id: json["id"],
        isBest: json["isBest"],
        isFood: json["isFood"],
        isShower: json["isShower"],
        isWalking: json["isWalking"],
        lastname: json["lastname"],
        lat: json["lat"],
        log: json["log"],
        name: json["name"],
        placeDescription: json["place_description"],
        price: json["price"],
        profilePicture: json["profile_picture"],
        qualification: json["qualification"],
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromMap(x))),
        street: json["street"],
        typeOfHouse: json["typeOfHouse"],
    );

    Map<String, dynamic> toMap() => {
        "house_name": houseName,
        "house_picture": List<dynamic>.from(housePicture.map((x) => x.toMap())),
        "id": id,
        "isBest": isBest,
        "isFood": isFood,
        "isShower": isShower,
        "isWalking": isWalking,
        "lastname": lastname,
        "lat": lat,
        "log": log,
        "name": name,
        "place_description": placeDescription,
        "price": price,
        "profile_picture": profilePicture,
        "qualification": qualification,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toMap())),
        "street": street,
        "typeOfHouse": typeOfHouse,
    };
}

class HousePicture {
    HousePicture({
        this.picture,
    });

    String? picture;

    factory HousePicture.fromJson(String str) => HousePicture.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HousePicture.fromMap(Map<String, dynamic> json) => HousePicture(
        picture: json["picture"],
    );

    Map<String, dynamic> toMap() => {
        "picture": picture,
    };
}

class Review {
    Review({
        this.comment,
        this.name,
    });

    String? comment;
    String? name;

    factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Review.fromMap(Map<String, dynamic> json) => Review(
        comment: json["comment"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "comment": comment,
        "name": name,
    };
}

