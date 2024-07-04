import 'package:flutter/material.dart';

class ErrorMessage extends StatefulWidget {
  late double hight;
  late String message;
  ErrorMessage(this.hight, this.message, {super.key});

  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: widget.hight != 0
          ? const EdgeInsets.only(top: 10)
          : const EdgeInsets.only(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      height: widget.hight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.message,
            textAlign: TextAlign.left,
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}