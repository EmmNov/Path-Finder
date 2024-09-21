import 'package:shared_preferences/shared_preferences.dart';

class LocalDataClient {
  static const String _urlKey = 'urlKey';

  Future<void> saveUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_urlKey, url);
  }

  Future<String?> getUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_urlKey);
  }
}
