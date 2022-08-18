import 'package:flutter/material.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'widgets/ButtonScanner.dart';
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
                        enabledBorder: InputBorder.none,
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
                          //lista.add(resultado);

                          save(resultado);
                        }
                      })),
              /* ElevatedButton(
                  child: const Text('Escanear con cámara'),
                  onPressed: () async {
                    _controller.text = '';
                    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                        '#3D8BEF', 'Cancelar', true, ScanMode.QR);
                    if (barcodeScanRes != '-1') {
                      _controller.text = barcodeScanRes;
                      lista.add(barcodeScanRes);
                    }
                  }), */
              ElevatedButton(
                  child: const Text('Ver Log'),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: const Text("Usted ha pickeado:"),
                              content: Text('getLog()'),
                            ),
                        barrierDismissible: true);
                  }),
              /* ElevatedButton(
                  onPressed: () => {
                        if (lista.isNotEmpty)
                          {save('Picked.txt', lista)}
                        else
                          {
                            showDialog(
                                context: context,
                                builder: (_) => const AlertDialog(
                                      title: Text("Archivo TXT Vacío"),
                                      content:
                                          Text('Por favor, escanee productos.'),
                                    ),
                                barrierDismissible: true)
                          }
                      },
                  child: const Text("Descargar TXT")) */
            ],
          ),
        ));
  }

  /* _createTXT(List<String> lista) async {
    String listaConcatenada = concatenar(lista);
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/Picked.txt');
    await file.writeAsString(listaConcatenada);
    lista.clear();
  } */

  static Future<void> save(String content) async {
    //String listaConcatenada = concatenar(content);
    final directory = (await getExternalStorageDirectory())?.path;
    final file = File('$directory/Log.txt');
    final String texto = await file.readAsString();
    await file.writeAsString(
        '$texto \nCodigo de barra: $content - ${DateTime.now()}');
  }

  static Future<String> getLog() async {
    final directory = (await getExternalStorageDirectory())?.path;
    final file = File('$directory/Log.txt');
    final String texto = await file.readAsString();
    return texto;
  }
}

String concatenar(List<String> lista) {
  String text = "";

  for (String elem in lista) {
    text += '\n$elem';
  }

  return text;
}
