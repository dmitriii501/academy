// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _scoreList = prefs.getString('ff_scoreList') ?? _scoreList;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _studentcont = false;
  bool get studentcont => _studentcont;
  set studentcont(bool value) {
    _studentcont = value;
  }

  bool _teachercont = false;
  bool get teachercont => _teachercont;
  set teachercont(bool value) {
    _teachercont = value;
  }

  String _namesubject = '';
  String get namesubject => _namesubject;
  set namesubject(String value) {
    _namesubject = value;
  }

  String _exam = '';
  String get exam => _exam;
  set exam(String value) {
    _exam = value;
  }

  String _teachersname = '';
  String get teachersname => _teachersname;
  set teachersname(String value) {
    _teachersname = value;
  }

  List<int> _totalvisitlecture = [];
  List<int> get totalvisitlecture => _totalvisitlecture;
  set totalvisitlecture(List<int> value) {
    _totalvisitlecture = value;
  }

  void addToTotalvisitlecture(int value) {
    totalvisitlecture.add(value);
  }

  void removeFromTotalvisitlecture(int value) {
    totalvisitlecture.remove(value);
  }

  void removeAtIndexFromTotalvisitlecture(int index) {
    totalvisitlecture.removeAt(index);
  }

  void updateTotalvisitlectureAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    totalvisitlecture[index] = updateFn(_totalvisitlecture[index]);
  }

  void insertAtIndexInTotalvisitlecture(int index, int value) {
    totalvisitlecture.insert(index, value);
  }

  List<int> _totalvisitseminar = [];
  List<int> get totalvisitseminar => _totalvisitseminar;
  set totalvisitseminar(List<int> value) {
    _totalvisitseminar = value;
  }

  void addToTotalvisitseminar(int value) {
    totalvisitseminar.add(value);
  }

  void removeFromTotalvisitseminar(int value) {
    totalvisitseminar.remove(value);
  }

  void removeAtIndexFromTotalvisitseminar(int index) {
    totalvisitseminar.removeAt(index);
  }

  void updateTotalvisitseminarAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    totalvisitseminar[index] = updateFn(_totalvisitseminar[index]);
  }

  void insertAtIndexInTotalvisitseminar(int index, int value) {
    totalvisitseminar.insert(index, value);
  }

  int _hours = 0;
  int get hours => _hours;
  set hours(int value) {
    _hours = value;
  }

  int _numberoflectures = 0;
  int get numberoflectures => _numberoflectures;
  set numberoflectures(int value) {
    _numberoflectures = value;
  }

  int _numberofseminars = 0;
  int get numberofseminars => _numberofseminars;
  set numberofseminars(int value) {
    _numberofseminars = value;
  }

  bool _searchdevelopment = false;
  bool get searchdevelopment => _searchdevelopment;
  set searchdevelopment(bool value) {
    _searchdevelopment = value;
  }

  bool _searchFilm = false;
  bool get searchFilm => _searchFilm;
  set searchFilm(bool value) {
    _searchFilm = value;
  }

  bool _searchBook = false;
  bool get searchBook => _searchBook;
  set searchBook(bool value) {
    _searchBook = value;
  }

  /// Список введённых оценок
  String _scoreList = '';
  String get scoreList => _scoreList;
  set scoreList(String value) {
    _scoreList = value;
    prefs.setString('ff_scoreList', value);
  }

  bool _isDatePicked = false;
  bool get isDatePicked => _isDatePicked;
  set isDatePicked(bool value) {
    _isDatePicked = value;
  }

  bool _isDatePickedTeacher = false;
  bool get isDatePickedTeacher => _isDatePickedTeacher;
  set isDatePickedTeacher(bool value) {
    _isDatePickedTeacher = value;
  }

  List<bool> _groups = [];
  List<bool> get groups => _groups;
  set groups(List<bool> value) {
    _groups = value;
  }

  void addToGroups(bool value) {
    groups.add(value);
  }

  void removeFromGroups(bool value) {
    groups.remove(value);
  }

  void removeAtIndexFromGroups(int index) {
    groups.removeAt(index);
  }

  void updateGroupsAtIndex(
    int index,
    bool Function(bool) updateFn,
  ) {
    groups[index] = updateFn(_groups[index]);
  }

  void insertAtIndexInGroups(int index, bool value) {
    groups.insert(index, value);
  }

  List<bool> _subject = [];
  List<bool> get subject => _subject;
  set subject(List<bool> value) {
    _subject = value;
  }

  void addToSubject(bool value) {
    subject.add(value);
  }

  void removeFromSubject(bool value) {
    subject.remove(value);
  }

  void removeAtIndexFromSubject(int index) {
    subject.removeAt(index);
  }

  void updateSubjectAtIndex(
    int index,
    bool Function(bool) updateFn,
  ) {
    subject[index] = updateFn(_subject[index]);
  }

  void insertAtIndexInSubject(int index, bool value) {
    subject.insert(index, value);
  }

  List<bool> _work = [];
  List<bool> get work => _work;
  set work(List<bool> value) {
    _work = value;
  }

  void addToWork(bool value) {
    work.add(value);
  }

  void removeFromWork(bool value) {
    work.remove(value);
  }

  void removeAtIndexFromWork(int index) {
    work.removeAt(index);
  }

  void updateWorkAtIndex(
    int index,
    bool Function(bool) updateFn,
  ) {
    work[index] = updateFn(_work[index]);
  }

  void insertAtIndexInWork(int index, bool value) {
    work.insert(index, value);
  }

  List<String> _studentgrades = ['name', 'grade1'];
  List<String> get studentgrades => _studentgrades;
  set studentgrades(List<String> value) {
    _studentgrades = value;
  }

  void addToStudentgrades(String value) {
    studentgrades.add(value);
  }

  void removeFromStudentgrades(String value) {
    studentgrades.remove(value);
  }

  void removeAtIndexFromStudentgrades(int index) {
    studentgrades.removeAt(index);
  }

  void updateStudentgradesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    studentgrades[index] = updateFn(_studentgrades[index]);
  }

  void insertAtIndexInStudentgrades(int index, String value) {
    studentgrades.insert(index, value);
  }

  String _bonusPoints = '';
  String get bonusPoints => _bonusPoints;
  set bonusPoints(String value) {
    _bonusPoints = value;
  }

  List<FilterStruct> _filter = [
    FilterStruct.fromSerializableMap(jsonDecode('{\"name\":\"groups\"}')),
    FilterStruct.fromSerializableMap(jsonDecode('{\"name\":\"subjects\"}')),
    FilterStruct.fromSerializableMap(jsonDecode('{\"name\":\"work\"}'))
  ];
  List<FilterStruct> get filter => _filter;
  set filter(List<FilterStruct> value) {
    _filter = value;
  }

  void addToFilter(FilterStruct value) {
    filter.add(value);
  }

  void removeFromFilter(FilterStruct value) {
    filter.remove(value);
  }

  void removeAtIndexFromFilter(int index) {
    filter.removeAt(index);
  }

  void updateFilterAtIndex(
    int index,
    FilterStruct Function(FilterStruct) updateFn,
  ) {
    filter[index] = updateFn(_filter[index]);
  }

  void insertAtIndexInFilter(int index, FilterStruct value) {
    filter.insert(index, value);
  }

  bool _isGenerated = false;
  bool get isGenerated => _isGenerated;
  set isGenerated(bool value) {
    _isGenerated = value;
  }

  List<int> _filterForTeacher = [];
  List<int> get filterForTeacher => _filterForTeacher;
  set filterForTeacher(List<int> value) {
    _filterForTeacher = value;
  }

  void addToFilterForTeacher(int value) {
    filterForTeacher.add(value);
  }

  void removeFromFilterForTeacher(int value) {
    filterForTeacher.remove(value);
  }

  void removeAtIndexFromFilterForTeacher(int index) {
    filterForTeacher.removeAt(index);
  }

  void updateFilterForTeacherAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    filterForTeacher[index] = updateFn(_filterForTeacher[index]);
  }

  void insertAtIndexInFilterForTeacher(int index, int value) {
    filterForTeacher.insert(index, value);
  }

  /// true
  bool _isAscending = false;
  bool get isAscending => _isAscending;
  set isAscending(bool value) {
    _isAscending = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

