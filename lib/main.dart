import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
final storage = new FlutterSecureStorage();
final cpfController = TextEditingController();
final pwdController = TextEditingController();

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(HitDotApp());
}

class HitDotApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Bate ponto'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: cpfController,
              decoration: const InputDecoration(
                labelText: "CPF",
                hintText: 'Digite seu CPF',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Bota o CPF, tenho cara de Bidu por um acaso?!?!';
                }
                return null;
              },
            ),
            TextFormField(
              controller: pwdController,
              decoration: const InputDecoration(
                hintText: 'Digite sua senha',
                labelText: "Senha",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Bota a senha, tenho cara de Bidu por um acaso?!?';
                }
                return null;
              },
              obscureText: true,
            ),
            // MyStatefulCheckbox(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('DotEnv: ${dotenv.env["API_URL"]}');
                  String? user = cpfController.text;
                  debugPrint(user);
                },
                child: Text("Enviar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulCheckbox extends StatefulWidget {
  const MyStatefulCheckbox({Key? key}) : super(key: key);

  @override
  State<MyStatefulCheckbox> createState() => _CheckBoxStfull();
}

/// This is the private State class that goes with MyStatefulWidget.
class _CheckBoxStfull extends State<MyStatefulCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text("Salvar cpf e senha"),
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: Colors.white,
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
