/// Version < 1.4.3
class CharacterBuildingOld {
  String? key;
  final String characterName;
  final String? element;
  final String weapon;
  final int typeSet;
  final String a1;
  final String? a2;
  final String sands; // đồng hồ
  final String goblet; // ly
  final String circlet; // nón
  final String author;
  final String uidAuthor;

  CharacterBuildingOld({
    this.key,
    required this.characterName,
    this.element,
    required this.weapon,
    required this.typeSet,
    required this.a1,
    this.a2,
    required this.sands,
    required this.goblet,
    required this.circlet,
    required this.author,
    required this.uidAuthor,
  });

  factory CharacterBuildingOld.fromJson(Map<dynamic, dynamic> json) {
    return CharacterBuildingOld(
      characterName: json['name'],
      element: json['element'],
      weapon: json['weapon'],
      typeSet: json['type_set'],
      a1: json['a1'],
      a2: json['a2'],
      sands: json['sands'],
      goblet: json['goblet'],
      circlet: json['circlet'],
      author: json['author'],
      uidAuthor: json['uid_author'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": characterName,
      "element": element,
      "weapon": weapon,
      "type_set": typeSet,
      "a1": a1,
      "a2": a2,
      "sands": sands,
      "goblet": goblet,
      "circlet": circlet,
      "author": author,
      "uid_author": uidAuthor,
    };
  }
}
