import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_storage/model/my_models.dart';

class SecureStorageService{
  late final FlutterSecureStorage preferences;

  void saveData(UserInformation userInformation) async{
    await preferences.write(key: 'name', value: userInformation.name);
    await preferences.write(key: 'student', value: userInformation.isStudent.toString());
    await preferences.write(key: 'gender', value: userInformation.gender.index.toString());
    await preferences.write(key: 'colors', value: jsonEncode(userInformation.colors));//Bu listeyi string formatına dönüştürerek secure içinde saklamayı sağlar.
  }

  Future<UserInformation> readData() async{
    const preferences = FlutterSecureStorage();
    var _name = await preferences.read(key: 'name') ?? '';

    var _studentString = await preferences.read(key: 'student') ?? 'false';//String olarak alıyoruz ve bool'a dönüştürme işlemi yapıyoruz.
    var _student = _studentString.toLowerCase() == 'true' ? true : false;

    var _genderString =await preferences.read(key: 'gender') ?? '0';//String olarak alıyoruz ve int'e dönüştürme işlemi yapıyoruz.
    var _gender = Gender.values[int.parse(_genderString)];

    var _colorsString = await preferences.read(key: 'colors');
    var _colors = _colorsString == null ? <String>[] : List<String>.from(jsonDecode(_colorsString));

    return UserInformation(_name, _gender, _colors, _student);
  }
}