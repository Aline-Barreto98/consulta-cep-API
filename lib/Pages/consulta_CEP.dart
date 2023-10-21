import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsultaCEP2 extends StatefulWidget {
  const ConsultaCEP2({super.key});

  @override
  State<ConsultaCEP2> createState() => _ConsultaCEP2State();
}

class _ConsultaCEP2State extends State<ConsultaCEP2> {
  var cepController = TextEditingController(text: "");
  String endereco = "";
  String cidade = "";
  String estado = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const Text(
              "Consulta CEP",
              style: TextStyle(fontSize: 22),
            ),
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              //^^ adiciona um teclado numérico
              maxLength: 8, //número máximo para digitação
              onChanged: (String value) async {
                var cep = value.trim().replaceAll("-", "");
                //replaceAll altera de algo, para algo
                if (cep.length == 8) {
                  var response = await http
                      .get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
                  print(response.statusCode);
                  print(response.body);
                  var json = jsonDecode(response.body);
                  print(json); 
                   cidade = json ["localidade"]; 
                  estado = json ["uf"];
                  endereco = json ["logradouro"];
                }
                 else {
                  cidade = "cidade";
                  estado = "estado";
                  endereco = "endereço";
                }
                setState(() {});
              },
            ),
            const SizedBox(height: 50),
            Text(
              endereco,
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              "$cidade - $estado",
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var response = await http.get(Uri.parse("https://google.com"));
          print(response.body);
        },
      ),
    ));
  }
}
