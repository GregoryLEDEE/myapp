class BasicCharacter {
  String? uid;
  String? name;
  String? url;

  BasicCharacter({this.uid, this.name, this.url});

  BasicCharacter.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    url = json['url'];
  }
}
