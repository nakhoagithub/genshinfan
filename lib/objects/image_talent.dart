class ImageTalent {
  ImageTalent({
    required this.combat1,
    required this.combat2,
    this.combatsp,
    required this.combat3,
    required this.passive1,
    required this.passive2,
    this.passive3,
  });

  String combat1;
  String combat2;
  String? combatsp;
  String combat3;
  String passive1;
  String passive2;
  String? passive3;

  factory ImageTalent.fromJson(Map<String, dynamic> json) => ImageTalent(
        combat1: json["combat1"],
        combat2: json["combat2"],
        combatsp: json["combatsp"],
        combat3: json["combat3"],
        passive1: json["passive1"],
        passive2: json["passive2"],
        passive3: json["passive3"],
      );

  Map<String, dynamic> toJson() => {
        "combat1": combat1,
        "combat2": combat2,
        "combatsp": combatsp,
        "combat3": combat3,
        "passive1": passive1,
        "passive2": passive2,
        "passive3": passive3,
      };
}
