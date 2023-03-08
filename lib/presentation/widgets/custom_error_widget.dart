import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? error;
  final VoidCallback? onRetry;

  const CustomErrorWidget({super.key, this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/ic_error.png', height: 100),
          const SizedBox(height: 10),
          Text(
            error ?? 'Something went wrong',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Background color
              ),
              child: const Text('Try Again'),
            ),
          ],
        ],
      ),
    );
  }
}