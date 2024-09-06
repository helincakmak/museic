import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback? onPressed;  // onPressed işlevi nullable (null olabilen)
  final String title;
  final double? height;  // height nullable (null olabilen)

  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,  // onPressed burada nullable olabilir
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80),  // height null ise varsayılan 80
      ),
      child: Text(title),
    );
  }
}
