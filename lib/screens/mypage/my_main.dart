import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bnkpart2/providers/auth_provider.dart';

// 서비스와 모델 임포트
import 'package:bnkpart2/services/mypage/card_service.dart';
import 'package:bnkpart2/models/dto/my_card.dart';

// 이동할 페이지 임포트 (파일 경로가 다르면 수정해주세요)
import 'package:bnkpart2/screens/benefit/benefit_monthly_screen.dart';

/// 마이페이지 탭
class MyMain extends StatefulWidget {
  const MyMain({super.key});

  @override
  State<MyMain> createState() => _MyMainState();
}

class _MyMainState extends State<MyMain> {
  // 금액에 콤마를 찍어주는 함수
  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  /// 로그인 전 화면
  Widget _buildLogin() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('로그인이 필요합니다.'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // TODO: 로그인 화면으로 이동
            },
            child: const Text('로그인 이동'),
          ),
        ],
      ),
    );
  }

  /// 로그인 후 메인 화면
  Widget _buildLoggedIn() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade600, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildUserHeader(),
            ),
            const SizedBox(height: 16),
            _buildBannerSection(),
            const SizedBox(height: 20),
            _buildMyCardHeader(),
            const SizedBox(height: 12),
            _buildCardInfoSection(),
            const SizedBox(height: 20),

            // --- 받은 혜택 섹션 ---
            _buildBenefitSection(),

            const SizedBox(height: 24),
            _buildEditButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// 상단 사용자 정보 헤더
  Widget _buildUserHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '고정현',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            _buildHeaderButton('메인페이지', () => Navigator.pop(context)),
            const SizedBox(width: 12),
            _buildHeaderButton('알림', () {}),
            const SizedBox(width: 12),
            _buildHeaderButton('로그아웃', () {
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              authProvider.logout();
            }),
          ],
        )
      ],
    );
  }

  Widget _buildHeaderButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }

  /// 배너 광고 섹션
  Widget _buildBannerSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade600, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '< 배너 슬라이드 광고 >',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 16),
          _buildBannerItem('MAP 이벤트 안내'),
          _buildBannerItem('MAP으로 이동'),
          const SizedBox(height: 20),
          _buildBannerItem('챗봇 홍보 이미지'),
          _buildBannerItem('챗봇으로 이동'),
        ],
      ),
    );
  }

  Widget _buildBannerItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  /// 내 카드 헤더
  Widget _buildMyCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '내 카드 >',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text('내 카드 관리', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }

  /// 서버 연동 카드 정보 섹션
  Widget _buildCardInfoSection() {
    return FutureBuilder<MyCardModel>(
      future: CardService().getMyPageData(2),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return _buildErrorContainer('데이터 로드 실패');
        } else if (!snapshot.hasData) {
          return _buildErrorContainer('카드 정보가 없습니다.');
        }

        final card = snapshot.data!;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${card.cardName} | ${card.cardNumber}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 16),
                    const Text('이번 달 이용금액',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text('${formatCurrency(card.totalUsageAmount)}원',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade200),
                  image: DecorationImage(
                    image: NetworkImage(card.cardImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: card.cardImageUrl.isEmpty
                    ? const Icon(Icons.credit_card, color: Colors.grey)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorContainer(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
        color: Colors.red.shade50,
      ),
      child: Center(
        child: Text(message, style: const TextStyle(color: Colors.red)),
      ),
    );
  }

  /// 받은 혜택 섹션 (전체 클릭 시 이동 추가)
  Widget _buildBenefitSection() {
    return GestureDetector(
      onTap: () {
        // 섹션 전체 클릭 시 상세 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BenefitMonthScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('받은 혜택 >', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
            _buildBenefitBar('교통', 0.6, '700,000원'),
            _buildBenefitBar('외식', 0.4, '500,000원'),
            _buildBenefitBar('여가', 0.2, '200,000원'),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitBar(String title, double value, String amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 13)),
              Text(amount, style: const TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 12,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Center(
      child: SizedBox(
        width: 200,
        child: OutlinedButton(
          onPressed: () {},
          child: const Text('마이 화면 편집'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    bool isLoggedin = authProvider.isLoggedIn;

    return Scaffold(
      appBar: AppBar(
        title: const Text('마이 페이지'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: isLoggedin ? _buildLoggedIn() : _buildLogin(),
    );
  }
}