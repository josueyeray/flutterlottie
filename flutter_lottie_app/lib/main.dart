import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow, background: const Color.fromARGB(255, 30, 41, 59), primary: Colors.blue, outline: Colors.blue, onSurfaceVariant: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter lottie animations'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController animationController;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  void onRecordPress() {
    if (!isCompleted) {
      isCompleted = true;
      animationController.forward();
    } else {
      isCompleted = false;
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset('assets/loginheader.json', width: 300, height: 300),
              const TextField(decoration: InputDecoration(labelText: 'enter username'),),
              const TextField(obscureText: true, decoration: InputDecoration(labelText: "enter password"),),
              Padding(padding: const EdgeInsets.all(30), 
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('awesome login success')));
                    }, 
                  child: const Text("login")
                )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onRecordPress,
        child: Lottie.asset('assets/record.json', 
          width: 75, 
          height: 75,
          fit: BoxFit.contain,
          controller: animationController,
          onLoaded: (composition) {
            animationController.duration = composition.duration;
          }),
        ),
      );
  }
}
