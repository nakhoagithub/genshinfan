import 'package:genshinfan/resources/utils/enum.dart';

class DataApp {
  final int total;
  final int received;
  final DataAppStatus dataAppStatus;
  final String? log;

  const DataApp({
    required this.total,
    required this.received,
    required this.dataAppStatus,
    this.log,
  });
}
