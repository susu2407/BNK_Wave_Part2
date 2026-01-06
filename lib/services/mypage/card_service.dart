import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bnkpart2/models/dto/my_card.dart';

/*
  날짜 : 2025-01-05
  내용 : mypage/card_service 생성
  이름 : 박효빈
*/
class CardService {
  // 에뮬레이터 기준 로컬 PC 주소 (공용 DB여도 서버가 내 PC에서 돌고 있다면 이 주소)
  static const String baseUrl = "http://10.0.2.2:8080/api/cards";

  Future<MyCardModel> getMyPageData(int memberId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/mypage/$memberId'));

      if (response.statusCode == 200) {
        // 한글 깨짐 방지를 위해 utf8 디코딩 후 JSON 파싱
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return MyCardModel.fromJson(data);
      } else {
        throw Exception("서버 응답 에러: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("데이터 통신 중 오류 발생: $e");
    }
  }
}