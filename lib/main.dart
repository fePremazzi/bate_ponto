import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hitdot_app/service/BatePontoService.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _cpfController = TextEditingController();
final _pwdController = TextEditingController();

void main() async {
  await dotenv.load(fileName: ".env");
  _loadUserEmailPassword();

  runApp(HitDotApp());
}

class HitDotApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Bate ponto'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
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
              keyboardType: TextInputType.number,
              controller: _cpfController,
              decoration: const InputDecoration(
                labelText: "CPF",
                hintText: 'Digite seu CPF (somente numeros)',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Bota o CPF, tenho cara de Bidu por um acaso?!?!';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _pwdController,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('DotEnv: ${dotenv.env["API_URL"]}');

                  String? user = _cpfController.text;
                  String? pwd = _pwdController.text;

                  if (user.isNotEmpty && pwd.isNotEmpty) {
                    SharedPreferences.getInstance().then(
                      (prefs) {
                        prefs.setString('cpf', user);
                        prefs.setString('pwd', pwd);
                      },
                    );
                    Future<String> response = batePonto(user, pwd);
                    response.then(
                      (value) => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Alerta'),
                          content: Text(value),
                          actions: <Widget>[                            
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
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

void _loadUserEmailPassword() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var _cpf = _prefs.getString("cpf") ?? "";
  var _pwd = _prefs.getString("pwd") ?? "";

  _cpfController.text = _cpf ?? "";
  _pwdController.text = _pwd ?? "";
}
