import 'package:flutter/material.dart';
import '../functions/saveTxt.dart';
import './firstInput.dart';
import './secondInput.dart';
import 'package:open_file/open_file.dart';

Widget mainColumn(context) {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controllerPrimerInput = TextEditingController();

  FocusNode myFocusNode = FocusNode();

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      firstInput(context, myFocusNode, controller, controllerPrimerInput),
      secondInput(context, myFocusNode, controller, save)
      /* ElevatedButton(
          child: const Text('Ver Log'),
          onPressed: () {
            getLog();
          }), */
    ],
  );
}

/* Future<void> getLog() async {
  final directory = (await getExternalStorageDirectory());
  final file = File('$directory/Log.txt');
  OpenFile.open(file);
} */
