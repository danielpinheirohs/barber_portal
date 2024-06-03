import 'package:barber_portal/core/model/web_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebUserCache {
  static const String _webUserKey = 'web_user';

  Future<void> saveWebUser(WebUser webUser) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_webUserKey, webUser.toJson());
  }

  Future<WebUser?> getWebUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_webUserKey);
    if (jsonString != null) {
      return WebUser.fromJson(jsonString);
    }
    return null;
  }

  Future<void> clearWebUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_webUserKey);
  }
}
