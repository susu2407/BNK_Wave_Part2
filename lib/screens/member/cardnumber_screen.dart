/*
  날짜 : 2025-12-29
  이름 : 이수연
  내용 : 내 카드 화면, 재사용을 위해 파일 분리
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
        title: const Text('내 카드'),
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
                color: Colors.grey.shade100,
              ),
              alignment: Alignment.center,
              child: const Text(
                '카드\n이미지',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            /// 카드명 버튼
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
                  '카드명',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              '카드타입(신용, 체크)',
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
                    value: '5274-****-****-3389',
                  ),
                  const Divider(),
                  _infoRow(
                    title: '유효 기간',
                    value: 'YY/DD/MM',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            //버튼
            SizedBox(
              width: double.infinity,
              height: 42,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: 카드번호 전체 보기 로직
                },
                icon: const Icon(Icons.visibility, size: 18),
                label: const Text(
                  '카드 번호 보기',
                  style: TextStyle(fontSize: 14),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
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
