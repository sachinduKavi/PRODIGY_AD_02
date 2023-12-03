import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';


void main() {
  runApp(const ToDo());
}


class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
