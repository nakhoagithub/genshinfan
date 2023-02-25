class Traffic {
  dynamic totalTraffic;
  dynamic trafficInDay;
  dynamic trafficInMonth;

  Traffic({
    required this.totalTraffic,
    required this.trafficInDay,
    required this.trafficInMonth,
  });

  factory Traffic.fromJson(Map<dynamic, dynamic> json) {
    return Traffic(
      totalTraffic: json['totalTraffic'],
      trafficInDay: json['trafficInDay'],
      trafficInMonth: json['trafficInMonth'],
    );
  }

  Map<String, dynamic> toJon() {
    return {
      "totalTraffic": totalTraffic,
      "trafficInDay": trafficInDay,
      "trafficInMonth": trafficInMonth,
    };
  }
}
