import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource{
  Future<void>setUserId(String userId);
  Future<String> getUserId();
  Future<void> removeUserId();

}
class AuthLocalDataSourceImpl extends AuthLocalDataSource{
  final SharedPreferences sharedPreferences;
  static const String _userIdKey = "USER_ID";

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void>setUserId(String userId) {
    return sharedPreferences.setString(_userIdKey, userId);
  }

  @override
  Future<String> getUserId() async{
    return sharedPreferences.getString(_userIdKey) ?? "";
  }

  @override
  Future<void> removeUserId() {
    return sharedPreferences.remove(_userIdKey);
  }
}