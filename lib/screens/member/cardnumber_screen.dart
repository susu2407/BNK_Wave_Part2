/*
  날짜 : 2025-12-29
  이름 : 고정현
  내용 : 카드 번호 정보 화면
 */

import 'package:flutter/material.dart';

class CardViewPage extends StatelessWidget {
  const CardViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('내 카드 정보'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// 카드 이미지
            Container(
              width: 220,
              height: 360,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey, width: 2),
                image: const DecorationImage(
                  image: AssetImage('assets/images/AMEX_Platinum.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 카드명
            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '신한 Deep Dream',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              '카드타입ㅣ신용',
              style: TextStyle(color: Colors.black),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  _infoRow(
                    title: '카드 번호',
                    value: '1234-5678-9012-3456',
                  ),
                  const Divider(),
                  _infoRow(
                    title: '유효 기간',
                    value: '30/12',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 공통 정보 Row
  Widget _infoRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
