import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(Parcial3());
  });
}

class Parcial3 extends StatelessWidget {
  const Parcial3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Registro",
      home: rCliente(),
    );
  }
}

class rCliente extends StatefulWidget {
  const rCliente({Key? key}) : super(key: key);

  @override
  _rClienteState createState() => _rClienteState();
}

class _rClienteState extends State<rCliente> {
  final nombre = TextEditingController();
  final apellido = TextEditingController();
  final observaciones = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Cliente");

  void InsertarCliente() async {
    return collectionReference
        .add({
          'nombre': nombre.text,
          'apellido': apellido.text,
          'observaciones': observaciones.text
        })
        .then((value) => print("Registro Agregado"))
        .catchError((error) => print("Fallo en insertar registro:$error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro Cliente")),
      body: cuerpoApp(context),
    );
  }

  Widget cuerpoApp(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/img/background.jpg",
              ),
              fit: BoxFit.cover)),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          mensaje(),
          SizedBox(
            height: 20,
          ),
          campoNombre(),
          campoApellido(),
          campoObservacion(),
          SizedBox(
            height: 20,
          ),
          botonGuardar(context),
        ],
      )),
    );
  }

  Widget campoNombre() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: nombre,
        decoration: InputDecoration(
            hintText: "Nombre",
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.people)),
      ),
    );
  }

  Widget campoApellido() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: apellido,
        decoration: InputDecoration(
            hintText: "Apellido",
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.people)),
      ),
    );
  }

  Widget campoObservacion() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: observaciones,
        decoration: InputDecoration(
            hintText: "Observaciones",
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.people)),
      ),
    );
  }

  Widget botonGuardar(context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 175, vertical: 15),
      color: Colors.blueAccent,
      onPressed: () {
        InsertarCliente();
      },
      child: Text(
        "Guardar",
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.blue, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(50)),
    );
  }

  Widget mensaje() {
    return Text(
      "Cliente ",
      style: TextStyle(color: Colors.white, fontSize: 30),
    );
  }
}
