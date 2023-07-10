class ImageFood {
  ImageFood({
    required this.nameicon,
  });
  String nameicon;

  factory ImageFood.fromJson(Map<String, dynamic> json) => ImageFood(
        nameicon: json["nameicon"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "nameicon": nameicon,
      };
}
