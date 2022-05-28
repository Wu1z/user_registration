import 'package:flutter/material.dart';

class MyChoiceChip extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? initialValue;

  const MyChoiceChip({
    Key? key,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  State<MyChoiceChip> createState() => _MyThreeOptionsState();
}

class _MyThreeOptionsState extends State<MyChoiceChip> {
  int? _value = 0;
  final List<String> _options = ['USER', 'MANAGER', 'ADMINISTRATOR'];

  @override
  void initState() {
    super.initState();
    if(widget.initialValue != null) {
      _value = _options.indexOf(widget.initialValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: List<Widget>.generate(
        _options.length,
        (int index) {
          return ChoiceChip(
            padding: const EdgeInsets.all(10),
            label: Text(_options[index]),
            labelStyle: TextStyle(
              color: _value == index 
                ? Theme.of(context).colorScheme.onPrimary 
                : Colors.black 
            ),
            selected: _value == index,
            selectedColor: Theme.of(context).colorScheme.primary,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? index : null;
              });
              widget.onChanged(_options[index]);
            },
          );
        },
      ).toList(),
    );
  }
}