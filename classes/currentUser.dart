import 'package:attendants/classes/assistant.dart';
import 'package:attendants/classes/user.dart';
Student currentStudent = Student(cardId: "", email: "", firstName: "", gender: "", lastName: "", parrentEmail: "", parrentPassword: "", parrentPhone: "", password: "", phone: "", stage: "", place: "", state: "", time: "",balance: "");
Assistant currentAssistant = Assistant(email: "", firstName: "", gender: "", lastName: "", password: "", phone: "", id: "", mr: false, nationalId: "");
// late FirebaseAssistant firebaseCurrentParrent; // needs class
late String firebaseAccountState;