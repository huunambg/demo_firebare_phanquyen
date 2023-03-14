import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onpressed, this.text});
  final GestureTapCancelCallback? onpressed;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(15)),
        height: 60,
        width: 250,
        child: TextButton(
          child: Text("$text"),
          onPressed: onpressed,
        ));
  }
}
