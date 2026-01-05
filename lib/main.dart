/*
  날짜 : 2025-12-17
  내용 : WAVE CARD 메인 화면

  날짜 : 2025-12-29
  내용 : 마이페이지 테스트를 위한 임시 버튼 추가
  이름 : 박효빈
*/

import 'package:bnkpart2/screens/member/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bnkpart2/providers/auth_provider.dart';
import 'package:bnkpart2/screens/mypage/my_main.dart';

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
      home: const MyHomePage(title: 'WAVE CARD 테스트'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 로그인 상태 표시
            // 로그인 상태 표시
            Text(
              authProvider.isLoggedIn ? '로그인 상태' : '로그아웃 상태',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 40),

// 로그인 화면 이동 / 로그아웃 버튼
            ElevatedButton(
              onPressed: () async {
                if (authProvider.isLoggedIn) {
                  authProvider.logout();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('로그아웃 되었습니다')),
                  );
                } else {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );

                  // (선택) 돌아왔을 때 상태에 따라 메시지 표시
                  if (authProvider.isLoggedIn) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('로그인 되었습니다')),
                    );
                  }
                }
              },
              child: Text(authProvider.isLoggedIn ? '로그아웃' : '로그인 화면으로'),
            ),
            const SizedBox(height: 20),

            // 마이페이지로 이동 버튼
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyMain()),
                );
              },
              icon: const Icon(Icons.person),
              label: const Text('마이페이지로 이동'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}