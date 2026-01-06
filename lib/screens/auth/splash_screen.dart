/*
  날짜 : 2026-01-05
  이름 : 이수연
  내용 : 앱 시작 화면을 SplashScreen으로 변경
 */

import 'dart:async';
import 'package:bnkpart2/screens/member/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 1.5초 후에 LoginScreen으로 이동
    Timer(const Duration(milliseconds: 6000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 로딩 중임을 나타내는 간단한 UI
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 여기에 앱 로고 이미지를 추가하기.
            Image.asset('assets/images/WAVECARD_logo_width.png'),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}