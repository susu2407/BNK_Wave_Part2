/*
  날짜 : 2025-12-29
  이름 : 박요셉
  내용 : 혜택 상세 화면

  - 이번달 받은 혜택 화면(benefit_monthly_screen)에서 상세로 이동하는 화면
 */
import 'package:flutter/material.dart';

class BenefitDetailScreen extends StatefulWidget {
  final String benefitTitle;     // 혜택명
  final String yearAmountText;   // 연 할인 금액
  final String monthAmountText;  // 이번달 혜택 금액

  const BenefitDetailScreen({
    super.key,
    required this.benefitTitle,
    required this.yearAmountText,
    required this.monthAmountText,
  });

  @override
  State<BenefitDetailScreen> createState() => _BenefitDetailScreenState();
}

class _BenefitDetailScreenState extends State<BenefitDetailScreen> {
  int _currentIndex = 1;

  // 임시 데이터(나중에 DB 연동해서 바꾸면 됨)
  String selectedYear = '2025';
  final List<Map<String, String>> items = List.generate(4, (i) {
    return {
      'merchant': '결제 점포',
      'dateAmount': '12/${10 + i} | 이용금액',
      'discount': '${(i + 1) * 50}원',
    };
  });

  @override
  Widget build(BuildContext context) {
    const bg = Colors.white;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFCB2B11),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '받은 혜택 상세',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ===== 상단 정보 섹션 =====
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 혜택명 카드(큰 타이틀)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          widget.benefitTitle,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 이번달 혜택(섹션 타이틀)
                    const Text(
                      '이번달 혜택',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 12),

                    // 연 할인금액 / 이번달 금액 (좌우 박스)
                    Row(
                      children: [
                        Expanded(
                          child: _InfoBox(
                            title: '연 할인 금액',
                            value: widget.yearAmountText,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _InfoBox(
                            title: '이번달 혜택',
                            value: widget.monthAmountText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),

              // ===== 풀폭 섹션 분리 =====
              Container(height: 10, color: const Color(0xFFF5F5F5)),

              // ===== 상세 리스트 섹션 =====
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 연도 선택 드롭다운(카드 스타일)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedYear,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(value: '2025', child: Text('2025년')),
                            DropdownMenuItem(value: '2024', child: Text('2024년')),
                            DropdownMenuItem(value: '2023', child: Text('2023년')),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => selectedYear = v);
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // 총 건수 / 총 금액 요약
                    Row(
                      children: const [
                        Expanded(child: _MiniStatBox(text: '총 000건')),
                        SizedBox(width: 12),
                        Expanded(child: _MiniStatBox(text: '000원')),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // 상세 항목 리스트 (카드형)
                    ...items.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _DetailRowCard(
                        merchant: e['merchant']!,
                        dateAmount: e['dateAmount']!,
                        discount: e['discount']!,
                      ),
                    )),

                    const SizedBox(height: 6),

                    // 더보기 버튼
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            '더보기 / 총 건수',
                            style:  TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // 하단 탭바(기존과 동일 톤)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '마이'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard_outlined), label: '혜택'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: '지도'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '챗봇'),
          BottomNavigationBarItem(icon: Icon(Icons.manage_accounts_outlined), label: '회원정보수정'),
        ],
      ),
    );
  }
}

// ===== 상세 화면 전용 작은 위젯들 =====

class _InfoBox extends StatelessWidget {
  final String title;
  final String value;

  const _InfoBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Color(0xFF8E8E8E)),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _MiniStatBox extends StatelessWidget {
  final String text;
  const _MiniStatBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _DetailRowCard extends StatelessWidget {
  final String merchant;
  final String dateAmount;
  final String discount;

  const _DetailRowCard({
    required this.merchant,
    required this.dateAmount,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  merchant,
                  style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Text(
                  dateAmount,
                  style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Color(0xFF9A9A9A)),
                ),
              ],
            ),
          ),
          Text(
            discount,
            style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
