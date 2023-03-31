import 'package:flutter/material.dart';

Row errorMessage(bool isTrue, String message) {
  return Row(
    children: [
      Container(
        child: Icon(
          isTrue ? Icons.check : Icons.close,
          color: isTrue ? Colors.green : Colors.red,
        ),
      ),
      Container(
        child: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isTrue ? Colors.green : Colors.red,
          ),
        ),
      ),
    ],
  );
}

int currentStep = 1;
