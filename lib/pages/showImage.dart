import 'package:flutter/material.dart';
import 'package:test/utils/colors.dart';

class ShowImage extends StatelessWidget {
  final String url;
  const ShowImage({super.key, required String this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.network(url, height: 300, width: 300),
        ),
      ),
    );
  }
}
