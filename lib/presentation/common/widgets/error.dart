import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class Error extends StatelessWidget {
  final String message;
  final VoidCallback callback;

  const Error({
    required this.message,
    required this.callback,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 20.0),
          CustomButton(
            title: 'Retry',
            onTap: () => callback,
          )
        ],
      ),
    );
  }
}