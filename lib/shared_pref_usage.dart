import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/secure_storage.dart';
import 'package:flutter_storage/services/shared_pref_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUsage extends StatefulWidget {
  const SharedPreferenceUsage({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceUsage> createState() => _SharedPreferenceUsageState();
}

class _SharedPreferenceUsageState extends State<SharedPreferenceUsage> {
  var _selectedGender = Gender.Kadin;
  var _selectedColors = <String>[];
  var _isStudent = false;
  final TextEditingController _nameController = TextEditingController();
 // var _preferenceService = SharedPreferenceService();
  final _preferenceService = SecureStorageService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreference Kullanımı'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Adınızı Giriniz'),
            ),
          ),
          for (var item in Gender.values)
            _buildRadioListTiles(describeEnum(item), item),
          for (var item in MyColors.values) _buildChechkboxListTiles(item),
          //Enum değerlerini tek tek gezerek yazdırır.

          SwitchListTile(
              title: const Text('Öğrenci misin?'),
              value: _isStudent,
              onChanged: (bool isStudent) {
                setState(() {
                  _isStudent = isStudent;
                });
              }),
          TextButton(
              onPressed: () {
                _preferenceService.saveData(UserInformation(
                    _nameController.text,
                    _selectedGender,
                    _selectedColors,
                    _isStudent));
              },
              child: const Text('Kaydet'))
        ],
      ),
    );
  }

  Widget _buildChechkboxListTiles(MyColors color) {
    return CheckboxListTile(
        title: Text(describeEnum(color)),
        value: _selectedColors.contains(describeEnum(color)),
        onChanged: (bool? value) {
          if (value == false) {
            _selectedColors.remove(describeEnum(color));
          } else {
            _selectedColors.add(describeEnum(color));
          }
          setState(() {
            debugPrint(_selectedColors.toString());
          });
        });
  }

  Widget _buildRadioListTiles(String title, Gender gender) {
    return RadioListTile(
        title: Text(title),
        value: gender,
        groupValue: _selectedGender,
        onChanged: (Gender? selectedGender) {
          setState(() {
            _selectedGender = selectedGender!;
          });
        });
  }

  void readData() async {
    var info = await _preferenceService.readData();
    _nameController.text = info.name;
    _selectedGender = info.gender;
    _selectedColors = info.colors;
    _isStudent = info.isStudent;

    setState(() {

    });
  }
}
