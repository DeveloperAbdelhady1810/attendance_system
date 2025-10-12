// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `No Data`
  String get nodata {
    return Intl.message('No Data', name: 'nodata', desc: '', args: []);
  }

  /// `Blocked Student!`
  String get blocked {
    return Intl.message(
      'Blocked Student!',
      name: 'blocked',
      desc: '',
      args: [],
    );
  }

  /// `This user has been blocked by the admin!`
  String get blockedSentence {
    return Intl.message(
      'This user has been blocked by the admin!',
      name: 'blockedSentence',
      desc: '',
      args: [],
    );
  }

  /// `Add To Normal Attendants`
  String get add2attendants {
    return Intl.message(
      'Add To Normal Attendants',
      name: 'add2attendants',
      desc: '',
      args: [],
    );
  }

  /// `Parrent Phone : {parrentphone}`
  String parrentphone(Object parrentphone) {
    return Intl.message(
      'Parrent Phone : $parrentphone',
      name: 'parrentphone',
      desc: '',
      args: [parrentphone],
    );
  }

  /// `Block From Attend`
  String get blockedFromAttend {
    return Intl.message(
      'Block From Attend',
      name: 'blockedFromAttend',
      desc: '',
      args: [],
    );
  }

  /// `Email :`
  String get email {
    return Intl.message('Email :', name: 'email', desc: '', args: []);
  }

  /// `Phone :`
  String get phone {
    return Intl.message('Phone :', name: 'phone', desc: '', args: []);
  }

  /// `ID :`
  String get id {
    return Intl.message('ID :', name: 'id', desc: '', args: []);
  }

  /// `Gender :`
  String get gender {
    return Intl.message('Gender :', name: 'gender', desc: '', args: []);
  }

  /// `Password :`
  String get password {
    return Intl.message('Password :', name: 'password', desc: '', args: []);
  }

  /// `Parrent Phone :`
  String get parrentphonetitle {
    return Intl.message(
      'Parrent Phone :',
      name: 'parrentphonetitle',
      desc: '',
      args: [],
    );
  }

  /// `Parrent Email :`
  String get parrentemail {
    return Intl.message(
      'Parrent Email :',
      name: 'parrentemail',
      desc: '',
      args: [],
    );
  }

  /// `Parrent Password :`
  String get parrentpassword {
    return Intl.message(
      'Parrent Password :',
      name: 'parrentpassword',
      desc: '',
      args: [],
    );
  }

  /// `Center :`
  String get center {
    return Intl.message('Center :', name: 'center', desc: '', args: []);
  }

  /// `Time :`
  String get time {
    return Intl.message('Time :', name: 'time', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Export To Excel Sheet`
  String get export2excell {
    return Intl.message(
      'Export To Excel Sheet',
      name: 'export2excell',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Failed`
  String get failed {
    return Intl.message('Failed', name: 'failed', desc: '', args: []);
  }

  /// `Welcome to Student Register Page`
  String get welcomeRegisterSentence {
    return Intl.message(
      'Welcome to Student Register Page',
      name: 'welcomeRegisterSentence',
      desc: '',
      args: [],
    );
  }

  /// `Select Student Stage`
  String get selectStage {
    return Intl.message(
      'Select Student Stage',
      name: 'selectStage',
      desc: '',
      args: [],
    );
  }

  /// `First Secondry`
  String get firstsec {
    return Intl.message('First Secondry', name: 'firstsec', desc: '', args: []);
  }

  /// `Second Secondry`
  String get secondsec {
    return Intl.message(
      'Second Secondry',
      name: 'secondsec',
      desc: '',
      args: [],
    );
  }

  /// `Third Secondry`
  String get thirdsec {
    return Intl.message('Third Secondry', name: 'thirdsec', desc: '', args: []);
  }

  /// `Third Prep`
  String get thirdprep {
    return Intl.message('Third Prep', name: 'thirdprep', desc: '', args: []);
  }

  /// `Request was successful Student Id : {stdid}`
  String successRegisterSentence(Object stdid) {
    return Intl.message(
      'Request was successful Student Id : $stdid',
      name: 'successRegisterSentence',
      desc: '',
      args: [stdid],
    );
  }

  /// `Request was failed {message}`
  String failedRegisterSentence(Object message) {
    return Intl.message(
      'Request was failed $message',
      name: 'failedRegisterSentence',
      desc: '',
      args: [message],
    );
  }

  /// `Fill Student Parrent Phone`
  String get fillpp {
    return Intl.message(
      'Fill Student Parrent Phone',
      name: 'fillpp',
      desc: '',
      args: [],
    );
  }

  /// `Fill Student Parrent Email`
  String get fillpe {
    return Intl.message(
      'Fill Student Parrent Email',
      name: 'fillpe',
      desc: '',
      args: [],
    );
  }

  /// `Fill Student Email`
  String get fillemail {
    return Intl.message(
      'Fill Student Email',
      name: 'fillemail',
      desc: '',
      args: [],
    );
  }

  /// `Fill Student Phone`
  String get fillphone {
    return Intl.message(
      'Fill Student Phone',
      name: 'fillphone',
      desc: '',
      args: [],
    );
  }

  /// `Fill Student Firstname`
  String get fill1name {
    return Intl.message(
      'Fill Student Firstname',
      name: 'fill1name',
      desc: '',
      args: [],
    );
  }

  /// `Fill Student Secondname`
  String get fill2name {
    return Intl.message(
      'Fill Student Secondname',
      name: 'fill2name',
      desc: '',
      args: [],
    );
  }

  /// `Create Student Account`
  String get createAcc {
    return Intl.message(
      'Create Student Account',
      name: 'createAcc',
      desc: '',
      args: [],
    );
  }

  /// `Add Student`
  String get addStd {
    return Intl.message('Add Student', name: 'addStd', desc: '', args: []);
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Select Branch`
  String get selectBranch {
    return Intl.message(
      'Select Branch',
      name: 'selectBranch',
      desc: '',
      args: [],
    );
  }

  /// `Create Online Codes`
  String get createCodes {
    return Intl.message(
      'Create Online Codes',
      name: 'createCodes',
      desc: '',
      args: [],
    );
  }

  /// `Enter How Many Codes`
  String get enterhowmanycodes {
    return Intl.message(
      'Enter How Many Codes',
      name: 'enterhowmanycodes',
      desc: '',
      args: [],
    );
  }

  /// `Enter Quiz Ful Mark!!!`
  String get quizfullmark {
    return Intl.message(
      'Enter Quiz Ful Mark!!!',
      name: 'quizfullmark',
      desc: '',
      args: [],
    );
  }

  /// `Student Id: {id}`
  String stdid(Object id) {
    return Intl.message('Student Id: $id', name: 'stdid', desc: '', args: [id]);
  }

  /// `Submitted`
  String get submitted {
    return Intl.message('Submitted', name: 'submitted', desc: '', args: []);
  }

  /// `Mark: {mark}`
  String mark(Object mark) {
    return Intl.message('Mark: $mark', name: 'mark', desc: '', args: [mark]);
  }

  /// `Getting Attendants`
  String get gettingattendants {
    return Intl.message(
      'Getting Attendants',
      name: 'gettingattendants',
      desc: '',
      args: [],
    );
  }

  /// `Got Attendants`
  String get gotattendants {
    return Intl.message(
      'Got Attendants',
      name: 'gotattendants',
      desc: '',
      args: [],
    );
  }

  /// `Getting Quiz Id`
  String get gettingquizid {
    return Intl.message(
      'Getting Quiz Id',
      name: 'gettingquizid',
      desc: '',
      args: [],
    );
  }

  /// `Got Quiz Id`
  String get gotid {
    return Intl.message('Got Quiz Id', name: 'gotid', desc: '', args: []);
  }

  /// `Arranging Quiz Marks`
  String get arrangingquizmarks {
    return Intl.message(
      'Arranging Quiz Marks',
      name: 'arrangingquizmarks',
      desc: '',
      args: [],
    );
  }

  /// `Got Quiz Marks`
  String get gotmarks {
    return Intl.message('Got Quiz Marks', name: 'gotmarks', desc: '', args: []);
  }

  /// `Sending Attendants To Server`
  String get sendattendants {
    return Intl.message(
      'Sending Attendants To Server',
      name: 'sendattendants',
      desc: '',
      args: [],
    );
  }

  /// `Sent Attendants`
  String get sent {
    return Intl.message('Sent Attendants', name: 'sent', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Go To Whatsapp Center`
  String get gotowhatsappcenter {
    return Intl.message(
      'Go To Whatsapp Center',
      name: 'gotowhatsappcenter',
      desc: '',
      args: [],
    );
  }

  /// `Marks Sent`
  String get markssent {
    return Intl.message('Marks Sent', name: 'markssent', desc: '', args: []);
  }

  /// `Whatsapp Center`
  String get whatsappcenter {
    return Intl.message(
      'Whatsapp Center',
      name: 'whatsappcenter',
      desc: '',
      args: [],
    );
  }

  /// `Process Status ...`
  String get processStatus {
    return Intl.message(
      'Process Status ...',
      name: 'processStatus',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
  }

  /// `Offline`
  String get offline {
    return Intl.message('Offline', name: 'offline', desc: '', args: []);
  }

  /// `Online`
  String get online {
    return Intl.message('Online', name: 'online', desc: '', args: []);
  }

  /// `You Are Working in {branch}`
  String youareworkingin(Object branch) {
    return Intl.message(
      'You Are Working in $branch',
      name: 'youareworkingin',
      desc: '',
      args: [branch],
    );
  }

  /// `Submit This Session`
  String get submitThisSession {
    return Intl.message(
      'Submit This Session',
      name: 'submitThisSession',
      desc: '',
      args: [],
    );
  }

  /// `Add Students Manually`
  String get addStudentsManually {
    return Intl.message(
      'Add Students Manually',
      name: 'addStudentsManually',
      desc: '',
      args: [],
    );
  }

  /// `Expected To Attend ( {number} )`
  String expectedToAttend(Object number) {
    return Intl.message(
      'Expected To Attend ( $number )',
      name: 'expectedToAttend',
      desc: '',
      args: [number],
    );
  }

  /// `Attended Offline ( {number} )`
  String attendants(Object number) {
    return Intl.message(
      'Attended Offline ( $number )',
      name: 'attendants',
      desc: '',
      args: [number],
    );
  }

  /// `Attended Online ( {number} )`
  String attendantsonline(Object number) {
    return Intl.message(
      'Attended Online ( $number )',
      name: 'attendantsonline',
      desc: '',
      args: [number],
    );
  }

  /// `Marks Mode`
  String get marksMode {
    return Intl.message('Marks Mode', name: 'marksMode', desc: '', args: []);
  }

  /// `Type Anything of student data`
  String get typeanythingofstddata {
    return Intl.message(
      'Type Anything of student data',
      name: 'typeanythingofstddata',
      desc: '',
      args: [],
    );
  }

  /// `Quiz Full Mark`
  String get quizfullmark2 {
    return Intl.message(
      'Quiz Full Mark',
      name: 'quizfullmark2',
      desc: '',
      args: [],
    );
  }

  /// `Student Data`
  String get studentData {
    return Intl.message(
      'Student Data',
      name: 'studentData',
      desc: '',
      args: [],
    );
  }

  /// `{studentid}'s Mark`
  String stdMark(Object studentid) {
    return Intl.message(
      '$studentid`s Mark',
      name: 'stdMark',
      desc: '',
      args: [studentid],
    );
  }

  /// `Press Start`
  String get pressStart {
    return Intl.message('Press Start', name: 'pressStart', desc: '', args: []);
  }

  /// `Whatsapp Bot Ready To Go`
  String get whatsappBotReady {
    return Intl.message(
      'Whatsapp Bot Ready To Go',
      name: 'whatsappBotReady',
      desc: '',
      args: [],
    );
  }

  /// `Error in Preparing Whatsapp Bot`
  String get errorInPreparingWhatsappBot {
    return Intl.message(
      'Error in Preparing Whatsapp Bot',
      name: 'errorInPreparingWhatsappBot',
      desc: '',
      args: [],
    );
  }

  /// `Code :`
  String get code {
    return Intl.message('Code :', name: 'code', desc: '', args: []);
  }

  /// `Failed To Export Data To Excel Sheet`
  String get failedToExport {
    return Intl.message(
      'Failed To Export Data To Excel Sheet',
      name: 'failedToExport',
      desc: '',
      args: [],
    );
  }

  /// `Exit Without Saving`
  String get exitWithoutSaving {
    return Intl.message(
      'Exit Without Saving',
      name: 'exitWithoutSaving',
      desc: '',
      args: [],
    );
  }

  /// `Enter Code Price`
  String get entercodesprice {
    return Intl.message(
      'Enter Code Price',
      name: 'entercodesprice',
      desc: '',
      args: [],
    );
  }

  /// `Export all Students`
  String get getStds {
    return Intl.message(
      'Export all Students',
      name: 'getStds',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar', countryCode: 'SU'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
