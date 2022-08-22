import 'package:flutter/material.dart';

Widget secondInput(context, myFocusNode, controller, save) {
  return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
          autofocus: true,
          focusNode: myFocusNode,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'Productos a escanear'),
          controller: controller,
          onSubmitted: (text) {
            text = text.replaceAll('@', '');
            if (text.isNotEmpty) {
              save(text);
              final snackBar = SnackBar(
                  content: Text('Usted ha pickeado: $text'),
                  action: SnackBarAction(
                    label: 'Cerrar',
                    onPressed: () {},
                  ),
                  duration: const Duration(milliseconds: 2000));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }));
}
