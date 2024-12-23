import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final String? value;
  final Function(String)? onChanged;
  final Function()? onPressed;
  final TextInputType? keyboardType;
  final TextAlign textAlign; // New parameter

  const TextFieldCustom({
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.value,
    this.onChanged,
    this.onPressed,
    this.keyboardType,
    this.textAlign = TextAlign.start, // Default left alignment
    super.key,
  });

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller = TextEditingController(text: widget.value);
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TextFieldCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      controller.text = widget.value ?? '';
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return TextField(
          textAlign: widget.textAlign,
          keyboardType: widget.keyboardType,
          controller: controller,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            alignLabelWithHint: true, // Aligns label with input text
            suffixIcon: widget.onPressed == null
                ? null
                : controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                          widget.onPressed!();
                        },
                      )
                    : null,
          ),
          onChanged: (value) {
            widget.onChanged == null ? null : widget.onChanged!(value);
          },
        );
      },
    );
  }
}
