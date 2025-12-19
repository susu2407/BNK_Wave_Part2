import 'package:bnkpart2/models/MemberCard.dart';
import 'package:bnkpart2/models/cardBasic.dart';

class CardViewModel {
  final MemberCard memberCard; // 보유 정보 (계좌번호, 마스킹 번호 등)
  final CardBasic cardBasic;   // 상품 정보 (이미지 URL, 카드 이름 등)

  CardViewModel({
    required this.memberCard,
    required this.cardBasic,
  });

  // [요청 반영] 계좌 정보를 활용한 커스텀 이름 생성
  // 예: "신한은행(110-***) - 현대카드 M"
  String get displayAccountName {
    final bank = memberCard.paymentBank ?? "은행미지정";
    final account = memberCard.paymentAccount ?? "계좌없음";

    // 계좌 번호가 길면 뒷부분만 살짝 보여주는 등의 가공 가능
    return "$bank($account) - ${cardBasic.cardName}";
  }

  // 카드 번호 앞 4자리 가공 로직을 모델 내부로 이동 (UI 코드 단순화)
  String get shortCardNumber {
    if (memberCard.cardNumber.length >= 4) {
      return memberCard.cardNumber.substring(0, 4);
    }
    return "****";
  }
}