// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:redefine_sales_app/helpers/theme.dart';
// import 'package:todo/helpers/theme.dart';

class CircleIconButton extends StatelessWidget {
  final double size;
  final void Function()? onPressed;
  final IconData icon;

  const CircleIconButton(
      {Key? key, this.size = 20.0, this.icon = Icons.clear, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: const Alignment(0.0, 0.0), // all centered
              children: <Widget>[
                Container(
                  width: size,
                  height: size,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: primary),
                ),
                Icon(
                  icon,
                  size: size * 0.6,
                  color: white, // 60% width for icon
                )
              ],
            )));
  }
}
