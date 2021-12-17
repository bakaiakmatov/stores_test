import 'package:flutter/material.dart';

class TryAgain extends StatelessWidget {
  const TryAgain({Key? key, this.message, this.tryAgain}) : super(key: key);
  final String? message;
  final Function? tryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.error, size: 60),
          const SizedBox(height: 16),
          Text(message!),
          const SizedBox(height: 32),
          TextButton(onPressed: () => tryAgain, child: const Text('Повторить'))
        ],
      ),
    );
  }
}
