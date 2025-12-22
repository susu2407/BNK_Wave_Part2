/*
  날짜 : 2025-12-18
  내용 : 계좌 등록/수정할 카드 선택 화면
  이름 : 이수연
*/
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: PaymentAccountChangeScreen(),
    debugShowCheckedModeBanner: false,  // 디버그 모드 띠 숨기기 위한 설정
  ));
}

// 설계도 역할
class PaymentAccountChangeScreen extends StatefulWidget {
  const PaymentAccountChangeScreen({super.key});

  @override
  State<PaymentAccountChangeScreen> createState() => _PaymentAccountChangeScreenState();
}

// 기억 장치 역할
class _PaymentAccountChangeScreenState extends State<PaymentAccountChangeScreen> {
  int _selectedTab = 0; // 0: 신용, 1: 체크
  int? _selectedCardId; // 테이블의 PK인 MEMBER_CARD_ID를 저장
  // int? _selectedCardIndex; // 선택된 카드 인덱스

  // 1. [데이터] DB 명세서를 기반으로 한 가상 데이터 리스트
  final List<Map<String, dynamic>> _myCardList = [
    {
      'MEMBER_CARD_ID': 1,
      'CARD_NUMBER': '1234-5678-9012-3456',
      'PAYMENT_BANK': '신한은행',
      'PAYMENT_ACCOUNT': '110-123-456789',
    },
    {
      'MEMBER_CARD_ID': 2,
      'CARD_NUMBER': '5555-4444-3333-2222',
      'PAYMENT_BANK': '국민은행',
      'PAYMENT_ACCOUNT': '4567-02-12345',
    },
    {
      'MEMBER_CARD_ID': 3,
      'CARD_NUMBER': '9999-0000-1111-2222',
      'PAYMENT_BANK': '우리은행',
      'PAYMENT_ACCOUNT': '1002-987-654321',
    },
    // 리스트가 길어져도 스크롤 테스트가 가능하도록 추가 가능
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column( // 전체 뼈대
        children: [
          // --- [상단 고정 영역 시작] ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  '내 카드의 결제계좌를\n쉽게 변경해보세요.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, height: 1.4),
                ),
                const SizedBox(height: 30),
                _buildToggleTabs(), // 신용/체크 탭
                const SizedBox(height: 40),
                const Text(
                  '카드 · 계약 선택',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          Expanded( // 유연한 확장(남은 공간 모두 차지)
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _myCardList.length,
              itemBuilder: (context, index) {
                // 메서드 분리 호출
                return _buildCardItem(_myCardList[index]);
              },
            ),
          ),
          _buildNoticeSection(),
          _buildBottomButton(), // 하단 버튼 고정 영역
        ],
      ),
    );
  }

  // 2. [메서드] 선택 가능한 카드 아이템 빌더
  Widget _buildCardItem(Map<String, dynamic> cardData) {
    final int cardId = cardData['MEMBER_CARD_ID'];
    final bool isSelected = _selectedCardId == cardId;

    // 카드번호 앞 4자리 추출 로직
    final String fullNumber = cardData['CARD_NUMBER'];
    final String displayId = fullNumber.substring(0, 4);

    return GestureDetector(
      onTap: () => setState(() => _selectedCardId = cardId),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        // 선택 시 살짝 커지는 효과
        transform: isSelected ? (Matrix4.identity()..scale(1.02)) : Matrix4.identity(),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          // 선택 시 배경색을 완전히 채움 (브랜드 컬러 등)
          color: isSelected ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '[$] | [$displayId]',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${cardData['PAYMENT_BANK']} ${cardData['PAYMENT_ACCOUNT']}',
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected ? Colors.white70 : Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.credit_card,
              color: isSelected ? Colors.white24 : Colors.black12,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

  // 앱바 위젯
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
      title: const Text('결제계좌', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17)),
    );
  }

  // 상단 탭 위젯 : 신용,체크
  Widget _buildToggleTabs() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabItem('신용', 0),
          _buildTabItem('체크', 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 안내 문구 섹션
  Widget _buildNoticeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _noticeRow('청구방식이 통합된 경우, 결제정보는 하나로 보관됩니다.'),
        _noticeRow('점검 시간(23:30~00:00)에는 서비스 이용이 제한될 수 있습니다.'),
        const SizedBox(height: 30),
        const Text('기타 안내', style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _noticeRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text('• $text', style: const TextStyle(fontSize: 12, color: Colors.black38, height: 1.5)),
    );
  }

  // 하단 버튼
  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton(
          onPressed: _selectedCardId != null ? () {} : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            disabledBackgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: const Text('변경하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
}