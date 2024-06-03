import 'package:barber_portal/core/model/barber.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarberCache {
  static const String _barberKey = 'barber';

  Future<void> saveBarber(Barber barber) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_barberKey, barber.toJson());
  }

  Future<Barber?> getBarber() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_barberKey);
    if (jsonString != null) {
      return Barber.fromJson(jsonString);
    }
    return null;
  }

  Future<void> clearBarber() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_barberKey);
  }
}
