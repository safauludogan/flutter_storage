import 'package:flutter_storage/model/my_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService{
  void saveData(UserInformation userInformation) async{
    final name = userInformation.name;
    final preferences = await SharedPreferences.getInstance();

    preferences.setString('name', name);
    preferences.setBool('student', userInformation.isStudent);
    preferences.setInt('gender', userInformation.gender.index);
    preferences.setStringList("colors", userInformation.colors);
  }

  Future<UserInformation> readData() async{
    final preferences = await SharedPreferences.getInstance();
    var _name = preferences.getString('name') ?? '';
    var _student = preferences.getBool('student') ?? false;
    var _gender = Gender.values[preferences.getInt('gender') ?? 0];
    var _colors = preferences.getStringList('colors') ?? [];

    return UserInformation(_name, _gender, _colors, _student);
  }
}