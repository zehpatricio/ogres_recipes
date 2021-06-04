import 'package:flutter/material.dart';

class TextWithIcon extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color? color;

  TextWithIcon(this.text, this.iconData, {this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        Icon(
          iconData,
          color: color ?? Colors.pink,
          size: 16.0,
        ),
      ],
    );
  }
}

class DecoratedTextField extends StatelessWidget {
  final String label;
  final Function onChanged;
  final double? marginBottom;

  DecoratedTextField(this.label, this.onChanged, {this.marginBottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom ?? 16),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
