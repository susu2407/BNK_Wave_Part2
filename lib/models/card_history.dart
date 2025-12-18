/*
  날짜 : 2025-12-18
  내용 : card_history 모델
  이름 : 박효빈
*/
class CardHistory {
  final int transactionId;      // 거래 일련번호 (PK): 결제 거래의 고유 식별자

  final int memberId;           // 사용자 식별자 (FK: TB_MEMBER 연결 키)
  final int memberCardId;       // 카드 식별자 (FK: TB_MEMBER_CARD 연결 키)

  final DateTime approvalDatetime; // 결제 일시: 승인 일자 (TIMESTAMP)
  final int approvalAmount;        // 결제 금액 (NUMBER(10,0))

  final String merchantName;       // 매장 명 (VARCHAR2(100))
  final String? merchantCategory;  // 매장 업종 명: 가맹점 업종 분류 (교통, 카페 등)

  final int? benefitId;            // 혜택 일련번호 (FK: TB_CARD_BENEFIT 연결 키)
  final int? benefitAmount;         // 혜택 금액: 할인/적립 등으로 적용된 실제 금액

  final String isPerformance;      // 실적 포함 여부: 전월 실적 계산 포함 여부 ('Y' / 'N')

  final double latitude;           // 위도 (NUMBER(10,7))
  final double longitude;          // 경도 (NUMBER(10,7))
  final String merchantAddress;    // 매장 주소 (VARCHAR2(255))

  CardHistory({
    required this.transactionId,
    required this.memberId,
    required this.memberCardId,
    required this.approvalDatetime,
    required this.approvalAmount,
    required this.merchantName,
    this.merchantCategory, // 명세서상 Null 허용(Y) 가능성을 고려하여 필수 제외
    this.benefitId,        // 명세서상 FK이되, 혜택 미적용 시 Null 가능
    this.benefitAmount,    // 명세서상 Null 허용(Y)
    required this.isPerformance,
    required this.latitude,
    required this.longitude,
    required this.merchantAddress,
  });

  /// 서버(JSON)에서 받은 데이터를 Dart 객체로 변환
  factory CardHistory.fromJson(Map<String, dynamic> json) {
    return CardHistory(
      transactionId: json['transactionId'],
      memberId: json['memberId'],
      memberCardId: json['memberCardId'],
      // 서버의 ISO8601 문자열을 DateTime 객체로 변환
      approvalDatetime: DateTime.parse(json['approvalDatetime']),
      approvalAmount: json['approvalAmount'],
      merchantName: json['merchantName'],
      merchantCategory: json['merchantCategory'],
      benefitId: json['benefitId'],
      benefitAmount: json['benefitAmount'],
      isPerformance: json['isPerformance'],
      // 위도/경도가 실수(double)가 아닐 경우를 대비해 변환
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      merchantAddress: json['merchantAddress'],
    );
  }

  /// Dart 객체를 서버로 전송하기 위해 JSON 형태로 변환
  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'memberId': memberId,
      'memberCardId': memberCardId,
      'approvalDatetime': approvalDatetime.toIso8601String(),
      'approvalAmount': approvalAmount,
      'merchantName': merchantName,
      'merchantCategory': merchantCategory,
      'benefitId': benefitId,
      'benefitAmount': benefitAmount,
      'isPerformance': isPerformance,
      'latitude': latitude,
      'longitude': longitude,
      'merchantAddress': merchantAddress,
    };
  }
}