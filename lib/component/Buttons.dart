import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Buttons extends StatelessWidget {
  final String text;
  final Function() onTap;
  final bool isLoading;
  Buttons({
    required this.text,
    this.isLoading = false,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 56,
      width: Get.width,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : TextButton(
              onPressed: onTap,
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16,
                  height: 1,
                ),
              ),
            ),
    );
  }
}
