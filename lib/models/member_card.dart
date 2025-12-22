/*
  날짜 : 2025-12-18
  내용 : member_card 모델
  이름 : 박효빈.
*/
class MemberCard {
  final int memberCardId;      // 사용자 카드 식별자 (PK): 보유 카드 고유 ID
  final int memberId;          // 사용자 식별자 (FK: TB_MEMBER 연결 키)
  final int cardId;            // 카드 식별자 (FK: TB_CARD_BASIC 연결 키)

  final String cardNumber;     // 카드번호: 마스킹된 형태 (예: 1234-0000-****-****)

  final DateTime issueDate;    // 발급일: 카드 발급 일자
  final DateTime expiryDate;   // 카드 유효기간: 만료 예정 일자

  final String cardStatus;     // 카드 상태 (예: 활성, 정지, 해지 등)

  final int? paymentDay;       // 결제일 (1~31): 명세서상 Null 허용(Y)
  final String? paymentBank;    // 결제 은행: 자동이체 은행명 (Null 허용)
  final String? paymentAccount; // 결제 계좌번호: 자동이체 계좌번호 (Null 허용)

  MemberCard({
    required this.memberCardId,
    required this.memberId,
    required this.cardId,
    required this.cardNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.cardStatus,
    this.paymentDay,     // 명세서 Null 허용에 맞춰 필수(required) 제거
    this.paymentBank,    // 명세서 Null 허용에 맞춰 필수(required) 제거
    this.paymentAccount, // 명세서 Null 허용에 맞춰 필수(required) 제거
  });

  /// 서버 JSON 데이터를 Dart 객체로 변환
  factory MemberCard.fromJson(Map<String, dynamic> json) {
    return MemberCard(
      memberCardId: json['memberCardId'],
      memberId: json['memberId'],
      cardId: json['cardId'],
      cardNumber: json['cardNumber'],
      // 서버의 날짜 문자열(DATE)을 DateTime 객체로 변환
      issueDate: DateTime.parse(json['issueDate']),
      expiryDate: DateTime.parse(json['expiryDate']),
      cardStatus: json['cardStatus'],
      paymentDay: json['paymentDay'],
      paymentBank: json['paymentBank'],
      paymentAccount: json['paymentAccount'],
    );
  }

  /// Dart 객체를 서버 전송용 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'memberCardId': memberCardId,
      'memberId': memberId,
      'cardId': cardId,
      'cardNumber': cardNumber,
      // DateTime을 서버가 이해할 수 있는 문자열 형식으로 변환
      'issueDate': issueDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'cardStatus': cardStatus,
      'paymentDay': paymentDay,
      'paymentBank': paymentBank,
      'paymentAccount': paymentAccount,
    };
  }
}