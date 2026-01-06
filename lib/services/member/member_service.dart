/*
  날짜 : 2025-12-29
  이름 : 고정현
  내용 : 회원 서비스

  날짜 : 2026-01-05
  이름 : 이수연
  내용 : 목업으로 로그인 가능하도록 변경
 */

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/entity/member.dart';

class MemberService {

  final String baseUrl = "http://10.0.2.2:8080/ch09";

  // [수정] 실제 서버 통신 대신, 목업(mock-up) 데이터를 반환하도록 변경
  Future<Map<String, dynamic>> login(String usid, String pass) async {
    // 1초간 일부러 지연시켜 실제 네트워크 통신처럼 보이게 함
    await Future.delayed(const Duration(seconds: 1));

    print('Mock login successful for: $usid');

    // 로그인 성공 시, 가짜 액세스 토큰을 포함한 Map을 반환
    return {
      'accessToken': 'fake-token-for-$usid',
    };
  }

  Future<Map<String, dynamic>> register(Member member) async {
    try {
      final response = await http.post(
          Uri.parse('$baseUrl/user/register'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(member.toJson())
      );

      if(response.statusCode == 200){
        // savedUser 반환
        return jsonDecode(response.body);

      } else {
        throw Exception('statusCode : ${response.statusCode}');
      }
    }catch (err){
      throw Exception('에러발생 : $err');
    }
  }

  Future<String> findId(String name, String email) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/member/find-id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['loginId'];
    } else {
      throw Exception('아이디를 찾을 수 없습니다.');
    }
  }

}
