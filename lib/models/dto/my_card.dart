/*
  날짜 : 2025-12-29
  내용 : my_card models 생성 (로그인 상태 관리) 앱 내에서 사용하기 쉽게 객체화(매핑)하는 데이터 모델 클래스입니다.
  이름 : 박효빈
*/

class MyCardModel {
  final String cardName;       // 카드 상품명 (예: AMEX Platinum)
  final String cardNumber;     // 마스킹 처리된 카드 번호 (뒷 4자리 활용)
  final String cardImageUrl;   // 카드 플레이트 이미지 경로
  final int totalUsageAmount;  // 이번 달 카드 사용 합계 금액

  MyCardModel({
    required this.cardName,
    required this.cardNumber,
    required this.cardImageUrl,
    required this.totalUsageAmount,
  });

  /// GET으로 정보를 받아오기에 JSON -> Dart 변환 필요 > 서버의 JSON 데이터를 Dart 객체로 변환하는 팩토리 생성자
  factory MyCardModel.fromJson(Map<String, dynamic> json) {
    return MyCardModel(
      cardName: json['cardName'] ?? '이름 없음',
      cardNumber: json['cardNumber'],
      cardImageUrl: json['cardImageUrl'] ?? '',
      totalUsageAmount: json['totalUsageAmount'] ?? 0,
    );
  }
}