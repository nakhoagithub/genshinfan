class ContributeCharacter {
  final String character;
  final String weapon;
  final int typeSet;
  final String a1;
  final String? a2;
  final String sands; // đồng hồ
  final String goblet; // ly
  final String circlet; // nón

  // social
  final int? like;
  final int? view;

  const ContributeCharacter({
    required this.character,
    required this.weapon,
    required this.typeSet,
    required this.a1,
    this.a2,
    required this.sands,
    required this.goblet,
    required this.circlet,
    this.like,
    this.view,
  });

  factory ContributeCharacter.fromJson(Map<String, dynamic> json) {
    return ContributeCharacter(
      character: json['name'],
      weapon: json['weapon'],
      typeSet: json['type_set'],
      a1: json['a1'],
      a2: json['a2'],
      sands: json['sands'],
      goblet: json['goblet'],
      circlet: json['circlet'],
      like: json['like'],
      view: json['view'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": character,
      "weapon": weapon,
      "type_set": typeSet,
      "a1": a1,
      "a2": a2,
      "sands": sands,
      "goblet": goblet,
      "circlet": circlet,
      "like": like,
      "view": view,
    };
  }
}
