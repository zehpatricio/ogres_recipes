import 'package:flutter/material.dart';

class TextWithIcon extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color? color;
  final double textSize;

  // ignore: use_key_in_widget_constructors
  const TextWithIcon(this.text, this.iconData,
      {this.color, this.textSize = 14});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontSize: textSize)),
        Icon(
          iconData,
          color: color ?? Colors.pink,
          size: textSize + 2,
        ),
      ],
    );
  }
}

class DecoratedTextField extends StatelessWidget {
  final String label;
  final Function onChanged;
  final Function? onTap;
  final double? marginBottom;
  final TextEditingController? controller;

  // ignore: use_key_in_widget_constructors
  const DecoratedTextField(this.label, this.onChanged,
      {this.marginBottom, this.onTap, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom ?? 16),
      child: TextField(
        maxLines: null,
        textCapitalization: TextCapitalization.sentences,
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        controller: controller,
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

class HeadBody extends StatelessWidget {
  final String title;
  final Widget child;

  // ignore: use_key_in_widget_constructors
  const HeadBody(this.title, this.child);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
                child: Divider(thickness: 1, endIndent: 5),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              const Expanded(child: Divider(thickness: 1, indent: 5))
            ],
          ),
        ),
        const SizedBox(height: 5),
        child
      ],
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  final String _title;
  final double _expandedHeight;
  final String? _imgUrl;

  // ignore: use_key_in_widget_constructors
  const CustomSliverAppBar(this._title, this._expandedHeight, this._imgUrl);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: _imgUrl != null ? _expandedHeight : 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(_title),
        background: Container(
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 1.0],
            ),
          ),
          child: _imgUrl != null
              ? Image(
                  height: _expandedHeight,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(_imgUrl!),
                )
              : Container(),
        ),
      ),
    );
  }
}

class RecipeStep extends StatelessWidget {
  final String _step;
  final String _text;

  // ignore: use_key_in_widget_constructors
  const RecipeStep(this._step, this._text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 220, 220, 220),
            shape: BoxShape.circle,
          ),
          child: Text(
            _step,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(_text, style: const TextStyle(fontSize: 16)),
        )
      ],
    );
  }
}
