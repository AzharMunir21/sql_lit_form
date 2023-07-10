import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFormField(
    {required String heading,
    required String errorName,
    var controller,
    bool obscurText = false}) {
  return ListTile(
    title: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 16),
        )),
    subtitle: TextFormField(
      obscureText: obscurText,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorName;
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        hintText: heading,
        disabledBorder: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        fillColor: Colors.grey.withOpacity(0.1),
      ),
    ),
  );
}
