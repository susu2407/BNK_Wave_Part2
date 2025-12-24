/*
  날짜 : 2025-12-18
  내용 : card_basic 모델
  이름 : 박효빈.
*/
class CardBasic {
  final int cardId; //카드 상품의 고유 식별자
  final String cardName; // 카드명
  final String bankName; // 은행명
  final int annualFee;   // 연회비
  final String cardType;  // 카드 타입 (신용카드, 체크카드 ...)
  final String cardGrade; // 카드 등급 (일반, 플래티넘 , VIP ... )
  final int minPerformanceAmount; // 최소 전월 실적 금액
  final String cardImageUrl; // 카드 이미지 경로

  CardBasic({
    required this.cardId,
    required this.cardName,
    required this.bankName,
    required this.annualFee,
    required this.cardType,
    required this.cardGrade,
    required this.minPerformanceAmount,
    required this.cardImageUrl,
  });

  /// JSON → Dart 객체 변환 (Spring DTO 응답 파싱)
  factory CardBasic.fromJson(Map<String, dynamic> json) {
    return CardBasic(
      cardId: json['cardId'],
      cardName: json['cardName'],
      bankName: json['bankName'],
      annualFee: json['annualFee'],
      cardType: json['cardType'],
      cardGrade: json['cardGrade'],
      minPerformanceAmount: json['minPerformanceAmount'],
      cardImageUrl: json['cardImageUrl'],
    );
  }

  /// Dart 객체 → JSON (필요 시: POST / PUT)
  Map<String, dynamic> toJson() {
    return {
      'cardId': cardId,
      'cardName': cardName,
      'bankName': bankName,
      'annualFee': annualFee,
      'cardType': cardType,
      'cardGrade': cardGrade,
      'minPerformanceAmount': minPerformanceAmount,
      'cardImageUrl': cardImageUrl,
    };
  }
}
