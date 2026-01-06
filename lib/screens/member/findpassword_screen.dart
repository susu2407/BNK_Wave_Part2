/*
  날짜 : 2025-12-29
  이름 : 고정현
  내용 : 비밀번호 찾기 화면
 */

import 'package:flutter/material.dart';

class FindPasswordScreen extends StatelessWidget {
  const FindPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 찾기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              '본인 확인',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              '이메일 인증을 통해 비밀번호를 재설정합니다.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 25),

            /// 아이디
            TextField(
              decoration: const InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            /// 이메일 + 인증요청 버튼
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: '이메일',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {}, // UI만
                    child: const Text('인증요청'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// 인증번호 + 인증완료 버튼
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: '이메일 인증번호',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {}, // UI만
                    child: const Text('인증완료'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Divider(),

            const SizedBox(height: 20),

            const Spacer(),

            /// 다음 버튼
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {}, // 다음 단계 이동 예정
                child: const Text('다음'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
