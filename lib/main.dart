/*
  날짜 : 2026-01-05
  이름 : 이수연
  내용 :
    - 앱 시작 화면을 SplashScreen으로 변경
    - 화면 연결
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bnkpart2/providers/auth_provider.dart';
import 'package:bnkpart2/screens/auth/splash_screen.dart';

void main() {
  runApp(
    /// Provider 등록
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WAVE CARD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // 앱의 첫 화면을 SplashScreen으로 설정
    );
  }
}
