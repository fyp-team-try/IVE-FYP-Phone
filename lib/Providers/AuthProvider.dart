import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:user_app/Models/UserInfo.dart';

class AuthProvider {
  FlutterSecureStorage storage;
  UserInfo? userinfo;

  AuthProvider(this.storage) {
    storage = storage;
    init();
  }

  Future<void> init() async {
    String? data = await storage.read(key: 'userInfo');
    if (data != null) {
      userinfo = UserInfo.deserialize(data);
    }
  }

  void setUserInfo(UserInfo userInfo) async {
    userinfo = userInfo;
    await storage.write(key: 'userInfo', value: UserInfo.serialize(userinfo!));
  }

  UserInfo getUserInfo() {
    return userinfo!;
  }

  Future<bool> isLogined() async {
    if (userinfo != null) {
      return true;
    }
    return false;
  }
}
