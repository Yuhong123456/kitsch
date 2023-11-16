import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


const String backendUrl = 'http://your-server-address/api';


class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Screen'),
      ),
      body: const Center(
        child: Text('Match with other users'),
      ),
    );
  }
}


//发送消息到后端
Future<void> sendMessageToBackend(String message) async {
  final url = Uri.parse('$backendUrl/send_message_to_character_ai');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'message': message}),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    // 这里处理后端返回的数据
  } else {
    // 如果后端返回了错误状态码，可以抛出异常或处理错误
    throw Exception('Failed to send message');
  }
}

//请求匹配用户
Future<Map<String, dynamic>> requestMatch(String userId) async {
  final url = Uri.parse('$backendUrl/request_match');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'user_id': userId}),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data; // 包含匹配用户信息的 Map
  } else {
    throw Exception('Failed to request match');
  }
}

//获取用户消息
Future<List<dynamic>> getMessages(String userId) async {
  final url = Uri.parse('$backendUrl/get_messages?user_id=$userId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['messages']; // 消息列表
  } else {
    throw Exception('Failed to get messages');
  }
}