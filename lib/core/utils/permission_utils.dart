import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }
}
