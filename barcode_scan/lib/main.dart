import 'package:flutter/material.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'widgets/ButtonScanner.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
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
  String barcodeScanRes = 'Sin elementos escaneados';
  final TextEditingController _controller = TextEditingController();

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
              const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Inserte el nombre del artículo'),
                  )),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Productos a escanear'),
                      controller: _controller,
                      onSubmitted: (value) {
                        String resultado = _controller.text = value;
                        if (resultado.isNotEmpty) {
                          lista.add(resultado);
                          save('Pickeado.txt', lista);
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
                              content: Text(concatenar(lista)),
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

  static Future<void> save(String filename, List<String> content) async {
    String listaConcatenada = concatenar(content);
    final directory = await DownloadsPathProvider.downloadsDirectory;
    final path = '${directory?.path}/$filename';
    final file = File(path);
    await file.writeAsString(listaConcatenada);
  }
}

String concatenar(List<String> lista) {
  String text = "";

  for (String elem in lista) {
    text += '\n$elem';
  }

  return text;
}
