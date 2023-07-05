/// Version 1.5
class CharacterBuilding {
  String? key;
  final String characterName;
  final String? element;
  final String weapon;
  final int typeSet;
  final String a1;
  final String? a2;
  final List<String> sands; // đồng hồ
  final List<String> goblets; // ly
  final List<String> circlets; // nón
  final String author;
  final String uidAuthor;

  CharacterBuilding({
    this.key,
    required this.characterName,
    this.element,
    required this.weapon,
    required this.typeSet,
    required this.a1,
    this.a2,
    required this.sands,
    required this.goblets,
    required this.circlets,
    required this.author,
    required this.uidAuthor,
  });

  factory CharacterBuilding.fromJson(Map<dynamic, dynamic> json) {
    return CharacterBuilding(
      characterName: json['name'],
      element: json['element'],
      weapon: json['weapon'],
      typeSet: json['type_set'],
      a1: json['a1'],
      a2: json['a2'],
      sands: json['sands'] == null
          ? []
          : List<String>.from(json["sands"].map((x) => x)),
      goblets: json['goblets'] == null
          ? []
          : List<String>.from(json["sands"].map((x) => x)),
      circlets: json['circlets'] == null
          ? []
          : List<String>.from(json["sands"].map((x) => x)),
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
      "sands": List<dynamic>.from(sands.map((x) => x)),
      "goblets": List<dynamic>.from(goblets.map((x) => x)),
      "circlets": List<dynamic>.from(circlets.map((x) => x)),
      "author": author,
      "uid_author": uidAuthor,
    };
  }
}
