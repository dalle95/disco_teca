import 'package:flutter/material.dart';
import '/commons/values/colors.dart';

/// TextField custom da usare in tutta l'app con funzione onChange
Widget buildTextFieldOnChange({
  String? hintText,
  String? textType,
  String? iconName,
  Color? foregroundColor = AppColors.primaryBackground,
  void Function(String)? func,
  int? maxLines = 1,
  TextEditingController? controller,
  bool autofocus = false,
  double width = 300,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(4),
      ),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (iconName != null)
          Container(
            width: 40,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              "assets/icons/$iconName",
            ),
          ),
        Container(
          alignment: Alignment.centerLeft,
          height: 45,
          width: width - 40,
          padding: const EdgeInsets.symmetric(
              vertical: 0), // Elimina padding verticale dal container
          child: appTextFieldOnChange(
            hintText ?? "Scrivi qui",
            textType ?? "Normale",
            func: func,
            foregroundColor: foregroundColor,
            maxLines: maxLines,
            controller: controller,
            autofocus: autofocus,
            hasBorder: false,
          ),
        ),
      ],
    ),
  );
}

Widget appTextFieldOnChange(
  String hintText,
  String textType, {
  void Function(String)? func,
  Color? foregroundColor = AppColors.elevatedButtonColor,
  int? maxLines = 1,
  TextEditingController? controller,
  bool autofocus = false,
  bool hasBorder = true,
}) {
  return TextField(
    controller: controller,
    onChanged: (value) => func != null ? func(value) : {},
    keyboardType: TextInputType.multiline,
    maxLines: maxLines,
    autofocus: autofocus,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey.shade600,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 13, // Aggiunto padding verticale per centrare il testo
      ),
      border: hasBorder
          ? OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            )
          : InputBorder.none,
      enabledBorder: hasBorder
          ? OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            )
          : InputBorder.none,
      disabledBorder: hasBorder
          ? OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            )
          : InputBorder.none,
      focusedBorder: hasBorder
          ? OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            )
          : InputBorder.none,
      isDense: true, // Aggiunto per ridurre lo spazio interno del TextField
    ),
    style: const TextStyle(
      color: Colors.black,
      fontFamily: "Avenir",
      fontWeight: FontWeight.normal,
      fontSize: 16,
    ),
    autocorrect: false,
    obscureText: textType == "password",
    textAlignVertical: TextAlignVertical
        .center, // Aggiunto per centrare verticalmente il testo
  );
}
