import 'package:flutter/material.dart';

Widget firstInput(context, myFocusNode, controller, controllerPrimerInput) {
  return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controllerPrimerInput,
        onChanged: (value) {
          if ((value.contains('@'))) {
            FocusScope.of(context).requestFocus(myFocusNode);
            controller.text = value;
            controllerPrimerInput.clear();
          }
        },
        onSubmitted: (value) {
          if ((value.contains('@'))) {
            FocusScope.of(context).requestFocus(myFocusNode);
            controller.text = value;
            controllerPrimerInput.clear();
          }
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(),
            counterText: "",
            border: OutlineInputBorder(),
            hintText: 'Primer Input'),
      ));
}
