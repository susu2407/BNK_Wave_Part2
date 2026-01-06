/*
  날짜 : 2025-12-29
  이름 : 박효빈
  내용 : 마이페이지 화면

  날짜 : 2026-01-05
  이름 : 이수연
  내용 : 화면 디자인 수정 & 화면 연결

   날짜 : 2026-01-06
  이름 : 박효빈
  내용 : 화면 디테일 수정
 */

import 'package:bnkpart2/screens/mypage/my_card_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bnkpart2/providers/auth_provider.dart';

import '../../models/dto/account_dto.dart';
import '../benefit/benefit_monthly_screen.dart';
import '../payment/card_account_input_screen.dart';
import '../payment/card_selection_screen.dart';
import '../member/cardnumber_screen.dart';
import '../map/chat_screen.dart';
import '../map/map_screen.dart';

// 서비스와 모델 임포트 (파일 경로가 다르면 수정해주세요)
import 'package:bnkpart2/services/mypage/card_service.dart';
import 'package:bnkpart2/models/dto/my_card.dart';




/// 마이페이지 탭
class MyMain extends StatefulWidget {
  const MyMain({super.key});

  @override
  State<MyMain> createState() => _MyMainState();
}

class _MyMainState extends State<MyMain> {

  int _currentIndex = 0; // 하단 탭 바를 위한 인덱스

  late final List<WidgetBuilder> _widgetList;

  @override
  void initState() {
    super.initState();
    _widgetList = [
          (_) => _buildLoggedIn(),
          (_) => MyApp(),
          (_) => KakaoMapAPIScreen(),
          (_) => ChatScreen(),
          (_) => CardViewPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    bool isLoggedin = authProvider.isLoggedIn;

    return Scaffold(
      backgroundColor: Colors.white,
      // [수정] AppBar를 제거하고, 본문을 SafeArea로 감싸 상태바 영역 침범을 방지합니다.
      body: SafeArea(
        child: isLoggedin
            ? _widgetList[_currentIndex](context)
            : _buildLogin(),
      ),
      // [추가] 이미지에 보이는 하단 네비게이션 바를 추가합니다.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '마이'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: '혜택'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: '지도'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '챗봇'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '회원정보수정'),
        ],
      ),
    );
  }
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
              child: _buildUserHeader(),
            ),
            const SizedBox(height: 16),
            _buildBannerSection(),
            const SizedBox(height: 30),
            _buildMyCardHeader(),
            const SizedBox(height: 10),
            _buildCardInfoSection(),
            const SizedBox(height: 40),
            _buildBenefitSection(),
          ],
        ),
      ),
    );
  }

  /// 상단 사용자 정보 헤더 (디자인 수정)
  Widget _buildUserHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Text(
            '박효빈',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // 중앙: 메인페이지 버튼 (빈 공간을 모두 차지하여 중앙 정렬 효과)
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: const Text('', style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
          // 오른쪽: 로그아웃 아이콘 버튼
          IconButton(
            onPressed: () {
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              authProvider.logout();
            },
            icon: Icon(Icons.logout, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  /// 배너 광고 섹션 (이미지 디자인 반영)
  Widget _buildBannerSection() {
    return GestureDetector(
        onTap: () {
          // TODO: 실제 지도 화면으로 교체 필요
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Scaffold(
              appBar: AppBar(title: const Text('임시 지도 화면')),
              body: const Center(child: Text('지도 화면이 여기에 표시됩니다.')),
            );
          }));
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              'assets/images/mapbanner.png',
              fit: BoxFit.cover, // 이미지가 위젯 크기에 맞게 채워지도록 설정
            ),
        )
    );
  }

  /// 내 카드 헤더 (디자인 수정)
  Widget _buildMyCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          '내 카드',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            // '내 카드 관리' 화면으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyCardManagementScreen()),
            );
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: const Text(
            '내 카드관리',
            style: TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  /// 카드 정보 섹션 (디자인 수정)
  Widget _buildCardInfoSection() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    int memberId = 2;

    return FutureBuilder<MyCardModel>(
      future: CardService().getMyPageData(memberId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return _buildErrorContainer('카드 정보가 없습니다.');
        }

        final card = snapshot.data!;

        return Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          decoration: BoxDecoration(
            color: const Color(0xFFCB2B11),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 상단 카드명 + 카드 이미지
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${card.cardName} | ${card.cardNumber}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  card.cardImageUrl.isNotEmpty
                      ? Image.network(
                    card.cardImageUrl,
                    width: 40,
                    height: 64,
                    fit: BoxFit.cover,
                  )
                      : const Icon(
                    Icons.credit_card,
                    color: Colors.white70,
                    size: 32,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// 이용금액
              const Text(
                '이번 달 이용금액',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(
                '${formatCurrency(card.totalUsageAmount)}원',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// 연결 계좌 설정 버튼
              TextButton(
                onPressed: () {
                  final dummyCard = AccountInputDto(
                    cardId: 1,
                    cardName: card.cardName,
                    cardNumber: card.cardNumber,
                    cardType: '개인',
                    cardImageUrl: card.cardImageUrl,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CardAccountInputScreen(selectedCard: dummyCard),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFFFFFF),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFFFFFFFF), width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(double.infinity, 0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text(
                      '연결 계좌 설정',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  /// 에러 발생 시 보여줄 컨테이너
  Widget _buildErrorContainer(String message) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      decoration: BoxDecoration(
        color: const Color(0xFFCB2B11),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  '신한 Deep Dream | 3456',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(width: 16),
              Image.asset(
                '', // TODO: 실제 카드 이미지 경로로 수정
                width: 10,
                height: 17,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '이번달 이용금액',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 2),
          const Text(
            '477,400원',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // 카드 정보가 없는 경우, 임시 데이터로 화면 이동
              final dummyCard = AccountInputDto(
                cardId: 0, // 실제 ID가 없으므로 0으로 설정
                cardName: '신한 Deep Dream',
                cardNumber: '1234-5678-9012-3456',
                cardType: '신용',
                cardImageUrl: '2',
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CardAccountInputScreen(selectedCard: dummyCard)),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFFFFFF),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFFFFFFFF), width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              minimumSize: const Size(double.infinity, 0),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite, color: Color(0xFFFFFFFF), size: 16),
                SizedBox(width: 8),
                Text(
                  '연결 계좌 설정',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // ----------------------------------------------

  /// 받은 혜택 섹션
  Widget _buildBenefitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('받은 혜택',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BenefitMonthScreen()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '신한 Deep Dream | 3456',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  '2025. 12. 01 ~ 2025. 12. 31',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildBenefitBar('교통', 0.6, '21,550원'),
                _buildBenefitBar('외식', 0.7, '145,780원'),
                _buildBenefitBar('여가', 0.2, '52,187원'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitBar(String title, double value, String amount) {
    const barHeight = 20.0;
    const markerSize = 15.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500)),
              Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(builder: (context, constraints) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                // Track
                Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(barHeight / 2),
                  ),
                ),
                // Progress
                Container(
                  width: constraints.maxWidth * value,
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: Color(0xFFCB2B11),
                    borderRadius: BorderRadius.circular(barHeight / 2),
                  ),
                ),
                // Dashed line inside progress
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: constraints.maxWidth * value,
                      child: Row(
                        children: List.generate(
                          30,
                              (i) => Expanded(
                            child: Container(
                              height: 1,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Markers
                Positioned(
                  left: constraints.maxWidth * 0.33 - (markerSize / 2),
                  top: (barHeight - markerSize) / 2,
                  child: Container(
                    width: markerSize,
                    height: markerSize,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.66 - (markerSize / 2),
                  top: (barHeight - markerSize) / 2,
                  child: Container(
                    width: markerSize,
                    height: markerSize,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ],
            );
          }),
        ]
      )
    );
  }
}
