/*
  날짜 : 2026-01-05
  이름 : 이수연
  내용 : 계좌 등록/변경 완료 결과 화면
*/

import 'package:flutter/material.dart';
import '../../models/dto/account_dto.dart';

class CardAccountResultScreen extends StatelessWidget {
  // 이전 화면들로부터 카드 정보와 새로 등록된 계좌 정보를 전달받습니다.
  final AccountInputDto registeredCardInfo;
  final String newBankName;
  final String newAccountNumber;

  const CardAccountResultScreen({
    super.key,
    required this.registeredCardInfo,
    required this.newBankName,
    required this.newAccountNumber,
  });

  @override
  Widget build(BuildContext context) {
    // 카드 번호와 계좌번호 마스킹 처리
    final String maskedCardNumber = '${registeredCardInfo.cardType} ㅣ${registeredCardInfo.cardNumber.substring(0, 4)}';
    final String maskedAccountNumber = '${newAccountNumber.substring(0, 4)}********';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        title: const Text('결제계좌 변경', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black, size: 28),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '결제계좌 변경이\n완료되었습니다.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            _buildInfoRow('신청카드', registeredCardInfo.cardName, subText: '${registeredCardInfo.cardType} $maskedCardNumber'),
            _buildInfoRow('결제계좌', '$newBankName $maskedAccountNumber', isHighlighted: true),
            _buildInfoRow('처리상태', '변경완료'),
            const Divider(),
            const Text(
              '• 변경 처리는 은행별 기간에 따라 신청일로부터 1~3(영업일 기준) 소요됩니다. (단, 체크카드의 경우 즉시 변경됩니다.)',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Spacer(),
            _buildBottomButtons(context),
          ],
        ),
      ),
    );
  }

  // 정보 행을 만드는 위젯
  Widget _buildInfoRow(String title, String content, {String? subText, bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, color: Colors.grey)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                content,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isHighlighted ? const Color(0xFFCB2B11) : Colors.black,
                ),
              ),
              if (subText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(subText, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // 하단 버튼 2개를 만드는 위젯
  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                // TODO: 변경내역 조회 화면으로 이동
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('변경내역 조회', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCB2B11), // 강조 색상
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('확인', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ),
      ],
    );
  }
}
