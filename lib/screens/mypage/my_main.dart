/*
  날짜 : 2025-12-29
  이름 : 박효빈
  내용 : 마이페이지 화면

  날짜 : 2026-01-05
  이름 : 이수연
  내용 : 화면 디자인 수정 & 화면 연결
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bnkpart2/providers/auth_provider.dart';
import 'package:bnkpart2/screens/mypage/my_card_management_screen.dart';
import 'package:bnkpart2/screens/benefit/benefit_monthly_screen.dart';
import 'package:bnkpart2/screens/payment/card_selection_screen.dart';

import 'package:bnkpart2/services/mypage/card_service.dart';
import 'package:bnkpart2/models/dto/my_card.dart';

/// 마이페이지 메인
class MyMain extends StatefulWidget {
  const MyMain({super.key});

  @override
  State<MyMain> createState() => _MyMainState();
}

class _MyMainState extends State<MyMain> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final bool isLoggedIn = authProvider.isLoggedIn;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoggedIn ? _buildLoggedIn() : _buildLogin(),
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '회원정보'),
        ],
      ),
    );
  }

  /// 금액 포맷
  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
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
              // TODO: 로그인 화면 이동
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserHeader(),
          const SizedBox(height: 16),
          _buildBannerSection(),
          const SizedBox(height: 20),
          _buildMyCardHeader(),
          const SizedBox(height: 12),
          _buildCardInfoSection(),
          const SizedBox(height: 20),
          _buildBenefitSection(),
          const SizedBox(height: 24),
          _buildEditButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  /// 상단 사용자 헤더
  Widget _buildUserHeader() {
    return Row(
      children: [
        const Text(
          '박효빈',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: const Text('메인페이지'),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).logout();
          },
          icon: Icon(Icons.logout, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  /// 배너 섹션
  Widget _buildBannerSection() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('임시 지도 화면')),
              body: const Center(child: Text('지도 화면')),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/mapbanner.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// 내 카드 헤더
  Widget _buildMyCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '내 카드',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyCardManagementScreen()),
            );
          },
          child: const Text('내 카드관리'),
        ),
      ],
    );
  }

  /// 카드 정보
  Widget _buildCardInfoSection() {
    return FutureBuilder<MyCardModel>(
      future: CardService().getMyPageData(2),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return _buildErrorContainer();
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
                    Text('${card.cardName} | ${card.cardNumber}'),
                    const SizedBox(height: 16),
                    const Text('이번 달 이용금액'),
                    Text(
                      '${formatCurrency(card.totalUsageAmount)}원',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Image.network(
                card.cardImageUrl,
                width: 60,
                height: 100,
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorContainer() {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PaymentAccountChangeScreen()),
        );
      },
      child: const Text('연결 계좌 설정'),
    );
  }

  /// 받은 혜택
  Widget _buildBenefitSection() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BenefitMonthScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('받은 혜택 >', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            _buildBenefitBar('교통', 0.6, '21,550원'),
            _buildBenefitBar('외식', 0.7, '345,780원'),
            _buildBenefitBar('여가', 0.2, '52,187원'),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitBar(String title, double value, String amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(amount),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: value),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Center(
      child: OutlinedButton(
        onPressed: () {},
        child: const Text('마이 화면 편집'),
      ),
    );
  }
}
