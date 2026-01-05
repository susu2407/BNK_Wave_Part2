/*
  날짜 : 2025-12-29
  이름 : 박효빈
  내용 : 마이페이지 화면

  날짜 : 2026-01-05
  이름 : 이수연
  내용 : 화면 디자인 수정 & 화면 연결
 */

import 'package:bnkpart2/screens/mypage/my_card_management_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bnkpart2/providers/auth_provider.dart';

import '../payment/card_selection_screen.dart';


/// 마이페이지 탭
class MyMain extends StatefulWidget {
  const MyMain({super.key});

  @override
  State<MyMain> createState() => _MyMainState();
}

class _MyMainState extends State<MyMain> {

  int _currentIndex = 0; // 하단 탭 바를 위한 인덱스

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    bool isLoggedin = authProvider.isLoggedIn;

    return Scaffold(
      backgroundColor: Colors.white,
      // [수정] AppBar를 제거하고, 본문을 SafeArea로 감싸 상태바 영역 침범을 방지합니다.
      body: SafeArea(
        child: isLoggedin ? _buildLoggedIn() : _buildLogin(),
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
            // 1. 테두리가 포함된 상단 사용자 영역
            _buildUserHeader(),
            const SizedBox(height: 16),

            // 2. 테두리가 포함된 배너 슬라이드 광고
            _buildBannerSection(),
            const SizedBox(height: 20),

            // 3. 내 카드 섹션
            _buildMyCardHeader(),
            const SizedBox(height: 12),
            _buildCardInfoSection(),
            const SizedBox(height: 20),

            // 4. 받은 혜택 섹션
            _buildBenefitSection(),
            const SizedBox(height: 24),

            // 5. 마이 화면 편집 버튼
            _buildEditButton(),
            const SizedBox(height: 40),
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
                child: const Text('메인페이지', style: TextStyle(fontSize: 14)),
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
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
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
                  '카카오뱅크 개인사업자 삼성카드 | 3692',
                  style: TextStyle(color: Colors.white, fontSize: 14),
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
            '12월 이용금액',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 2),
          const Text(
            '83,700원',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentAccountChangeScreen()),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF47A6F8),
              shape: RoundedRectangleBorder(
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

  /// 받은 혜택 섹션
  Widget _buildBenefitSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('받은 혜택', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildBenefitBar('교통', 0.6, '21,550원'),
          _buildBenefitBar('외식', 0.7, '345,780원'),
          _buildBenefitBar('여가', 0.2, '52,187원'),
        ],
      ),
    );
  }

  /// 혜택 프로그레스 바
  Widget _buildBenefitBar(String title, double value, String amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 18)),
              Text(amount, style: const TextStyle(fontSize: 18)),
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

  /// 화면 편집 버튼
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
}
