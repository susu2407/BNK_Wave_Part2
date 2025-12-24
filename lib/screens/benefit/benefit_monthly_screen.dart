import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BenefitMonthScreen(),
    );
  }
}

class BenefitMonthScreen extends StatefulWidget {
  const BenefitMonthScreen({super.key});

  @override
  State<BenefitMonthScreen> createState() => _BenefitMonthScreenState();
}

class _BenefitMonthScreenState extends State<BenefitMonthScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF8A8A8A);
    const bg = Colors.white;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          '이번달 받은 혜택',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ✅ [수정] 1) 월 타이틀: 박스 제거 → 텍스트만
              const Text(
                '2025년 12월 받은 혜택', // TODO: DB 연동 시 교체
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),

              // ✅ [수정] 2) 결제일 할인: 리스트형 한 줄 (원형 아이콘 + 텍스트 + 금액)
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE7F3EF),
                    ),
                    child: const Center(
                      child: Icon(Icons.check, size: 18, color: Color(0xFF2E9C7A)),
                    ),
                  ),
                  const SizedBox(width: 12),

                  const Expanded(
                    child: Text(
                      '결제일 할인', // TODO: DB 연동 시 교체
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),

                  const Text(
                    '925 원', // TODO: DB 연동 시 교체
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ],
              ),

              const SizedBox(height: 14),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8E8)),
              const SizedBox(height: 14),

              // ✅ [수정] 3) 안내: 테두리 박스 제거 + 회색 bullet
              const _BulletText(
                '결제일할인/적립 내역입니다.',
                color: Color(0xFF8E8E8E),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 10),
              const _BulletText(
                '일부 혜택 금액은 적용 방식 및 시점 차이로 포함되지않습니다.',
                color: Color(0xFF8E8E8E),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),

              const SizedBox(height: 22),


              const SizedBox(height: 14),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8E8)),
              const SizedBox(height: 14),

              // ===== 아래는 기존 유지 =====
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '내 카드 모든 혜택',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '카드이름',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9A9A9A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 46,
                          height: 64,
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              '카드\n이미지',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    _BenefitRow(
                      title: '국내 가맹점 1% 결제일할인',
                      subtitle: ' ',
                      amountText: '연 0원',
                      onTap: () {},
                    ),
                    const SizedBox(height: 14),

                    _BenefitRow(
                      title: '온라인 간편결제/커피전문점/해외',
                      subtitle: '1.5% 결제일할인',
                      amountText: '0원',
                      onTap: () {},
                    ),
                    const SizedBox(height: 14),

                    _BenefitRow(
                      title: '사업장 운영 경비 1.5%',
                      subtitle: '결제일할인',
                      amountText: '연 0원',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy_outlined), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.manage_accounts_outlined), label: '회원정보수정'),
        ],
      ),
    );
  }
}

// ✅ [수정] bullet 스타일 커스텀 가능하게 변경
class _BulletText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const _BulletText(
      this.text, {
        this.color = Colors.black,
        this.fontSize = 14,
        this.fontWeight = FontWeight.w700,
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•  ',
          style: TextStyle(fontSize: fontSize + 2, fontWeight: FontWeight.w900, color: color),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
          ),
        ),
      ],
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final String title;      // 1줄(굵게)
  final String? subtitle;  // 2줄(회색, 선택)
  final String amountText; // 오른쪽 금액
  final VoidCallback onTap;

  const _BenefitRow({
    required this.title,
    this.subtitle,
    required this.amountText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // 왼쪽 텍스트 1~2줄
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9A9A9A),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // 오른쪽 금액 + >
            Text(
              amountText,
              style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w900),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 22, color: Color(0xFF7A7A7A)),
          ],
        ),
      ),
    );
  }
}