/*
  날짜 : 2025-12-29
  이름 : 고정현
  내용 : 아이디 찾기 화면

  날짜 : 2025-12-30
  이름 : 이수연
  내용 : 오류 주석 처리 해놓음
 */
import 'package:flutter/material.dart';

class FindIdScreen extends StatefulWidget {
  const FindIdScreen({super.key});

  @override
  State<FindIdScreen> createState() => _FindIdScreenState();
}

class _FindIdScreenState extends State<FindIdScreen> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _hpController = TextEditingController();

  bool _found = false;
  String _foundId = '';

  void _findId() async {
    if (!_formKey.currentState!.validate()) return;

    /*try {
      final loginId = await service.findId(
        _nameController.text,
        _emailController.text,
      );

      setState(() {
        _found = true;
        _foundId = loginId;
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('일치하는 정보가 없습니다.')),
      );
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('아이디 찾기')),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text('아이디 찾기', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),

              /// 이름
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '이름',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이름을 입력하세요';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              /// 이메일
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

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: _findId,
                  child: const Text('아이디 찾기'),
                ),
              ),

              const SizedBox(height: 30),

              /// 결과 영역
              if (_found)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '입력하신 정보로 조회된 아이디는\n\n$_foundId 입니다.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hpController.dispose();
    super.dispose();
  }
}
