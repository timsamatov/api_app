import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.btnTitle,
    required this.onPressed
  });

  final String btnTitle;
  final Function()? onPressed;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff071952)),
      child:  Text(
        btnTitle,
        style: const TextStyle(color: Color(0xff45FFCA)),
      ),
    );
  }
}