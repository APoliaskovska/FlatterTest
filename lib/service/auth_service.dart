import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class _SecItem {
  _SecItem(this.key, this.value);
  final String key;
  final String value;
}

abstract class AuthServicesKeys {
  static const TOKEN = 'token';
  static const PASSCODE = 'passcode';
}

class AuthService extends GetxService {
  static final AuthService _instance = new AuthService._internal();
  final _storage = const FlutterSecureStorage();
  List<_SecItem> _items = [];

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  //Public

  Future<bool> isPasscodeExist() async {
    return _readSecureItem(AuthServicesKeys.PASSCODE) != null;
  }

  Future<void> setPasscode(String passcode) async {
    _addNewItem(AuthServicesKeys.PASSCODE, passcode);
    await _readAll();
  }

  Future<bool> isPasscodeValid(String passcode) async {
    return _readSecureItem(AuthServicesKeys.PASSCODE) == passcode;
  }

  Future<String?> getToken() async {
    return await _readSecureItem(AuthServicesKeys.TOKEN);
  }

  Future<void> setToken(String newToken) async {
    _addNewItem(AuthServicesKeys.TOKEN, newToken);
    _readAll();
  }

  //Private

  void _addNewItem(String key, String value) async {
    await _storage.write(
        key: key,
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
    _readAll();
  }

  Future<dynamic> _readSecureItem(String key) async {
    await _readAll();
    var item = _items.where((element) => element.key == key);
    if (item.isEmpty) {
      return null;
    } else {
      return item.first.value;
    }
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