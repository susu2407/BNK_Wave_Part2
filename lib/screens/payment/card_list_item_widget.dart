/*
  날짜 : 2026-01-02
  이름 : 이수연
  내용 : 카드 목록 및 카드 정보를 보여 주는 위젯

  재활용을 위해 위젯을 리팩토링 함.

  [리팩토링] Map 데이터 덩어리 대신, 위젯이 표현할 데이터를 각각의 파라미터로 받습니다.
  이렇게 하면 위젯이 특정 데이터 구조(Map)에 종속되지 않고, 훨씬 유연하고 재사용성이 높아집니다.
 */

import 'package:flutter/material.dart';

class CardListItemWidget extends StatelessWidget {
  final String cardName;
  final String cardType;
  final String cardNumber;
  final String? paymentBank;
  final String? paymentAccount;
  final String cardImageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const CardListItemWidget({
    super.key,
    required this.cardName,
    required this.cardType,
    required this.cardNumber,
    this.paymentBank,
    this.paymentAccount,
    required this.cardImageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 카드번호 앞 4자리를 안전하게 추출합니다.
    final String displayId = cardNumber.length >= 4 ? cardNumber.substring(0, 4) : '';
    // 계좌 등록 여부를 확인합니다.
    final bool hasAccount = paymentBank != null && paymentAccount != null;

    return GestureDetector(
      onTap: onTap, // 외부에서 전달받은 onTap 함수를 실행합니다.
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.only(bottom: 16),
        transform: isSelected ? (Matrix4.identity()..scale(1.02)) : Matrix4.identity(),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFCB2B11)
              : const Color(0xFFFCEFEF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardName,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black87
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$cardType | $displayId',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    hasAccount
                        ? '$paymentBank $paymentAccount'
                        : '결제 계좌를 등록해주세요.',
                    style: TextStyle(
                      fontSize: 13,
                      color: !hasAccount
                          ? Colors.orange
                          : (isSelected ? Colors.white70 : Colors.black45),
                      fontWeight: hasAccount
                          ? FontWeight.normal
                          : FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // 카드 이미지를 세로로 길게 표시하고, 로딩/에러 시 UI를 개선합니다.
            SizedBox(
              width: 60,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(
                  cardImageUrl,
                  fit: BoxFit.contain, // contain으로 비율 유지
                  // 로딩 중에 보여줄 위젯
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: Colors.grey.shade400,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  // 에러 발생 시 보여줄 위젯 (요청하신 디자인 적용)
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.credit_card,
                          color: isSelected ? Colors.white24 : Colors.black12,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
