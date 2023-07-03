import 'package:flutter/material.dart';

typedef CallBack = Function(dynamic value);

class DropDownList<T> extends StatelessWidget {
  final dynamic value;
  final List<dynamic> list;
  final CallBack onSelect;
  final String title;
  final bool showLabel;
  final bool required;
  final bool enable;

  const DropDownList({
    Key? key,
    this.enable = true,
    required this.value,
    this.required = false,
    required this.list,
    required this.onSelect,
    required this.title,
    this.showLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IgnorePointer(
      ignoring: !enable,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLabel) ...[
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ],
          SizedBox(
            height: 44,
            child: DropdownButton<T>(
              hint: Text(title),
              value: value as T?,
              isExpanded: true,
              style: const TextStyle(
                  fontSize: 14, fontFamily: 'Poppins', color: Colors.black),
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  color: Colors.black.withOpacity(0.6)),
              items: list
                  .map((e) => DropdownMenuItem<T>(
                        child: Text(e.toString()),
                        value: e,
                      ))
                  .toList(),
              onChanged: (value) => enable ? onSelect(value) : null,
            ),
          ),
        ],
      ),
    );
  }
}
