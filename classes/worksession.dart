import 'package:attendants/classes/session.dart';
import 'package:hive/hive.dart';
part 'worksession.g.dart';
@HiveType(typeId: 2)
class WorkSession {
  @HiveField(0)
  Session session;
  WorkSession({
    required this.session,
  });
}