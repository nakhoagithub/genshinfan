class ImageConstellation {
  ImageConstellation({
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
    required this.constellation,
    this.constellation2,
  });

  String c1;
  String c2;
  String c3;
  String c4;
  String c5;
  String c6;
  String constellation;
  String? constellation2;

  factory ImageConstellation.fromJson(Map<String, dynamic> json) =>
      ImageConstellation(
        c1: json["c1"],
        c2: json["c2"],
        c3: json["c3"],
        c4: json["c4"],
        c5: json["c5"],
        c6: json["c6"],
        constellation: json["constellation"],
        constellation2: json["constellation2"],
      );

  Map<String, dynamic> toJson() => {
        "c1": c1,
        "c2": c2,
        "c3": c3,
        "c4": c4,
        "c5": c5,
        "c6": c6,
        "constellation": constellation,
        "constellation2": constellation2,
      };
}
