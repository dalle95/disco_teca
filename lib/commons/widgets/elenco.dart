import 'package:flutter/material.dart';

/// Widget generico per creare un elenco di elementi
class ElencoView<T> extends StatelessWidget {
  final List<dynamic> items;
  final List<Widget Function(dynamic)> itemWidgets;
  final void Function(dynamic)? navigation;

  const ElencoView({
    super.key,
    required this.items,
    required this.itemWidgets,
    this.navigation,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        T item = items[index];
        return buildItem(context, item);
      },
    );
  }

  /// Costruisce la riga di un elemento
  Widget buildItem(BuildContext context, dynamic item) {
    return GestureDetector(
      onTap: () {
        navigation!(item?.toJson());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: itemWidgets.map((widgetBuilder) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: widgetBuilder(item),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
