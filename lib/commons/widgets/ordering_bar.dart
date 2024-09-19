import 'package:flutter/material.dart';

import '/commons/values/colors.dart';

class OrderingBar extends StatelessWidget {
  final List<String> colonne;
  final void Function(String? value)? funzione;
  final Map<String, String>? ordering;

  const OrderingBar({
    super.key,
    required this.colonne,
    this.funzione,
    this.ordering,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: colonne
            .map((item) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _buildItem(item),
                  ),
                ))
            .toList(),
      ),
    );
  }

  /// Definizione Icona
  Widget iconaOrdering(String item) {
    if (ordering!.containsKey(item)) {
      if (ordering?[item] == 'asc') {
        return const Icon(
          Icons.arrow_drop_up,
          color: Colors.white,
        );
      } else {
        return const Icon(
          Icons.arrow_drop_down_sharp,
          color: Colors.white,
        );
      }
    } else {
      return const SizedBox(
        height: 32,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 1,
              child: Icon(
                Icons.arrow_drop_up,
                size: 20,
                color: AppColors.textTitleReverseColor,
              ),
            ),
            Positioned(
              bottom: 1,
              child: Icon(
                Icons.arrow_drop_down_sharp,
                size: 20,
                color: AppColors.textTitleReverseColor,
              ),
            ),
          ],
        ),
      );
      // return const Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Icon(
      //       size: 20,
      //       Icons.arrow_drop_up,
      //       color: AppColors.textTitleReverseColor,
      //     ),
      //     Icon(
      //       size: 20,
      //       Icons.arrow_drop_down_sharp,
      //       color: AppColors.textTitleReverseColor,
      //     ),
      //   ],
      // );
    }
  }

  Widget _buildItem(String item) {
    return GestureDetector(
      onTap: () => funzione!(item),
      child: MouseRegion(
        cursor: MaterialStateMouseCursor.clickable,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.secondaryColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: AppColors.textTitleReverseColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
                child: iconaOrdering(item),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
