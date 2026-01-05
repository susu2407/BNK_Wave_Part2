import 'dart:developer';

import 'package:bnkpart2/models/dto/account_dto.dart';
import 'package:bnkpart2/screens/mypage/my_main.dart';
import 'package:bnkpart2/screens/payment/card_account_input_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bnkpart2/screens/member/terms_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/auth/token_storage_service.dart';
import '../../services/member/member_service.dart';
import 'findid_screen.dart';
import 'findpassword_screen.dart';

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

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  void _procLogin() async {

    final usid = _idController.text;
    final pass = _pwController.text;

    if(usid.isEmpty || pass.isEmpty){
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디, 비번 입력하세요.'))
      );
      return;
    }

    // [임시 추가] 백엔드 없이 로그인이 되도록 하자.
    try {
      // [수정] 현재는 실제 서버 통신이 아닌 목업 서비스입니다.
      Map<String, dynamic> jsonData = await service.login(usid, pass);
      String? accessToken = jsonData['accessToken'];
      log('accessToken : $accessToken');

      if(accessToken != null && mounted){
        // 토큰 저장(Provider로 저장)
        context.read<AuthProvider>().login(accessToken);

        // [수정] 로그인 성공 후, 사용자 유형에 따라 다른 화면으로 이동합니다.
        if (usid == 'type1') {
          // Type 1: 계좌 등록된 사용자 -> 마이페이지 메인으로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyMain()),
          );
        } else {
          // Type 2: 계좌 미등록 사용자 -> 계좌 등록 화면으로 이동 (임시 데이터 사용)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CardAccountInputScreen(
                selectedCard: AccountInputDto(
                    cardId: 4,
                    cardName: 'BNK 부산은행 체크카드',
                    cardType: '체크',
                    cardNumber: '9410-1234-****-****',
                    cardImageUrl: 'https://api.lorem.space/image/creditcard?w=400&h=250&hash=C3D4E5F6',
                 ),
              ),
            ),
          );
        }
      }

    }catch(err){
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString()))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // [수정] 배경색을 흰색으로 지정
      appBar: AppBar(title: const Text(''),),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/WAVECARD_logo_width.png'),
              const SizedBox(height: 40,),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                labelText: '아이디 입력',
                border: OutlineInputBorder()
              ),),
              const SizedBox(height: 20,),
              TextField(
                controller: _pwController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호 입력',
                  border: OutlineInputBorder()
              ),),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: _procLogin,
                  child: const Text('로그인', style: TextStyle(fontSize: 18, color: Colors.black),)
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => FindIdScreen()),
                      );
                    },
                    child: const Text('아이디 찾기'),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => FindPasswordScreen()),
                      );
                    },
                    child: const Text('PW찾기'),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
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
