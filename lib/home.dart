import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _cPeso = TextEditingController();
  final _cAltura = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _resultIMC = '';

  void _calIMC() {
    double altura = int.parse(this._cAltura.text) / 100;
    double quadrado = altura * altura;
    double imc = double.parse(
        (int.parse(this._cPeso.text) / quadrado).toStringAsFixed(1));

    setState(() {
      if (imc < 18.5) {
        this._resultIMC = "Abaixo do peso $imc";
      } else if (imc <= 24.9) {
        this._resultIMC = "Peso normal $imc";
      } else if (imc <= 29.9) {
        this._resultIMC = "Sobrepeso $imc";
      } else if (imc <= 34.9) {
        this._resultIMC = "Obesidade grau I $imc";
      } else if (imc <= 39.9) {
        this._resultIMC = "Obesidade grau II $imc";
      } else {
        this._resultIMC = "Obesidade grau III $imc";
      }
    });
  }

  void _refresh() {
    setState(() {
      this._resultIMC = '';
      this._cPeso.clear();
      this._cAltura.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _refresh();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Peso", hintText: "kg"),
                controller: _cPeso,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe o Peso";
                  }

                  if (int.parse(value) < 0) {
                    return "Peso inválido";
                  }

                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: "Altura", hintText: "cm"),
                controller: _cAltura,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe o Altura";
                  }

                  if (int.parse(value) < 50) {
                    return "Altura inválida";
                  }

                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _calIMC();
                    }
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text("Calcular"),
                  minWidth: 150,
                ),
              ),
              Center(
                child: Text(_resultIMC),
              )
            ],
          ),
        ),
      ),
    );
  }
}
