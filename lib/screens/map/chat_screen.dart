import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isMe;
  final DateTime time;

  Message({required this.text, required this.isMe, required this.time});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  // 예시 채팅 제거 - 빈 리스트로 시작
  final List<Message> _messages = [];

  // ============================================
  // 자동 응답 메시지 리스트
  // ============================================
  final List<String> _autoReplies = [
    '그렇구나!',
    '오 재밌네요 ㅋㅋ',
    '진짜요?',
    '좋아요!',
    '알겠습니다 👍',
    '오케이~',
    'ㅇㅇ 맞아',
    '그럼요!',
    '완전 공감이에요',
    '저도 그렇게 생각해요',
    '헐 대박',
    '우와 신기하다',
    '아하 그렇군요',
    '넵넵',
    '고마워요 😊',
  ];

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();

    // 내 메시지 추가
    setState(() {
      _messages.add(Message(
        text: text,
        isMe: true,
        time: DateTime.now(),
      ));
    });

    // ============================================
    // 자동 응답 부분 (1~3초 후 임의의 답변 전송)
    // ============================================
    Future.delayed(Duration(seconds: 1 + (DateTime.now().millisecond % 3)), () {
      if (mounted) {
        setState(() {
          // 랜덤으로 응답 메시지 선택
          final randomReply = _autoReplies[DateTime.now().millisecond % _autoReplies.length];

          _messages.add(Message(
            text: randomReply,
            isMe: false, // 상대방 메시지
            time: DateTime.now(),
          ));
        });
      }
    });
    // ============================================
  }

  String _formatTime(DateTime time) {
    String period = time.hour < 12 ? '오전' : '오후';
    int hour = time.hour > 12 ? time.hour - 12 : time.hour;
    if (hour == 0) hour = 12;
    return '$period ${hour}:${time.minute.toString().padLeft(2, '0')}';
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
                  '친구',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '2',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: message.isMe
                    ? const Color(0xFFFAE100)
                    : Colors.white,
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
                icon: const Icon(Icons.sentiment_satisfied_alt,
                    color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xFFFAE100)),
                onPressed: () => _handleSubmitted(_textController.text),
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