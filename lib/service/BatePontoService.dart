import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<String> batePonto(String cpf, String pwd) async {
  String? apiUrl = dotenv.env['API_URL'];
  final response = await http.get(
    Uri.parse(Uri.encodeFull(apiUrl.toString() +
        '?acao=1'
        '&txtValor=' + cpf.trim() +
        '&txtSenha=' + pwd +
        '&cboCampo=2'
        '&chkAdicPer=1'
        '&chkAdicIns=1'
        '&chkAdicEmb=1'
        '&captchaCode=ABCD'
        '&cboLocal=6055')),
    headers: <String, String>{
      'Cookie': 'ASPCAPTCHA=ABCD',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Falha ao bater o ponto: ' + response.body);
  }
}
