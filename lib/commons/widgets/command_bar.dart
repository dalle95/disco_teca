import 'package:flutter/material.dart';

class CommandBar extends StatelessWidget {
  final List<Widget> items;

  const CommandBar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return _buildFullWidthBar();
        } else if (constraints.maxWidth > 600) {
          return _buildCompactBar();
        } else {
          return _buildScrollableBar();
        }
      },
    );
  }

  Widget _buildFullWidthBar() {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: item,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildCompactBar() {
    return Container(
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
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: item,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildScrollableBar() {
    return Container(
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
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: item,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
