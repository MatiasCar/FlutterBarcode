import 'package:flutter/material.dart';
import '../functions/txtOpen.dart';

Widget openButton() {
  return ElevatedButton(
      child: const Text('Ver Log'),
      onPressed: () {
        openTxt();
      });
}
