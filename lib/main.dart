import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handheld',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Handheld'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> lista = [];
  String resultado = '';
  String barcodeScanRes = 'Sin elementos escaneados';
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerPrimerInput = TextEditingController();

  FocusNode myFocusNode = FocusNode();
  int cantidad = 1;
  RegExp dotRegExp = RegExp(r'@.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _controllerPrimerInput,
                    onChanged: (value) {
                      if (value.characters.length == cantidad && value == '@') {
                        FocusScope.of(context).requestFocus(myFocusNode);
                        _controllerPrimerInput.text = '';
                      }
                    },
                    onSubmitted: (value) {
                      String resultado = _controllerPrimerInput.text = value;
                      if (resultado.isNotEmpty) {
                        //lista.add(resultado);
                        save(resultado);
                      }
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(),
                        counterText: "",
                        border: OutlineInputBorder(),
                        hintText: 'Inserte el nombre del artículo'),
                  )),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                      autofocus: true,
                      focusNode: myFocusNode,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Productos a escanear'),
                      controller: _controller,
                      onSubmitted: (text) {
                        String resultado = _controller.text = text;
                        if (resultado.isNotEmpty) {
                          save(resultado);
                          final snackBar = SnackBar(
                              content: Text('Usted ha pickeado: $resultado'),
                              action: SnackBarAction(
                                label: 'Cerrar',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                              duration: const Duration(milliseconds: 500));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      })),
            ],
          ),
        ));
  }

  static Future<File> save(String content) async {
    final directory = (await getExternalStorageDirectory())?.path;
    final file = File('$directory/Log.txt');
    String texto = '';
    if (file.existsSync()) {
      texto = await file.readAsString();
    }
    return file.writeAsString(
        '$texto \nCodigo de barra: $content - ${DateTime.now()}');
  }
}

String concatenar(List<String> lista) {
  String text = "";

  for (String elem in lista) {
    text += '\n$elem';
  }

  return text;
}
