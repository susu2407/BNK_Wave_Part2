/*
  날짜 : 2025-12-18
  내용 : card_benefit 모델
  이름 : 박효빈.
*/

class CardBenefit {
  final int benefitId;          // 혜택 일련번호 (PK): 혜택 항목의 고유 식별자
  final int cardId;             // 카드 식별자 (FK): TB_CARD_BASIC 테이블 연결 키

  final String benefitCategory;   // 혜택 카테고리 명 (예: 교통, 외식, 여가)
  final String benefitName;       // 혜택 항목 명: 구체적인 혜택 내용 (예: 대중교통 할인 10%)
  final String? applicableCategory; // 혜택 대상 업종 명 (Null 허용): 적용 업종 (예: 카페, 편의점)

  final String benefitType;       // 혜택 유형: 서비스 형태 (예: 할인, 적립, 캐시백)
  final double? benefitRate;      // 혜택 비율 값 (Null 허용): 할인율 또는 적립률 (예: 0.10)
  final int? monthlyLimit;        // 월 최대 한도 금액 (Null 허용): 해당 혜택의 월간 사용 한도

  CardBenefit({
    required this.benefitId,
    required this.cardId,
    required this.benefitCategory,
    required this.benefitName,
    this.applicableCategory, // 명세서 Null 허용(Y)에 따라 String? 타입 및 필수 해제
    required this.benefitType,
    this.benefitRate,        // 명세서 Null 허용(Y)
    this.monthlyLimit,       // 명세서 Null 허용(Y)
  });

  /// 서버 JSON 데이터를 Dart 객체로 변환 (Spring DTO 응답 파싱)
  factory CardBenefit.fromJson(Map<String, dynamic> json) {
    return CardBenefit(
      benefitId: json['benefitId'],
      cardId: json['cardId'],
      benefitCategory: json['benefitCategory'],
      benefitName: json['benefitName'],
      applicableCategory: json['applicableCategory'],
      benefitType: json['benefitType'],
      // NUMBER(5,4) 타입을 double로 안전하게 변환
      benefitRate: json['benefitRate']?.toDouble(),
      monthlyLimit: json['monthlyLimit'],
    );
  }

  /// Dart 객체를 서버 전송용 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'benefitId': benefitId,
      'cardId': cardId,
      'benefitCategory': benefitCategory,
      'benefitName': benefitName,
      'applicableCategory': applicableCategory,
      'benefitType': benefitType,
      'benefitRate': benefitRate,
      'monthlyLimit': monthlyLimit,
    };
  }
}