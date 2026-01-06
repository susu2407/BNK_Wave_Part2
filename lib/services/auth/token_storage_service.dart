/*
  날짜 : 2025-12-29
  이름 : 박효빈
  내용 : 토큰 저장소 서비스
 */

// token 저장소 서비스 생성

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {

  // JWT 저장소
  final _tokenStorage = const FlutterSecureStorage();

  // 토큰 _accessTokenKey 정의
  static const _accessTokenKey = 'accessToken';

  Future<void> saveToken(String token) async{
   await _tokenStorage.write(key: _accessTokenKey, value: token);

  }

  Future<void> deleteToken() async{
    await _tokenStorage.delete(key: _accessTokenKey);

  }

  Future<String?> readToken() async{
    return await _tokenStorage.read(key: _accessTokenKey);

  }
}