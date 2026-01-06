import 'package:flutter/material.dart';
import 'benefit_summary_screen.dart';

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
              /// 월 타이틀
              const Text(
                '2025년 12월 받은 혜택',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),

              /// 이번달 혜택 총합 (DB 기준: 5,610원)
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
                      '결제일 할인',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Text(
                    '5,610원',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ],
              ),

              const SizedBox(height: 14),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8E8)),
              const SizedBox(height: 14),

              /// 안내 문구
              const _BulletText(
                '결제일할인/적립 내역입니다.',
                color: Color(0xFF8E8E8E),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 10),
              const _BulletText(
                '일부 혜택 금액은 적용 방식 및 시점 차이로 포함되지 않을 수 있습니다.',
                color: Color(0xFF8E8E8E),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),

              const SizedBox(height: 22),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8E8)),
              const SizedBox(height: 14),

              /// 카드 혜택 목록
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '내 카드 모든 혜택',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '신한 Deep Dream',
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

                    /// 카페
                    _BenefitRow(
                      title: '카페',
                      subtitle: '스타벅스 · 투썸플레이스',
                      amountText: '1,850원',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BenefitDetailScreen(
                              benefitTitle: '카페 할인',
                              yearAmountText: '연 1,850원',
                              monthAmountText: '1,850원',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 14),

                    /// 간편결제
                    _BenefitRow(
                      title: '온라인 간편결제',
                      subtitle: '네이버페이 · 카카오페이',
                      amountText: '1,350원',
                      onTap: () {},
                    ),
                    const SizedBox(height: 14),

                    /// 교통
                    _BenefitRow(
                      title: '교통',
                      subtitle: '지하철 · 버스',
                      amountText: '310원',
                      onTap: () {},
                    ),
                    const SizedBox(height: 14),

                    /// 주유
                    _BenefitRow(
                      title: '주유',
                      subtitle: 'SK주유소',
                      amountText: '2,100원',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          style: TextStyle(
            fontSize: fontSize + 2,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String amountText;
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
