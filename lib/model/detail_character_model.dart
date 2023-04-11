class DetailCharacter {
  String? height;
  String? mass;
  String? hairColor;
  String? skinColor;
  String? eyeColor;
  String? birthYear;
  String? gender;
  String? created;
  String? edited;
  String? name;
  String? homeworld;
  String? url;
  String? description;
  String? uid;

  DetailCharacter({
    this.uid,
    this.description,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.created,
    this.edited,
    this.name,
    this.homeworld,
    this.url,
  });

  DetailCharacter.fromJson(Map<String, dynamic> json) {
    var properties = json['properties'];

    description = json['description'];
    uid = json['uid'];
    height = properties?['height'];
    mass = properties?['mass'];
    hairColor = properties?['hair_color'];
    skinColor = properties?['skin_color'];
    eyeColor = properties?['eye_color'];
    birthYear = properties?['birth_year'];
    gender = properties?['gender'];
    created = properties?['created'];
    edited = properties?['edited'];
    name = properties?['name'];
    homeworld = properties?['homeworld'];
    url = properties?['url'];
  }
}
