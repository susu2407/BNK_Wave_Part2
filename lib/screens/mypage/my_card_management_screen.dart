/*
  날짜 : 2026-01-05
  이름 : 이수연
  내용 : 내 카드 관리 화면을 구현
 */

import 'package:bnkpart2/screens/benefit/benefit_monthly_screen.dart';
import 'package:bnkpart2/screens/payment/card_selection_screen.dart';
import 'package:flutter/material.dart';

import '../member/cardnumber_screen.dart';

class MyCardManagementScreen extends StatelessWidget {
  const MyCardManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // 전체 배경색
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('내 카드 관리', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            _buildMainCard(context),
            const SizedBox(height: 24),
            _buildCardDetailsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMainCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Card Image Placeholder
              Container(
                width: 40,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/AMEX_Platinum.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '신용 | MASTER | 이*연 | 후불교통카드',
                      style: TextStyle(color: Color(0xFF888888), fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '신한 Deep Dream',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BenefitMonthScreen()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFF2F6FE),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                '이번 달 혜택 보기',
                style: TextStyle(fontSize: 14, color: Color(0xFF3A6CF4), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardDetailsList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          _buildDetailRow(
            title: '카드번호',
            value: '1234-****-****-3456',
            actionText: '상세 >',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CardViewPage()),
              );
            },
          ),
          _buildDetailRow(
            title: '연회비',
            value: '10,000원',
            actionText: '상세 >',
            onTap: () {},
          ),
          _buildDetailRow(
            title: '결제일',
            value: '13일',
            actionText: '변경 >',
            onTap: () {},
          ),
          _buildDetailRow(
            title: '결제계좌',
            valueWidget: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 8),
                const Text(
                  '신한은행 110-***-******',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
            actionText: '변경 >',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentAccountChangeScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({required String title, String? value, Widget? valueWidget, required String actionText, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: 15, color: Colors.grey[700])),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                valueWidget ?? Text(value ?? '', style: const TextStyle(fontSize: 15, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(actionText, style: TextStyle(fontSize: 13, color: Colors.blue[600], fontWeight: FontWeight.w500)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
