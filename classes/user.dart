import 'package:hive/hive.dart';
part 'user.g.dart';
@HiveType(typeId: 1)
class Student {
  @HiveField(0)
  int id;
  @HiveField(1)
  String cardId;
  @HiveField(2)
  String firstName;
  @HiveField(3)
  String lastName;
  @HiveField(4)
  String phone;
  @HiveField(5)
  String email;
  @HiveField(6)
  String password;
  @HiveField(7)
  String parrentEmail;
  @HiveField(8)
  String parrentPassword;
  @HiveField(9)
  String parrentPhone;
  @HiveField(10)
  String gender;
  @HiveField(11)
  String stage;
  @HiveField(12)
  String place;
  @HiveField(13)
  String time;
  @HiveField(14)
  String state;
  @HiveField(15)
  String balance;
  @HiveField(16)
  Student({
    this.id = 0,
    required this.balance,
    required this.cardId,
    required this.email,
    required this.firstName,
    required this.gender,
    required this.lastName,
    required this.parrentEmail,
    required this.parrentPassword,
    required this.parrentPhone,
    required this.password,
    required this.phone,
    required this.stage,
    required this.place,
    required this.state,
    required this.time,
  });
}