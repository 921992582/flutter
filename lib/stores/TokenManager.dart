import 'package:flutter_test_project/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  // 初始化token
  Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  String _token = '';

  Future<void> init() async {
    // 获取持久化实例
    final prefs = await _getInstance();
    // 检查是否存在token
    _token = prefs.getString(GlobalConstants.tokenKey) ?? '';
  }

  // 设置token
  Future<void> setToken(String token) async {
    // 获取持久化实例
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.tokenKey, token); // token写入到持久化
    _token = token;
  }

  // 获取token
  String getToken() {
    return _token;
  }

  // 移除token
  Future<void> removeToken() async {
    // 获取持久化实例
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.tokenKey); // 移除token
    _token = '';
  }
}

final tokenManager = TokenManager();
