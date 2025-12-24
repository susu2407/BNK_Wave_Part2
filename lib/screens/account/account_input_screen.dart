/*
  날짜 : 2025-12-24
  이름 : 이수연
  내용 : 계좌 등록
*/

import 'package:flutter/material.dart';
import '../../models/dto/card_view_dto.dart';
import '../models/dto/card_view_dto.dart';

void main() {
  runApp(MaterialApp(
    home: PaymentRegisterScreen(),
  ));
}

class PaymentRegisterScreen extends StatefulWidget {
  // 선택된 카드 정보가 있을 수도 있고(수정/변경), 없을 수도 있음(신규 등록)
  final CardViewDto? selectedCard;

  const PaymentRegisterScreen({super.key, this.selectedCard});

  @override
  State<PaymentRegisterScreen> createState() => _PaymentRegisterScreenState();
}

class _PaymentRegisterScreenState extends State<PaymentRegisterScreen> {
  // 입력 제어를 위한 컨트롤러
  final TextEditingController _accountController = TextEditingController();
  String? _selectedBank;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              "등록하실 결제계좌를\n입력해주세요.",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 30),

            // 1. 카드 정보 요약 영역 (전달받은 DTO 활용)
            _buildCardSummaryBox(),

            const SizedBox(height: 20),

            // 2. 계좌 입력 영역
            _buildInputForm(),

            const Spacer(), // 하단 버튼을 아래로 밀기 위함

            // 3. 다음 버튼
            _buildNextButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 상단 앱바 (뒤로가기, 닫기 버튼)
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text("결제계좌 등록", style: TextStyle(color: Colors.black, fontSize: 16)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
      ],
    );
  }

  // 카드 정보 박스 (DTO가 있으면 정보 노출, 없으면 공백/기본값)
  Widget _buildCardSummaryBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(child: Text("카드\n이미지", textAlign: TextAlign.center, style: TextStyle(fontSize: 10))),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.selectedCard?.basic.cardName ?? "카드 정보 없음",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                widget.selectedCard != null
                    ? "${widget.selectedCard!.basic.cardType} | ${widget.selectedCard!.displaySubTitle}****"
                    : "카드를 선택해주세요",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 결제계좌 입력 폼
  Widget _buildInputForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20,40,20,30),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("결제계좌", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 20),

          // 은행 선택 (Dropdown 방식 예시)
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              hintText: "은행·증권사 선택",
            ),
            items: ["부산은행", "신한은행", "국민은행"].map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (val) => setState(() => _selectedBank = val),
          ),

          const SizedBox(height: 12),

          // 계좌번호 입력
          TextField(
            controller: _accountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "'-'없이 입력",
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),

          const SizedBox(height: 15),
          const Text("• 본인 명의의 계좌로만 변경 가능합니다.", style: TextStyle(fontSize: 11, color: Colors.grey)),
          const Text("• 구.외환은행 계좌의 경우, 하나은행을 선택해 주세요.", style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  // 하단 다음 버튼
  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: (_selectedBank != null && _accountController.text.isNotEmpty)
            ? () { /* 다음 로직 */ }
            : null, // 입력 안되면 비활성화
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.red
        ),
        child: const Text("다음", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}