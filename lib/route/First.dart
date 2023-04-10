import 'package:flutter/material.dart';

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute())
            );
            // 눌렀을 때 두 번째 route로 이동합니다.
          },
          
        ),
      ),
    );
  }
  
  RaisedButton({required Text child, required Null Function() onPressed}) {}
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
            // 눌렀을 때 첫 번째 route로 되돌아 갑니다.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
  
  RaisedButton({required Null Function() onPressed, required Text child}) {}
}