import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthRepo extends GetxService {
  AuthRepo();

  final _storage = const FlutterSecureStorage();
  List<_SecItem> _items = [];

  //public

  Future<String?> getToken() async {
    await _readAll();
    var item = _items.where((element) => element.key == 'token');
    if (item.isEmpty) {
      return null;
    } else {
      return item.first.value;
    }
  }

  Future<void> setToken(String newToken) async {
    _addNewItem("token", newToken);
    _readAll();
  }

  // private

  void _addNewItem(String key, String value) async {
    await _storage.write(
        key: key,
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
    _readAll();
  }

  Future<void> _readAll() async {
    final all = await _storage.readAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    _items = all.entries
        .map((entry) => _SecItem(entry.key, entry.value))
        .toList(growable: false);
  }

  IOSOptions _getIOSOptions() => IOSOptions(
    accountName: _getId().toString(),
  );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  Future<String?> _getId() async {
    return "12345";
    // var deviceInfo = DeviceInfoPlugin();
    // if (Platform.isIOS) {
    //   var iosDeviceInfo = await deviceInfo.iosInfo;
    //   return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    // } else if(Platform.isAndroid) {
    //   var androidDeviceInfo = await deviceInfo.androidInfo;
    //   return androidDeviceInfo.androidId; // unique ID on Android
    // }
  }
}

class _SecItem {
  _SecItem(this.key, this.value);
  final String key;
  final String value;
}