// To parse this JSON data, do
//
//     final pet = petFromMap(jsonString);

import 'dart:convert';

class Pet {
    Pet({
        required this.age,
        this.description,
        this.image,
        required this.diseases,
        required this.email,
        required this.habitat,
        this.important,
        required this.location,
        required this.name,
        required this.origin,
        required this.owner,
        required this.phone,
        this.picture,
        required this.race,
        required this.reproductiveStatus,
        required this.sex,
        required this.surgeries,
        required this.type,
        required this.vaccination,
        required this.weight,
        this.id,
        this.distance,
        this.aviable,
    });

    String age;
    String? image;
    String? description;
    String diseases;
    String email;
    String habitat;
    String? important;
    String location;
    String name;
    String origin;
    String owner;
    String phone;
    String? picture;
    String race;
    String? reproductiveStatus;
    String sex;
    bool surgeries;
    String type;
    bool vaccination;
    String weight;
    String? id;
    String? distance;
    bool? aviable;

    factory Pet.fromJson(String str) => Pet.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pet.fromMap(Map<String, dynamic> json) => Pet(
        age: json["age"],
        description: json["description"],
        diseases: json["diseases"],
        email: json["email"],
        habitat: json["habitat"],
        important: json["important"],
        location: json["location"],
        name: json["name"],
        origin: json["origin"],
        owner: json["owner"],
        phone: json["phone"],
        picture: json["picture"],
        race: json["race"],
        reproductiveStatus: json["reproductive status"],
        sex: json["sex"],
        surgeries: json["surgeries"],
        type: json["type"],
        vaccination: json["vaccination"],
        weight: json["weight"],
        id: json["id"],
        distance:json["distance"]
    );

    Map<String, dynamic> toMap() => {
        "age": age,
        "description": description,
        "diseases": diseases,
        "email": email,
        "habitat": habitat,
        "important": important,
        "location": location,
        "name": name,
        "origin": origin,
        "owner": owner,
        "phone": phone,
        "picture": picture,
        "race": race,
        "reproductive status": reproductiveStatus,
        "sex": sex,
        "surgeries": surgeries,
        "type": type,
        "vaccination": vaccination,
        "weight": weight,
        "id": id,
        "distance":distance,
        "aviable":aviable
    };

    Pet copy()=>Pet(
      age:age,
      image:image,
      description:description,
      diseases:diseases,
      email:email,
      habitat:habitat,
      important:important,
      location:location,
      name:name,
      origin:origin,
      owner:owner,
      phone:phone,
      picture:picture,
      race:race,
      reproductiveStatus:reproductiveStatus,
      sex:sex,
      surgeries:surgeries,
      type:type,
      vaccination:vaccination,
      weight:weight,
      id:id,
      distance:distance,
      aviable:aviable
    );
}


// List<Pet> pets = [
//   Pet(image:'https://www.65ymas.com/uploads/s1/76/14/09/bigstock-beautiful-portrait-dog-breed-b-419947822_1_621x621.jpeg',
//       distance: '32km',
//       age: '22', diseases: 'no tiene enfermedades', email: 'ema@gmail.com', habitat: 'departamento', location: '32323', name: 'Luna', origin: "street", owner: 'Emanuel', phone: '2313213', race: 'No tiene', reproductiveStatus: 'Castrada', sex: 'Femenina', surgeries: false, type: 'Perro', vaccination: true, weight: '43', id: '1')
// ];



// List<Pet> pets = [
//   const Pet(
//     id: "1",
//     name: "Luna",
//     location: "Es una Perra de Raza Indefinida",
//     distance: "54.6m Km",
//     weight: 8,
//     description: "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System after Mercury. In English, Mars carries a name of the Roman god of war, and is often referred to as the 'Red Planet' because the reddish iron oxide prevalent on its surface gives it a reddish appearance that is distinctive among the astronomical bodies visible to the naked eye. Mars is a terrestrial planet with a thin atmosphere, having surface features reminiscent both of the impact craters of the Moon and the valleys, deserts, and polar ice caps of Earth.",
//     image: "assets/img/perro1.jpg",
//     picture: "https://www.nasa.gov/sites/default/files/thumbnails/image/pia21723-16.jpg"
//   ),
//   const Pet(
//     id: "2",
//     name: "Muchael",
//     location: "Labrador",
//     distance: "54.6m Km",
//     weight: 8,
//     description: "Neptune is the eighth and farthest known planet from the Sun in the Solar System. In the Solar System, it is the fourth-largest planet by diameter, the third-most-massive planet, and the densest giant planet. Neptune is 17 times the mass of Earth and is slightly more massive than its near-twin Uranus, which is 15 times the mass of Earth and slightly larger than Neptune. Neptune orbits the Sun once every 164.8 years at an average distance of 30.1 astronomical units (4.50×109 km). It is named after the Roman god of the sea and has the astronomical symbol ♆, a stylised version of the god Neptune's trident",
//     image: "assets/img/perro2.jpg",
//     picture: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/images/110411main_Voyager2_280_yshires.jpg"
//   ),
//   const Pet(
//     id: "3",
//     name: "Aristobulo",
//     location: "Gato tipo Gato Felix",
//     distance: "54.6m Km",
//     weight: 8,
//     description: "The Moon is an astronomical body that orbits planet Earth, being Earth's only permanent natural satellite. It is the fifth-largest natural satellite in the Solar System, and the largest among planetary satellites relative to the size of the planet that it orbits (its primary). Following Jupiter's satellite Io, the Moon is second-densest satellite among those whose densities are known.",
//     image: "assets/img/gato1.jpeg",
//     picture: "https://farm5.staticflickr.com/4086/5052125139_43c31b7012.jpg"
//   ),
//   const Pet(
//     id: "4",
//     name: "Dogi",
//     location: "Golden de Raza",
//     distance: "54.6m Km",
//     weight: 8,
//     description: "Earth is the third planet from the Sun and the only object in the Universe known to harbor life. According to radiometric dating and other sources of evidence, Earth formed over 4 billion years ago. Earth's gravity interacts with other objects in space, especially the Sun and the Moon, Earth's only natural satellite. Earth revolves around the Sun in 365.26 days, a period known as an Earth year. During this time, Earth rotates about its axis about 366.26 times.",
//     image: "assets/img/perro3.jpeg",
//     picture: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/iss042e340851_1.jpg"
//   ),
//   const Pet(
//     id: "5",
//     name: "Manuelita",
//     location: "Tortuga de Raza Pura",
//     distance: "54.6m Km",
//     weight: 8,
//     description: "Mercury is the smallest and innermost planet in the Solar System. Its orbital period around the Sun of 88 days is the shortest of all the planets in the Solar System. It is named after the Roman deity Mercury, the messenger to the gods.",
//     image: "assets/img/tortuga1.jpg",
//     picture: "https://c1.staticflickr.com/9/8105/8497927473_2845ae671e_b.jpg"
//   ),
  
// ];