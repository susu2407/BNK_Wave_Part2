/*
  날짜 : 2025-12-18
  이름 : 이수연
  내용 : 계좌 등록/수정할 카드 선택 화면 - 1

  - 보유 카드 목록 보이기
  - 카드 타입(신용/체크)에 맞게 카드 목록 불러오기
  - 불러온 카드 중 카드 선택 시 카드 리스트 테두리에 강조색 넣어서, 무엇을 선택했는지 시각적으로 보이기
  - 카드 선택 시 하단의 '다음' 버튼 활성화
  - 다음 버튼 눌렀을 때에 -> 선택한 카드에 연결된 계좌 정보를 등록/수정 할 수 있도록 '선택한 카드 정보' 넘기기
  - 다음 버튼 눌렀을 때에, 계좌 입력 화면(account_input_screen)으로 이동

*/
import 'package:bnkpart2/models/dto/account_dto.dart';
import 'package:bnkpart2/screens/payment/card_account_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:bnkpart2/screens/payment/card_list_item_widget.dart';

//void main() {
//  runApp(const MaterialApp(
//    home: PaymentAccountChangeScreen(),
//    debugShowCheckedModeBanner: false,  // 디버그 모드 띠 숨기기 위한 설정
//  ));
//}


// 설계도 역할
class PaymentAccountChangeScreen extends StatefulWidget {
  const PaymentAccountChangeScreen({super.key});

  @override
  State<PaymentAccountChangeScreen> createState() => _PaymentAccountChangeScreenState();
}

// 기억 장치 역할
class _PaymentAccountChangeScreenState extends State<PaymentAccountChangeScreen> {
  int _selectedTab = 0; // 0: 신용, 1: 체크
  int? _selectedCardId; // 테이블의 PK인 MEMBER_CARD_ID를 저장

  final List<Map<String, dynamic>> _myCardList = [
    {
      'MEMBER_CARD_ID': 1,
      'CARD_NAME': 'BNK부산은행 Rex카드',
      'CARD_TYPE': '신용',
      'CARD_NUMBER': '1234-5678-9012-3456',
      'PAYMENT_BANK': '신한',
      'PAYMENT_ACCOUNT': '110-123-456789',
      'CARD_IMAGE_URL': 'https://api.lorem.space/image/creditcard?w=400&h=250&hash=A1B2C3D4',
    },
    {
      'MEMBER_CARD_ID': 2,
      'CARD_NAME': 'BNK부산은행 체크카드',
      'CARD_TYPE': '체크',
      'CARD_NUMBER': '5555-4444-3333-2222',
      'PAYMENT_BANK': '국민',
      'PAYMENT_ACCOUNT': '4567-02-12345',
      'CARD_IMAGE_URL': 'https://api.lorem.space/image/creditcard?w=400&h=250&hash=B2C3D4E5',
    },
    {
      'MEMBER_CARD_ID': 3,
      'CARD_NAME': 'BNK부산은행 Rex카드',
      'CARD_TYPE': '신용',
      'CARD_NUMBER': '9999-0000-1111-2222',
      'PAYMENT_BANK': null,
      'PAYMENT_ACCOUNT': null,
      'CARD_IMAGE_URL': 'https://api.lorem.space/image/creditcard?w=400&h=250&hash=C3D4E5F6',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final String selectedType = _selectedTab == 0 ? '신용' : '체크';
    final List<Map<String, dynamic>> filteredList = _myCardList.where((card) => card['CARD_TYPE'] == selectedType).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text('내 카드의 결제계좌를\n쉽게 변경해보세요.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, height: 1.4)),
                const SizedBox(height: 30),
                _buildToggleTabs(),
                const SizedBox(height: 40),
                const Text('카드   선택', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final cardData = filteredList[index];
                // [수정] 리팩토링된 CardListItemWidget을 개선된 방식으로 호출합니다.
                return CardListItemWidget(
                  cardName: cardData['CARD_NAME'],
                  cardType: cardData['CARD_TYPE'],
                  cardNumber: cardData['CARD_NUMBER'],
                  paymentBank: cardData['PAYMENT_BANK'],
                  paymentAccount: cardData['PAYMENT_ACCOUNT'],
                  cardImageUrl: cardData['CARD_IMAGE_URL'],
                  isSelected: _selectedCardId == cardData['MEMBER_CARD_ID'],
                  onTap: () => setState(() => _selectedCardId = cardData['MEMBER_CARD_ID']),
                );
              },
            ),
          ),
          _buildNoticeSection(),
          _buildBottomButton(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
          '결제계좌',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16
          )
      ),
    );
  }

  Widget _buildToggleTabs() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabItem('신용', 0),
          _buildTabItem('체크', 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _selectedTab = index;
          _selectedCardId = null;
        }),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.black : Colors.black45,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoticeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _noticeRow('청구방식이 통합된 경우, 결제정보는 하나로 보관됩니다.'),
          _noticeRow('점검 시간(23:30~00:00)에는 서비스 이용이 제한될 수 있습니다.'),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _noticeRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text('• $text', style: const TextStyle(fontSize: 12, color: Colors.black38, height: 1.5)),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton(
          onPressed: _selectedCardId != null
              ? () {
                  final selectedCardData = _myCardList.firstWhere((card) => card['MEMBER_CARD_ID'] == _selectedCardId);
                  final dto = AccountInputDto.fromMap(selectedCardData);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardAccountInputScreen(selectedCard: dto),
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFCB2B11),
            disabledBackgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: const Text(
              '다  음',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                  FontWeight.bold,
                  color: Colors.white
              )
          ),
        ),
      ),
    );
  }
}
