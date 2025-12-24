/*
  날짜 : 2025-12-24
  이름 : 이수연
  내용 : 카드 계좌 등록/수정 완료
*/
import 'package:flutter/material.dart';
import '../../models/dto/card_view_dto.dart';
import '../../models/entity/card_basic.dart';
import '../../models/entity/member_card.dart';

void  main () {

  // 1. 테스트용 임시 데이터 생성
  final dummyCard = CardViewDto(
    basic: CardBasic(
      cardId: 1,
      cardName: "삼성 iD ALL 카드",
      cardType: "신용",
      cardImageUrl: "assets/images/card.png",
    ),
    member: MemberCard(
      memberCardId: 1,
      cardNumber: "1234567812345678",
      accountNumber: "123-456-789",
    ),
  );

  runApp(MaterialApp(
    home: PaymentCompleteScreen(selectedCard: dummyCard, changedBank: '', changedAccount: '',),
  ));
}

class PaymentCompleteScreen extends StatelessWidget {
  final CardViewDto selectedCard;
  final String changedBank;
  final String changedAccount;

  const PaymentCompleteScreen({
    super.key,
    required this.selectedCard,
    required this.changedBank,
    required this.changedAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              "결제계좌 변경이\n완료되었습니다.",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 40),

            const Divider(thickness: 1, color: Color(0xf6909090),), // 구분선
            const SizedBox(height: 20),

            // 변경된 상세 정보 박스
            _buildChangeDetailBox(),

            const SizedBox(height: 20),
            const Divider(thickness: 1, color: Color(0xf6909090),), // 구분선
            const SizedBox(height: 15),

            // 3. 하단 확인 버튼
            _buildConfirmButton(context),
          ],
        ),
      ),
    );
  }

  // 상단 앱바 (뒤로가기 없음, 닫기만 존재)
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
      title: const Text("결제계좌 변경", style: TextStyle(color: Colors.black, fontSize: 16)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
      ],
    );
  }


  // 변경된 계좌 상세 정보
  Widget _buildChangeDetailBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text("• 신청카드 : ${selectedCard.basic.cardName}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text("$changedBank $changedAccount", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),

          // 회색 안내 문구 영역
          Text(
            "변경처리에는 은행별 기간에 따라 1~3일(영업일 기준) 소요됩니다.\n(단, 처리상태 : 완료 시점 기준)",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 확인 버튼
  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text("확인", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}