/*
  날짜 : 2026-01-05
  이름 : 이수연
  내용 : 내 카드 관리 화면을 구현
 */

import 'package:flutter/material.dart';

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
            _buildTopButton(),
            const SizedBox(height: 12),
            _buildMainCard(context),
            const SizedBox(height: 24),
            _buildCardDetailsList(),
            const SizedBox(height: 12),
            _buildBenefitLink(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: const Text(
            '전체 보유카드',
            style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
      ],
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
              Image.asset(
                'assets/images/WAVECARD_logo.png', // TODO: 실제 카드 이미지 경로로 수정
                width: 35,
                height: 56,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '신용 | MASTER | 이*연 | 후불교통카드',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '카카오뱅크 개인사업자 삼성카드',
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
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                '카드상세',
                style: TextStyle(fontSize: 14, color: Colors.blue.shade700, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardDetailsList() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          _buildDetailRow(
            title: '카드번호',
            value: '5242-83**-****-3692',
            actionText: '상세 >',
            onTap: () {},
          ),
          _buildDetailRow(
            title: '연회비',
            value: '15,000원',
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
            valueWidget: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // TODO: 카카오뱅크 로고 이미지로 교체
                Image.network('https://t1.kakaocdn.net/kakaocorp/kakaobank/ci/symbol_black.png', height: 16),
                const SizedBox(width: 8),
                const Text(
                  '카카오뱅크 33332897*****',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
            actionText: '변경 >',
            onTap: () {},
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0), // Align with top line of value
              child: Text(title, style: TextStyle(fontSize: 15, color: Colors.grey[700])),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                valueWidget ?? Text(value ?? '', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(actionText, style: TextStyle(fontSize: 13, color: Colors.blue[600], fontWeight: FontWeight.w500)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitLink(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: 내가 받은 카드 혜택 화면으로 이동
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('내가 받은 카드혜택', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[500]),
          ],
        ),
      ),
    );
  }
}
