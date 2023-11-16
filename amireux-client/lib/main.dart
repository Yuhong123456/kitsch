import 'package:flutter/material.dart';
// 确保以下文件存在于您的项目中，并且包含正确的页面定义
import 'chat_screen.dart'; 
import 'analysis_screen.dart';
import 'match_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AmIreux',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomeAfterDelay();
  }

  void _navigateToHomeAfterDelay() async {
    await Future.delayed(const Duration(seconds: 5));
    _navigateToHome();
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyHomePage(title: 'AmIreux Home Page')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/images/open.gif'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/homepage.png'), // 替换为您的背景图片路径
            fit: BoxFit.cover,
          ),
        ),
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNavigationButton(context, 'chat.gif', 'Chat with AI', const ChatScreen()),
            const SizedBox(height: 60),
            _buildNavigationButton(context, 'letter.gif', 'View Analysis', const AnalysisScreen()),
            const SizedBox(height: 60),
            _buildNavigationButton(context, 'matching.gif', 'Find Matches', const MatchScreen()),
          ],
        )
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String gifAsset, String label, Widget nextPage) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransitionScreen(gifAsset: 'assets/images/$gifAsset', nextPage: nextPage))),
      child: Text(label),
    );
  }
}

class TransitionScreen extends StatefulWidget {
  final String gifAsset;
  final Widget nextPage;

  const TransitionScreen({Key? key, required this.gifAsset, required this.nextPage}) : super(key: key);

  @override
  _TransitionScreenState createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 5)); // Adjust the duration as needed
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => widget.nextPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(widget.gifAsset),
      ),
    );
  }
}
