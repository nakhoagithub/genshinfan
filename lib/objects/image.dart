class Image {
  Image({
    this.card,
    this.portrait,
    this.icon,
    this.sideicon,
    this.cover1,
    this.cover2,
    this.hoyolabAvatar,
    this.namecard,
    this.nameicon,
    this.nameiconcard,
    this.namegachasplash,
    this.namegachaslice,
    this.namesideicon,
  });

  String? card;
  String? portrait;
  String? icon;
  String? sideicon;
  String? cover1;
  String? cover2;
  String? hoyolabAvatar;
  String? namecard;
  String? nameicon;
  String? nameiconcard;
  String? namegachasplash;
  String? namegachaslice;
  String? namesideicon;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        card: json["card"],
        portrait: json["portrait"],
        icon: json["icon"],
        sideicon: json["sideicon"],
        cover1: json["cover1"],
        cover2: json["cover2"],
        hoyolabAvatar: json["hoyolab-avatar"],
        namecard: json["namecard"],
        nameicon: json["nameicon"],
        nameiconcard: json["nameiconcard"],
        namegachasplash: json["namegachasplash"],
        namegachaslice: json["namegachaslice"],
        namesideicon: json["namesideicon"],
      );

  Map<String, dynamic> toJson() => {
        "card": card,
        "portrait": portrait,
        "icon": icon,
        "sideicon": sideicon,
        "cover1": cover1,
        "cover2": cover2,
        "hoyolab-avatar": hoyolabAvatar,
        "namecard": namecard,
        "nameicon": nameicon,
        "nameiconcard": nameiconcard,
        "namegachasplash": namegachasplash,
        "namegachaslice": namegachaslice,
        "namesideicon": namesideicon,
      };
}
