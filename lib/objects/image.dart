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

  final String? card;
  final String? portrait;
  final String? icon;
  final String? sideicon;
  final String? cover1;
  final String? cover2;
  final String? hoyolabAvatar;
  final String? namecard;
  final String? nameicon;
  final String? nameiconcard;
  final String? namegachasplash;
  final String? namegachaslice;
  final String? namesideicon;

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
