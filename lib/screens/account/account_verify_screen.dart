/*
  날짜 : 2025-12-24
  이름 : 이수연
  내용 : 계좌 등록을 위한 본인 인증
*/
import 'package:flutter/material.dart';

import 'account_success_screen.dart';

void main() {
  runApp(MaterialApp(
    home: PhoneAuthScreen(),
  ));
}

// 1. 인증 단계를 관리하기 위한 열거형
enum AuthStep { terms, phoneInput, codeInput, completed }

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  // 현재 단계 상태
  AuthStep _currentStep = AuthStep.terms;

  // 입력 컨트롤러
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _authCodeController = TextEditingController();

  // 동의 여부 상태
  bool _isAllAgreed = false;

  // 통신사 선택을 위한 변수 및 목록
  String? _selectedAgency;
  final List<String> _agencies = ['SKT', 'KT', 'LG U+', 'SKT 알뜰폰', 'KT 알뜰폰', 'LG U+ 알뜰폰'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView( // 키보드 올라올 때를 대비해 스크롤 추가
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              "본인 인증 약관에 동의하고\n휴대폰 인증을 해주세요.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 30),

            // [STEP 1] 약관 동의 영역
            _buildTermsStep(),

            // [STEP 2] 통신사 및 휴대폰 번호 입력 (약관 동의 시 노출)
            if (_currentStep.index >= AuthStep.phoneInput.index)
              _buildPhoneInputStep(),

            // [STEP 3] 인증번호 입력 (인증번호 요청 시 노출)
            if (_currentStep.index >= AuthStep.codeInput.index)
              _buildCodeInputStep(),

            const SizedBox(height: 10), // 여백 확보

          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: _buildNextButton(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  // 약관 동의 위젯
  Widget _buildTermsStep() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _currentStep == AuthStep.terms ? Colors.cyan[50] : Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Checkbox(
            value: _isAllAgreed,
            onChanged: (val) {
              setState(() {
                _isAllAgreed = val!;
                if (_isAllAgreed) _currentStep = AuthStep.phoneInput;
              });
            },
          ),
          const Text("휴대폰 인증 전체 동의", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // 통신사 선택 및 휴대폰 번호 입력 위젯
  Widget _buildPhoneInputStep() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _currentStep == AuthStep.phoneInput ? Colors.green[50] : Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            const Text("통신사", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),

            // [수정된 부분] 직접 작성 대신 선택하는 드롭다운
            DropdownButtonFormField<String>(
              value: _selectedAgency,
              decoration: const InputDecoration(
                hintText: "통신사 선택",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              items: _agencies.map((agency) {
                return DropdownMenuItem(value: agency, child: Text(agency));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAgency = value;
                });
              },
            ),

            const SizedBox(height: 20),
            const Text("휴대폰번호", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "010-0000-0000",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _selectedAgency != null && _phoneController.text.isNotEmpty
                      ? () => setState(() => _currentStep = AuthStep.codeInput)
                      : null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text("인증번호 요청"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 인증번호 입력 위젯
  Widget _buildCodeInputStep() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _authCodeController,
            decoration: InputDecoration(
              labelText: "인증번호 입력",
              suffixIcon: TextButton(onPressed: () {}, child: const Text("시간 연장")),
            ),
          ),
          const SizedBox(height: 8),
          const Text("인증번호를 받지 못했다면?", style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  // 하단 공통 버튼
  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isAllAgreed ? () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentCompleteScreen(
                selectedCard: null,
                changedBank: '',
                changedAccount: '',
              ),
            ),
          );
        }
        : null, // 동의 안 하면 버튼 비활성화
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          disabledBackgroundColor: Colors.grey[300],
        ),
        child: const Text("다음", style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _currentStep == AuthStep.completed ? () {} : null,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: const Text("다음", style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
    );
  }

}
