import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/buttonOpen.dart';
import 'functions/txtSave.dart';
import 'widgets/inputFirst.dart';
import 'widgets/inputSecond.dart';

Widget mainColumn(context) {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controllerPrimerInput = TextEditingController();

  FocusNode myFocusNode = FocusNode();

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      firstInput(context, myFocusNode, controller, controllerPrimerInput),
      secondInput(context, myFocusNode, controller, save),
      openButton(),
    ],
  );
}
