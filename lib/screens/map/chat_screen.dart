import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isMe;
  final DateTime time;

  Message({
    required this.text,
    required this.isMe,
    required this.time,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];

  // 자동 응답 리스트 (순서대로 사용)
  final List<String> _autoReplies = [
    '주로 사용하시는 소비 항목이 무엇인가요? (예: 교통, 쇼핑, 카페)',
    '월 평균 카드 사용 금액이 어느 정도 되시나요?',
    '연회비는 어느 정도까지 괜찮으신가요?',
    '말씀해주신 조건 기준으로 추천드릴게요.',
    '해당 카드는 생활비 할인에 강점이 있어요.',
    '전월 실적은 30만 원 이상부터 혜택이 적용됩니다.',
    '주요 혜택은 카페·배달·대중교통 할인입니다.',
    '이 카드 외에도 비슷한 조건의 카드가 하나 더 있어요.',
    '추가로 궁금하신 점 있으시면 말씀해 주세요.',
  ];

  int _replyIndex = 0;

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();

    // 내 메시지
    setState(() {
      _messages.add(
        Message(
          text: text,
          isMe: true,
          time: DateTime.now(),
        ),
      );
    });

    // 자동 응답 (순서대로)
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        _messages.add(
          Message(
            text: _autoReplies[_replyIndex],
            isMe: false,
            time: DateTime.now(),
          ),
        );

        _replyIndex = (_replyIndex + 1) % _autoReplies.length;
      });
    });
  }

  String _formatTime(DateTime time) {
    final period = time.hour < 12 ? '오전' : '오후';
    int hour = time.hour % 12;
    if (hour == 0) hour = 12;
    return '$period $hour:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WAVE',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
        message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
          ],
          if (message.isMe)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                _formatTime(message.time),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
            ),
          Flexible(
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color:
                message.isMe ? const Color(0xFFFAE100) : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message.text,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          if (!message.isMe)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                _formatTime(message.time),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.grey),
                onPressed: () {},
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: '메시지를 입력하세요',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send,
                    color: Color(0xFFFAE100)),
                onPressed: () =>
                    _handleSubmitted(_textController.text),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
