/*
  날짜 : 2025-12-29
  이름 : 고정현
  내용 : 로그인 화면
 */

import 'package:flutter/material.dart';
import 'package:bnkpart2/screens/member/register_screen.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen>
    with TickerProviderStateMixin {

  bool _allChecked = false;

  bool _termsService = false;
  bool _termsPrivacy = false;
  bool _termsMarketing = false;

  // 펼침 상태
  bool _serviceExpanded = false;
  bool _privacyExpanded = false;
  bool _marketingExpanded = false;

  void _syncAllChecked() {
    _allChecked = _termsService && _termsPrivacy && _termsMarketing;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('약관')),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [

            /// 전체 동의
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Checkbox(
                value: _allChecked,
                onChanged: (value) {
                  setState(() {
                    _allChecked = value ?? false;
                    _termsService = _allChecked;
                    _termsPrivacy = _allChecked;
                    _termsMarketing = _allChecked;
                  });
                },
              ),
              title: const Text('전체 약관에 동의합니다.'),
            ),

            const Divider(),

            /// 사이트 이용약관
            _buildTermsItem(
              title: '사이트 이용약관',
              isRequired: true,
              value: _termsService,
              expanded: _serviceExpanded,
              onToggle: () {
                setState(() => _serviceExpanded = !_serviceExpanded);
              },
              onChanged: (v) {
                setState(() {
                  _termsService = v ?? false;
                  _syncAllChecked();
                });
              },
              content: '사이트 이용약관 상세 내용입니다.\n여기에 약관 전문이 들어갑니다.',
            ),

            /// 개인정보 취급방침
            _buildTermsItem(
              title: '개인정보 취급방침',
              isRequired: true,
              value: _termsPrivacy,
              expanded: _privacyExpanded,
              onToggle: () {
                setState(() => _privacyExpanded = !_privacyExpanded);
              },
              onChanged: (v) {
                setState(() {
                  _termsPrivacy = v ?? false;
                  _syncAllChecked();
                });
              },
              content: '개인정보 수집 및 이용에 대한 상세 내용입니다.',
            ),

            /// 마케팅 수신 동의
            _buildTermsItem(
              title: '마케팅 수신 동의',
              isRequired: false,
              value: _termsMarketing,
              expanded: _marketingExpanded,
              onToggle: () {
                setState(() => _marketingExpanded = !_marketingExpanded);
              },
              onChanged: (v) {
                setState(() {
                  _termsMarketing = v ?? false;
                  _syncAllChecked();
                });
              },
              content: '이벤트, 할인 정보 수신에 대한 안내 내용입니다.',
            ),

            const Spacer(),

            /// 버튼
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: (_termsService && _termsPrivacy)
                    ? () {
                  //Navigator.pushReplacement(
                    //context,
                    //MaterialPageRoute(
                      //builder: (_) => const RegisterScreen(),
                    //),
                  //);
                }
                    : null,
                child: const Text('동의하고 회원가입 계속'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 약관 아이템 (아코디언)
  Widget _buildTermsItem({
    required String title,
    required bool isRequired,
    required bool value,
    required bool expanded,
    required VoidCallback onToggle,
    required ValueChanged<bool?> onChanged,
    required String content,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(value: value, onChanged: onChanged),
            Expanded(
              child: Text('$title ${isRequired ? '(필수)' : '(선택)'}'),
            ),
            GestureDetector(
              onTap: onToggle,
              child: AnimatedRotation(
                turns: expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
          ],
        ),

        /// 펼쳐지는 영역
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: expanded
              ? Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 8),
            color: Colors.grey.shade100,
            child: Text(
              content,
              style: const TextStyle(fontSize: 13),
            ),
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
