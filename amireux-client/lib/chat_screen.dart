import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'connectbacken';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = [{
            "text": "Hi, i'm your chatbot. Can you introduce yourself a little bit so I can assist you better?",
            "isUser": false,
          }];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(hintText: 'Send a message'),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, index) {
                final message = _messages[index];
                final isUserMessage = message['isUser'];
                return Row(
                  mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    if (!isUserMessage) ...[
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/ai_avatar.png'),  // AI 头像图片
                      ),
                      const SizedBox(width: 8),
                    ],
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message["text"],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    if (isUserMessage) ...[
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user_avatar.png'),  // 用户头像图片
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }

  // 异步
void _handleSubmitted(String text) async {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({"text": text, "isUser": true});
      });
      _textController.clear();

      try {
        final aiResponse = await sendMessage(text);
        setState(() {
          _messages.add({
            "text": aiResponse,
            "isUser": false,
          });
        });
        _scrollToBottom();
      } catch (e) {
        print('Error sending message to the server: $e');
      }
    }
  }

  // 滚动到底部的逻辑
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

}
 