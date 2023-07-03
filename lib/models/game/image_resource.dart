class ImageResource {
  ImageResource({
    required this.redirect,
    this.fandom,
    required this.nameicon,
  });

  String redirect;
  String? fandom;
  String nameicon;

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
