import 'package:flutter/material.dart';

class Customtextfield extends StatefulWidget {
  const Customtextfield({super.key, this.controlor, this.text});
  final controlor;
  final String? text;
  @override
  State<Customtextfield> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<Customtextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controlor,
        decoration: InputDecoration(
            labelText: "${widget.text}",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))));
  }
}
