import 'package:shared_preferences/shared_preferences.dart';

class Language {
  int id;
  String language;
  String languageCode;

  Language({this.id, this.language, this.languageCode});

  static List<Language> getLangs() {
    return <Language>[
      Language(id: 1, language: "عربي", languageCode: "ar"),
      Language(id: 2, language: "English", languageCode: "en"),
    ];
  }
}

Future<void> saveLanguage(int langID) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('Language', langID);
}
