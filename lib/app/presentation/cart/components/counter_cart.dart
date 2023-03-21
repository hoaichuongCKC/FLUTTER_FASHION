import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/font_style.dart';

class CounterCart extends StatefulWidget {
  const CounterCart({
    super.key,
    this.onChanged,
    this.iconSize = 20.0,
    this.value = 1,
    this.ins,
    this.des,
  });
  final Function(int)? onChanged;
  final double iconSize;
  final int value;
  final void Function()? ins;
  final void Function()? des;
  @override
  State<CounterCart> createState() => _CounterCartState();
}

class _CounterCartState extends State<CounterCart> {
  late int _counter;
  @override
  void initState() {
    super.initState();
    _counter = widget.value;
  }

  @override
  void didUpdateWidget(covariant CounterCart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _counter = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: widget.des ??
              () {
                if (_counter == 1) return;
                _counter--;
                if (widget.onChanged != null) {
                  widget.onChanged!(_counter);
                }
                setState(() {});
              },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: disableDarkColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_left_outlined,
              size: widget.iconSize,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            _counter.toString(),
            style: PrimaryFont.instance.small(),
          ),
        ),
        InkWell(
          onTap: widget.ins ??
              () {
                _counter++;
                if (widget.onChanged != null) {
                  widget.onChanged!(_counter);
                }
                setState(() {});
              },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: disableDarkColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_right_outlined,
              size: widget.iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
