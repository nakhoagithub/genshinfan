import 'image_resource.dart';

class Resource {
  Resource({
    this.id,
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
  });

  String? id;
  String name;
  String? dupealias;
  String description;
  int sortorder;
  String? rarity;
  String category;
  String materialtype;
  String? dropdomain;
  List<String>? daysofweek;
  List<String> source;
  ImageResource? images;

  void setImage(dynamic json) {
    images = ImageResource.fromJson(json);
  }

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        id: json['id'],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
      };
}
