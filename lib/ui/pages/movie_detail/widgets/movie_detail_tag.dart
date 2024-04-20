import 'package:flutter/material.dart';

class MovieDetailTag extends StatelessWidget {
  const MovieDetailTag({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return _widget(tag);
  }

  Widget _widget(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          tag,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
