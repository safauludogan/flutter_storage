// ignore_for_file: constant_identifier_names
enum Gender{
  Kadin,
  Erkek,
  Diger
}

enum MyColors{
  Sari,
  Kirmizi,
  Yesil,
  Gri
}

class UserInformation{
  final String name;
  final Gender gender;
  final List<String> colors;
  final bool isStudent;

  UserInformation(this.name, this.gender, this.colors, this.isStudent);
}