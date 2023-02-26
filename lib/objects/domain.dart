import 'package:genshinfan/objects/reward_preview.dart';

class Domain {
  Domain({
    required this.name,
    required this.region,
    this.domainentrance,
    this.daysofweek,
    required this.domaintype,
    required this.description,
    this.domainLvs,
  });
  String name;
  String region;
  String? domainentrance;
  List<String>? daysofweek;
  String domaintype;
  String description;
  List<DomainLv>? domainLvs;

  factory Domain.fromJson(Map<String, dynamic> json) => Domain(
        name: json["name"],
        region: json["region"],
        domainentrance: json["domainentrance"],
        daysofweek: json["daysofweek"] == null
            ? null
            : List<String>.from(json["daysofweek"].map((x) => x)),
        domaintype: json["domaintype"],
        description: json["description"],
        domainLvs: json["domainLvs"] == null
            ? null
            : List<DomainLv>.from(
                json["domainLvs"].map((x) => DomainLv.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "description": description,
        "domainentrance": domainentrance,
        "daysofweek": daysofweek == null
            ? null
            : List<dynamic>.from(daysofweek!.map((x) => x)),
        "domaintype": domaintype,
        "domainLvs": domainLvs == null
            ? null
            : List<dynamic>.from(domainLvs!.map((x) => x.toJson())),
      };
}

class DomainLv {
  DomainLv({
    required this.name,
    required this.recommendedlevel,
    required this.recommendedelements,
    required this.unlockrank,
    required this.rewardpreview,
    required this.disorder,
    required this.monsterlist,
    this.images,
  });
  String name;
  int recommendedlevel;
  List<String> recommendedelements;
  int unlockrank;
  List<Rewardpreview> rewardpreview;
  List<String> disorder;
  List<String> monsterlist;
  ImageDomain? images;

  factory DomainLv.fromJson(Map<String, dynamic> json) => DomainLv(
        name: json["name"],
        recommendedlevel: json["recommendedlevel"],
        recommendedelements: json["recommendedelements"] == null
            ? []
            : List<String>.from(json["recommendedelements"].map((x) => x)),
        unlockrank: json["unlockrank"],
        rewardpreview: List<Rewardpreview>.from(
            json["rewardpreview"].map((x) => Rewardpreview.fromJson(x))),
        disorder: List<String>.from(json["disorder"].map((x) => x)),
        monsterlist: List<String>.from(json["monsterlist"].map((x) => x)),
        images: json["images"] == null
            ? null
            : ImageDomain.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "recommendedlevel": recommendedlevel,
        "recommendedelements":
            List<dynamic>.from(recommendedelements.map((x) => x)),
        "unlockrank": unlockrank,
        "rewardpreview":
            List<dynamic>.from(rewardpreview.map((x) => x.toJson())),
        "disorder": List<dynamic>.from(disorder.map((x) => x)),
        "monsterlist": List<dynamic>.from(monsterlist.map((x) => x)),
        "images": images?.toJson(),
      };
}

class ImageDomain {
  ImageDomain({
    this.namepic,
  });

  String? namepic;

  factory ImageDomain.fromJson(Map<String, dynamic> json) => ImageDomain(
        namepic: json["namepic"],
      );

  Map<String, dynamic> toJson() => {
        "namepic": namepic,
      };
}
