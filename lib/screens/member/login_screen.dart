/*
  날짜 : 2026-01-05
  내용 : WAVE CARD 로그인 화면
  이름 : 고정현
*/

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/auth/token_storage_service.dart';
import '../../services/member_service.dart';
import '../../services/token_storage_service.dart';
import 'findid_screen.dart';
import 'findpassword_screen.dart';
import 'terms_screen.dart';

// ✅ 본인 프로젝트에 맞게 경로/클래스명 수정
import 'package:bnkpart2/main.dart';
import 'package:bnkpart2/mypage_main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();
  final _pwController = TextEditingController();

  final service = MemberService();
  final tokenStorageService = TokenStorageService();

  bool _loading = false;

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  Future<void> _procLogin() async {
    final usid = _idController.text.trim();
    final pass = _pwController.text;

    if (usid.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이디, 비번 입력하세요.')),
      );
      return;
    }

    if (_loading) return;
    setState(() => _loading = true);

    try {
      // 1) 로그인 API 호출 (현재 프로젝트의 기존 로직 그대로 사용)
      final Map<String, dynamic> jsonData = await service.login(usid, pass);
      final String? accessToken = jsonData['accessToken'] as String?;
      log('accessToken : $accessToken');

      if (accessToken == null || accessToken.trim().isEmpty) {
        throw Exception('로그인 토큰이 없습니다.');
      }

      // 2) 토큰 저장 (Provider + 로컬)
      context.read<AuthProvider>().login(accessToken);
      await tokenStorageService.saveAccessToken(accessToken);

      // 3) ✅ PAYMENT_ACCOUNT 로컬 저장값으로 계좌 보유 여부 판단
      final String? paymentAccount = await tokenStorageService.getPaymentAccount();
      final bool hasAccount = paymentAccount != null; // null이면 계좌 없음

      if (!mounted) return;

      // 4) 분기 이동 (로그인 화면 포함 이전 스택 제거)
      if (hasAccount) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const MainScreen()),
              (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const MyPageMainScreen()),
              (route) => false,
        );
      }
    } catch (err) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err.toString())),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/cardiology.png'),
              const SizedBox(height: 40),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: '아이디 입력',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _pwController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '비밀번호 입력',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: _loading ? null : _procLogin,
                  child: Text(
                    _loading ? '로그인 중...' : '로그인',
                    style: const TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _loading
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => FindIdScreen()),
                      );
                    },
                    child: const Text('아이디 찾기'),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: _loading
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => FindPasswordScreen()),
                      );
                    },
                    child: const Text('PW찾기'),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: _loading
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TermsScreen()),
                      );
                    },
                    child: const Text('회원가입'),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }
}
