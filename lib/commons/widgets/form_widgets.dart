import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/commons/values/colors.dart';
import '/commons/widgets/dropdown_field.dart';
import '/commons/widgets/text_field.dart';

/// Widget per creare la base del form completamente scrollabile
Widget buildForm({required List<Widget> listaWidget}) {
  return Container(
    padding: const EdgeInsets.only(left: 20),
    alignment: Alignment.topLeft,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listaWidget,
        ),
      ),
    ),
  );
}

Widget buildLable({required String lable}) {
  return Text(
    lable,
    style: const TextStyle(
      color: AppColors.textTitleColor,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: 'Arial',
    ),
  );
}

/// Widget per creare la riga con label e form compilabile
Widget buildLableTextField({
  required String label,
  required TextEditingController controller,
  Function(String)? onChange,
}) {
  return Container(
    height: 45,
    margin: const EdgeInsets.only(top: 20),
    child: Row(
      children: [
        Container(
          width: 150,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(right: 20),
          child: buildLable(lable: label),
        ),
        buildTextFieldOnChange(
          width: 300,
          controller: controller,
          func: onChange,
        ),
      ],
    ),
  );
}

/// Widget per creare la riga con label e form non compilabile
Widget buildLableTextFieldFake({
  required String label,
  String? value,
  double width = 300,
}) {
  return Container(
    height: 45,
    margin: const EdgeInsets.only(top: 20),
    child: Row(
      children: [
        Container(
          width: 150,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(right: 20),
          child: buildLable(lable: label),
        ),
        Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  "assets/icons/padlock.png",
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 45,
                width: 250,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  value ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Widget per creare la riga con label e form a scelta
Widget buildLabelDropDownScelta({
  required String label,
  String? valore,
  required List<String> lista,
  void Function(String)? func,
}) {
  return Container(
    height: 45,
    margin: const EdgeInsets.only(top: 20),
    child: Row(
      children: [
        Container(
          width: 150,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(right: 20),
          child: buildLable(lable: label),
        ),
        buildDropDownScelta(
          title: label,
          valore: valore,
          lista: lista,
          funzione: (value) => value != null
              ? func != null
                  ? func(value)
                  : {}
              : {},
          width: 300,
        ),
      ],
    ),
  );
}

Widget buildLabelDatePicker({
  required String label,
  DateTime? selectedDate,
  required BuildContext context,
  required Function(DateTime) onDateSelected,
}) {
  return Container(
    height: 45,
    margin: const EdgeInsets.only(top: 20),
    child: Row(
      children: [
        Container(
          width: 150,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(right: 20),
          child: buildLable(lable: label),
        ),
        Container(
          height: 45,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                onDateSelected(pickedDate);
              }
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      selectedDate != null
                          ? DateFormat('dd/MM/yyyy').format(selectedDate)
                          : 'gg/mm/aaaa',
                      style: TextStyle(
                        color: selectedDate != null
                            ? Colors.black
                            : Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(Icons.calendar_today,
                      size: 20, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// Widget per creare il titolo di un form
Widget buildTitleForm({required String title}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(
      title,
      style: const TextStyle(
        color: AppColors.elevatedButtonColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Widget per creare il sotto titolo di un form
Widget buildSubTitleForm({required String title}) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
