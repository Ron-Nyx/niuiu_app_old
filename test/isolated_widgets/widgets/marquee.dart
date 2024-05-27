import 'package:flutter/material.dart';
import 'dart:async';

class MarqueeController {
  Function(String)? _onAddString;

  void addString(String str) {
    _onAddString?.call(str);
  }

  void _bindAddStringFunction(Function(String) onAddString) {
    _onAddString = onAddString;
  }
}

void main() {
  final MarqueeController controller = MarqueeController();
  // Timer.periodic(Duration(milliseconds: 200), (timer) => controller.addString('Test'));
  runApp(Marquee(controller: controller));
}

class Marquee extends StatefulWidget {
  final MarqueeController controller;

  Marquee({Key? key, required this.controller}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Marquee> {
  final List<String> _strings = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.controller._bindAddStringFunction(_addString);
    _strings.addAll(List.filled(20, ''));
  }

  void _addString(String str) {
    setState(() {
      _strings.add(str);
    });
    _animateList();
  }

  void _animateList() {
    if (_scrollController.hasClients) {
      final offset = _scrollController.position.maxScrollExtent + 10.0; // Adjust for speed and distance
      _scrollController.animateTo(
        offset,
        duration: Duration(seconds: 1),
        curve: Curves.linear,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Marquee-like String Slider')),
        body: Column(
          children: [
            Container(
              color: Colors.grey[600],
              height: 50, // Adjust the height for your use case
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: _strings.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 50, // Adjust the width for each string
                    child: Center(child: Text('${_strings[index]}')),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => widget.controller.addString('Test'), // Example usage
              child: Text('Add String'),
            ),
          ],
        ),
      ),
    );
  }
}
