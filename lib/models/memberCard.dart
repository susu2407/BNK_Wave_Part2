class MemberCard {
  final int memberCardId;
  final String cardNumber;    // 마스킹된 번호 (VARCHAR2)
  final String paymentBank;   // 결제 은행
  final String paymentAccount; // 결제 계좌
  final String cardStatus;    // 카드 상태 (정상 여부 판단)

  MemberCard({
    required this.memberCardId,
    required this.cardNumber,
    required this.paymentBank,
    required this.paymentAccount,
    required this.cardStatus,
  });

  // DB 데이터를 객체로 변환하는 factory 메서드 (일종의 통역사)
  factory MemberCard.fromMap(Map<String, dynamic> map) {
    return MemberCard(
      memberCardId: map['MEMBER_CARD_ID'],
      cardNumber: map['CARD_NUMBER'],
      paymentBank: map['PAYMENT_BANK'] ?? '은행 정보 없음',
      paymentAccount: map['PAYMENT_ACCOUNT'] ?? '',
      cardStatus: map['CARD_STATUS'],
    );
  }
}