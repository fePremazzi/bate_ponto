import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';

Future<String> batePonto(String cpf, String pwd) async {
  String apiUrl = FlutterConfig.get('API_URL'); // returns 'abcdefgh'
  final response = await http.get(
    Uri.parse(Uri.encodeFull(apiUrl +
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
