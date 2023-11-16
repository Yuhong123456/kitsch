import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  late Future<String> _message;

  @override
  void initState() {
    super.initState();
    _message = _fetchLatestMessage();
  }

  Future<String> _fetchLatestMessage() async {
    var url = Uri.parse('http://127.0.0.1:5000/get_analysis'); // 替换为您的后端 URL
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // 假设返回的是一个 JSON 对象，其中有一个字段为 message
      var data = json.decode(response.body);
      return data['message'];
    } else {
      // 处理错误情况
      throw Exception('Failed to load message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Analysis'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _message,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // 数据成功加载后显示
              return Text(snapshot.data ?? 'No message received');
            }
          },
        ),
      ),
    );
  }
}
