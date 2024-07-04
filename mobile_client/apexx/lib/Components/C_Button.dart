import 'package:flutter/material.dart';

class CButton extends StatefulWidget {
  late String title;
  late Function onPress;
  CButton(this.title, this.onPress, {super.key});

  @override
  State<CButton> createState() => _CButtonState();
}

class _CButtonState extends State<CButton> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onPress(),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xffeeb51d)),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 1,),
          Text(
  
            widget.title.toString(),
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                fontFamily: "open sans"),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black87,
          )
        ],
      ),
    );
  }
}
