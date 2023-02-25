import 'image_resource.dart';

class Resource {
  Resource({
    required this.name,
    this.dupealias,
    required this.description,
    required this.sortorder,
    this.rarity,
    required this.category,
    this.resourcetype,
    this.dropdomain,
    this.daysofweek,
    required this.source,
    this.images,
  });

  String name;
  String? dupealias;
  String description;
  int sortorder;
  String? rarity;
  String category;
  String? resourcetype;
  String? dropdomain;
  List<String>? daysofweek;
  List<String> source;
  ImageResource? images;

  static Resource init() {
    return Resource(
        name: "", description: "", sortorder: 0, category: "", source: []);
  }

  void setImage(dynamic json) {
    images = ImageResource.fromJson(json);
  }

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        name: json["name"],
        dupealias: json["dupealias"],
        description: json["description"],
        sortorder: json["sortorder"],
        rarity: json["rarity"],
        category: json["category"],
        resourcetype: json["resourcetype"],
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
        "name": name,
        "dupealias": dupealias,
        "description": description,
        "sortorder": sortorder,
        "rarity": rarity,
        "category": category,
        "resourcetype": resourcetype,
        "dropdomain": dropdomain,
        "daysofweek": daysofweek == null
            ? null
            : List<dynamic>.from(daysofweek!.map((x) => x)),
        "source": List<dynamic>.from(source.map((x) => x)),
        "images": images?.toJson(),
      };
}
