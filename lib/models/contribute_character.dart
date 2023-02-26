class ContributeCharacter {
  final String name;
  final String weapon;
  final int typeSet;
  final String sands; // đồng hồ
  final String goblet; // ly
  final String circlet; // nón

  // social
  final int? like;
  final int? view;

  const ContributeCharacter({
    required this.name,
    required this.weapon,
    required this.typeSet,
    required this.sands,
    required this.goblet,
    required this.circlet,
    this.like,
    this.view,
  });

  factory ContributeCharacter.fromJson(Map<String, dynamic> json) {
    return ContributeCharacter(
      name: json['name'],
      weapon: json['weapon'],
      typeSet: json['type_set'],
      sands: json['sands'],
      goblet: json['goblet'],
      circlet: json['circlet'],
      like: json['like'],
      view: json['view'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "weapon": weapon,
      "type_set": typeSet,
      "sands": sands,
      "goblet": goblet,
      "circlet": circlet,
      "like": like,
      "view": view,
    };
  }
}
