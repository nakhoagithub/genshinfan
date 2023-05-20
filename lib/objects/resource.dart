import 'package:genshinfan/objects/url.dart';

class Resource {
  Resource({
    this.key,
    required this.name,
    this.dupealias,
    required this.description,
    required this.sortorder,
    this.rarity,
    required this.category,
    required this.materialtype,
    this.dropdomain,
    this.daysofweek,
    required this.source,
    this.images,
    this.url,
  });

  String? key;
  final String name;
  final String? dupealias;
  final String description;
  final int sortorder;
  final String? rarity;
  final String category;
  final String materialtype;
  final String? dropdomain;
  final List<String>? daysofweek;
  final List<String> source;
  ImageResource? images;
  UrlObject? url;

  void setImage(dynamic json) {
    images = ImageResource.fromJson(json);
  }

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        key: json['key'],
        name: json["name"],
        dupealias: json["dupealias"],
        description: json["description"],
        sortorder: json["sortorder"],
        rarity: json["rarity"],
        category: json["category"],
        materialtype: json["materialtype"],
        dropdomain: json["dropdomain"],
        daysofweek: json["daysofweek"] == null
            ? null
            : List<String>.from(json["daysofweek"]!.map((x) => x)),
        source: List<String>.from(json["source"].map((x) => x)),
        images: json['images'] == null
            ? null
            : ImageResource.fromJson(json['images']),
        url: json['url'] == null ? null : UrlObject.fromJson(json['url']),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "dupealias": dupealias,
        "description": description,
        "sortorder": sortorder,
        "rarity": rarity,
        "category": category,
        "materialtype": materialtype,
        "dropdomain": dropdomain,
        "daysofweek": daysofweek == null
            ? null
            : List<dynamic>.from(daysofweek!.map((x) => x)),
        "source": List<dynamic>.from(source.map((x) => x)),
        "images": images?.toJson(),
        "url": url?.toJson(),
      };
}

class ImageResource {
  ImageResource({
    required this.redirect,
    this.fandom,
    required this.nameicon,
  });

  final String redirect;
  final String? fandom;
  final String nameicon;

  factory ImageResource.fromJson(Map<String, dynamic> json) => ImageResource(
        redirect: json["redirect"],
        fandom: json["fandom"],
        nameicon: json["nameicon"],
      );

  Map<String, dynamic> toJson() => {
        "redirect": redirect,
        "fandom": fandom,
        "nameicon": nameicon,
      };
}
