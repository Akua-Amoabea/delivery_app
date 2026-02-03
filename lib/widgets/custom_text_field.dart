import 'package:delivery_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String? hintText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final void Function(String)? onChanged;

  CustomTextField({
    super.key,
    this.focusNode,
    this.hintText,
    this.nextFocusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            fillColor: background,
            filled: true,
            counterText: '',
            hintText: hintText,
            border: InputBorder.none,
          ),
          textInputAction: nextFocusNode == null
              ? TextInputAction.done
              : TextInputAction.next,
          onSubmitted: (_) {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              FocusScope.of(context).unfocus();
            }
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
