/*
  날짜 : 2025-12-29
  이름 : 고정현
  내용 : 회원가입 화면

  수정 : main 화면 연결하면서 발생한 오류 수정.
        - 회원가입 완료 시, 로그인 화면으로 이동.
 */

import 'dart:developer';
import 'package:flutter/material.dart';

import '../../models/entity/member.dart';
import '../../services/member/member_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  /* ─────────────────────────────────
   * Form / Scroll
   * ───────────────────────────────── */
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  /* ─────────────────────────────────
   * 기본 정보
   * ───────────────────────────────── */
  final _nameController = TextEditingController();
  final _loginIdController = TextEditingController();
  final _pass1Controller = TextEditingController();
  final _pass2Controller = TextEditingController();

  /* ─────────────────────────────────
   * 영문 이름
   * ───────────────────────────────── */
  final _engLastNameController = TextEditingController();
  final _engFirstNameController = TextEditingController();

  /* ─────────────────────────────────
   * 주민등록번호
   * ───────────────────────────────── */
  final _rrnFrontController = TextEditingController();
  final _rrnBackController = TextEditingController();

  /* ─────────────────────────────────
   * 연락처
   * ───────────────────────────────── */
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  /* ─────────────────────────────────
   * 추가 정보
   * ───────────────────────────────── */
  DateTime? _birthDate;
  final _ageController = TextEditingController();
  String _gender = 'M';

  /* ─────────────────────────────────
   * 통신사
   * ───────────────────────────────── */
  bool _carrierExpanded = false;
  String? _selectedCarrier;

  final List<String> carriers = [
    'KT',
    'SKT',
    'LGU',
    'KT알뜰폰',
    'SKT알뜰폰',
    'LGU알뜰폰',
  ];

  /* ─────────────────────────────────
   * 주소
   * ───────────────────────────────── */
  final _postalCodeController = TextEditingController();
  final _addressController = TextEditingController();
  final _addressDetailController = TextEditingController();

  final _service = MemberService();

  /* ─────────────────────────────────
   * Submit
   * ───────────────────────────────── */
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_birthDate == null || _selectedCarrier == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('필수 항목을 모두 입력하세요')),
      );
      return;
    }

    final member = Member(
      memberId: 0, // 서버(DB 시퀀스)에서 생성
      loginId: _loginIdController.text,
      password: _pass1Controller.text,
      memberName: _nameController.text,
      lastNameEn: _engLastNameController.text,
      firstNameEn: _engFirstNameController.text,
      birth: _birthDate!,
      rrn: '${_rrnFrontController.text}-${_rrnBackController.text}',
      gender: _gender,
      phoneNumber: _phoneController.text,
      mobileCarrier: _selectedCarrier!,
      email: _emailController.text.isEmpty ? null : _emailController.text,
      postalCode: _postalCodeController.text.isEmpty ? null : _postalCodeController.text,
      address: _addressController.text.isEmpty ? null : _addressController.text,
      addressDetail: _addressDetailController.text.isEmpty ? null : _addressDetailController.text,
      createdAt: DateTime.now(),
      memberStatus: 'ACTIVE',
    );


    log('member json: ${member.toJson()}');

    try {
      await _service.register(member);
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('회원가입 완료')));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (_) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('에러 발생: $e')));
    }
  }

  /* ─────────────────────────────────
   * UI
   * ───────────────────────────────── */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('기본 정보'),
              _input(_nameController, '이름'),
              _input(_loginIdController, '아이디'),
              _input(_pass1Controller, '비밀번호', obscure: true),
              _input(_pass2Controller, '비밀번호 확인', obscure: true),

              _sectionTitle('영문 이름'),
              _input(_engLastNameController, '영문 성'),
              _input(_engFirstNameController, '영문 이름'),

              _sectionTitle('주민등록번호'),
              Row(
                children: [
                  Expanded(
                    child: _input(
                      _rrnFrontController,
                      '앞 6자리',
                      keyboard: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _input(
                      _rrnBackController,
                      '뒤 7자리',
                      keyboard: TextInputType.number,
                      obscure: true,
                    ),
                  ),
                ],
              ),

              _sectionTitle('연락처'),
              _carrierSelector(),
              _input(_phoneController, '휴대폰 번호'),
              _input(_emailController, '이메일'),

              _sectionTitle('추가 정보'),
              _birthPicker(),
              _input(_ageController, '나이', keyboard: TextInputType.number),
              _genderDropdown(),

              _sectionTitle('주소'),
              _input(_postalCodeController, '우편번호'),
              _input(_addressController, '주소'),
              _input(_addressDetailController, '상세주소'),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('가입'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* ─────────────────────────────────
   * Components
   * ───────────────────────────────── */
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _input(
      TextEditingController controller,
      String label, {
        bool obscure = false,
        TextInputType keyboard = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (v) =>
        v == null || v.isEmpty ? '$label 입력 필수' : null,
      ),
    );
  }

  Widget _birthPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('생년월일'),
        const SizedBox(height: 5),
        InkWell(
          onTap: () async {
            final d = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (d != null) setState(() => _birthDate = d);
          },
          child: InputDecorator(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            child: Text(
              _birthDate == null
                  ? '선택'
                  : '${_birthDate!.year}-${_birthDate!.month}-${_birthDate!.day}',
            ),
          ),
        ),
      ],
    );
  }

  Widget _genderDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _gender,
      decoration: const InputDecoration(labelText: '성별'),
      items: const [
        DropdownMenuItem(value: 'M', child: Text('남')),
        DropdownMenuItem(value: 'F', child: Text('여')),
      ],
      onChanged: (v) => setState(() => _gender = v!),
    );
  }

  Widget _carrierSelector() {
    return Column(
      children: [
        InkWell(
          onTap: () =>
              setState(() => _carrierExpanded = !_carrierExpanded),
          child: InputDecorator(
            decoration: const InputDecoration(labelText: '통신사'),
            child: Text(_selectedCarrier ?? '선택'),
          ),
        ),
        if (_carrierExpanded)
          ...carriers.map(
                (c) => ListTile(
              title: Text(c),
              onTap: () {
                setState(() {
                  _selectedCarrier = c;
                  _carrierExpanded = false;
                });
              },
            ),
          ),
      ],
    );
  }

  /* ─────────────────────────────────
   * Dispose
   * ───────────────────────────────── */
  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _loginIdController.dispose();
    _pass1Controller.dispose();
    _pass2Controller.dispose();
    _engLastNameController.dispose();
    _engFirstNameController.dispose();
    _rrnFrontController.dispose();
    _rrnBackController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _postalCodeController.dispose();
    _addressController.dispose();
    _addressDetailController.dispose();
    super.dispose();
  }
}