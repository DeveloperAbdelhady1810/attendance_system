import 'package:hive/hive.dart';
part 'session.g.dart';
@HiveType(typeId: 3)
class Session{
  @HiveField(0)
  List attendants;
  @HiveField(1)
  String name;
  @HiveField(2)
  String sessionId;
  @HiveField(3)
  Map<String,String> mark;
  @HiveField(4)
  String time;
  @HiveField(5)
  String weekday;
  @HiveField(6)
  String branch;
  @HiveField(7)
  String stage;
  @HiveField(8)
  String isscientific;
  @HiveField(9)
  String chpname;
  Session({
    required this.sessionId,
    required this.weekday,
    required this.stage,
    required this.branch,
    required this.attendants,
    required this.name,
    required this.mark,
    required this.time,
    required this.isscientific,
    required this.chpname,
  });
}
