
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinylearn_client/models/SessionInfo.dart';

const _sessionInfoKey = "sessionInfo";

class MiniStorage {
  
  SharedPreferences _sharedPreferences;

  Future<SharedPreferences> get _getSharedPreferences async {
    if (_sharedPreferences != null) return _sharedPreferences;
    final sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences = sharedPreferences;
    return _sharedPreferences;
  }

  Future<SessionInfo> get sessionInfo async {
    final sharedPreferences = await _getSharedPreferences;
    final json = sharedPreferences.getString(_sessionInfoKey);
    return json == null ? null : SessionInfo.fromJson(json);
  }

  Future<bool> setSessionInfo(SessionInfo value) async {
    final sharedPreferences = await _getSharedPreferences;
    return await sharedPreferences.setString(_sessionInfoKey, value?.toJson());
  }

  Future<String> get token async {
    return (await sessionInfo)?.token;
  }
}