class Animal {
  String? key;
  final String name;
  final String description;
  final String category;
  final String counttype;
  final int sortorder;
  ImageAnimal? images;
  String? version;

  Animal({
    this.key,
    required this.name,
    required this.description,
    required this.category,
    required this.counttype,
    required this.sortorder,
    this.images,
    this.version,
  });

  void setImage(dynamic json) {
    images = ImageAnimal.fromJson(json);
  }

  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
        key: json['key'],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        counttype: json["counttype"],
        sortorder: json["sortorder"],
        images: json['images'] == null
            ? null
            : ImageAnimal.fromJson(json['images']),
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "description": description,
        "category": category,
        "counttype": counttype,
        "sortorder": sortorder,
        "images": images?.toJson(),
        "version": version,
      };
}

class ImageAnimal {
  final String nameicon;
  const ImageAnimal({
    required this.nameicon,
  });

  factory ImageAnimal.fromJson(Map<String, dynamic> json) => ImageAnimal(
        nameicon: json["nameicon"],
      );

  Map<String, dynamic> toJson() => {
        "nameicon": nameicon,
      };
}
