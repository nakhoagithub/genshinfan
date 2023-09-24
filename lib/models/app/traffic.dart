class Traffic {
  dynamic totalTraffic;
  dynamic trafficInDay;
  dynamic trafficInMonth;
  dynamic online;

  Traffic({
    this.totalTraffic,
    this.trafficInDay,
    this.trafficInMonth,
    this.online,
  });

  factory Traffic.fromJson(Map<dynamic, dynamic> json) {
    return Traffic(
      totalTraffic: json['totalTraffic'],
      trafficInDay: json['trafficInDay'],
      trafficInMonth: json['trafficInMonth'],
      online: json['online'],
    );
  } 

  Map<String, dynamic> toJon() {
    return {
      "totalTraffic": totalTraffic,
      "trafficInDay": trafficInDay,
      "trafficInMonth": trafficInMonth,
      "online": online,
    };
  }
}
