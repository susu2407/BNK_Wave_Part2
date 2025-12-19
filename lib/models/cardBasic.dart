class CardBasic {
  final int cardId;               // 1. 카드 식별자 (PK)
  final String cardName;          // 2. 카드 상품 명
  final String bankName;          // 3. 발급 은행명
  final int annualFee;            // 4. 연회비 금액
  final String cardType;          // 5. 카드 타입 (신용, 체크)
  final String cardGrade;         // 6. 카드 등급 (일반, 플래티넘...)
  final int? minPerformanceAmount; // 7. 전월 실적 조건 (Null 허용)
  final String cardImageUrl;      // 8. 상품 이미지 URL

  CardBasic({
    required this.cardId,
    required this.cardName,
    required this.bankName,
    required this.annualFee,
    required this.cardType,
    required this.cardGrade,
    this.minPerformanceAmount, // Null 허용이므로 required 제외
    required this.cardImageUrl,
  });

  // DB(Map) 또는 JSON 데이터를 객체로 변환하는 생성자
  factory CardBasic.fromMap(Map<String, dynamic> map) {
    return CardBasic(
      cardId: map['CARD_ID'] as int,
      cardName: map['CARD_NAME'] as String,
      bankName: map['BANK_NAME'] as String,
      annualFee: map['ANNUAL_FEE'] as int,
      cardType: map['CARD_TYPE'] as String,
      cardGrade: map['CARD_GRADE'] as String,
      minPerformanceAmount: map['MIN_PERFORMANCE_AMOUNT'] as int?,
      cardImageUrl: map['CARD_IMAGE_URL'] as String,
    );
  }
}