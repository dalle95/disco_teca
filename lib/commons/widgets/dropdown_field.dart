import 'package:flutter/material.dart';
import '/commons/values/colors.dart';

Widget buildDropDownScelta({
  String? title,
  String? valore,
  List<String>? lista,
  void Function(String? value)? funzione,
  double width = 300,
}) {
  return Container(
    width: width,
    height: 45,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "Avenir",
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        value: valore,
        hint: Text(
          title ?? '',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        items: lista?.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != valore) {
            funzione?.call(newValue);
          }
        },
      ),
    ),
  );
}
