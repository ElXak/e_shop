import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({
    Key key,
    this.title,
    this.body,
  }) : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );
  }
}
