import "package:flutter/material.dart";

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(13),
      // height: 35,
      decoration: BoxDecoration(
        color: const Color(0xff2b637b),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),),
    )
  );

  }
}