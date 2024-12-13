import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:prueba_02/screens/listaseries_Screen.dart';
import 'package:prueba_02/screens/welcome_Screen.dart';

class Comentarios extends StatefulWidget {
  const Comentarios({super.key});

  @override
  _ComentariosState createState() => _ComentariosState();
}

class _ComentariosState extends State<Comentarios> {
  final TextEditingController _serieController = TextEditingController();
  final TextEditingController _nombreSerieController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> _guardarComentario() async {
    final String Id = _serieController.text.trim();
    final String nombreSerie = _nombreSerieController.text.trim();
    final String comentario = _comentarioController.text.trim();

    if (Id.isNotEmpty && nombreSerie.isNotEmpty && comentario.isNotEmpty) {
      DatabaseReference comentariosRef = _database.ref('comentarios');
      DatabaseReference nuevoComentarioRef = comentariosRef.push();
      await nuevoComentarioRef.set({
        'Id': Id,
        'nombreSerie': nombreSerie,
        'comentario': comentario,
      });

      _serieController.clear();
      _nombreSerieController.clear();
      _comentarioController.clear();

      _showSuccessDialog();
    } else {
      _showErrorDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Comentario guardado'),
          content: Text('Tu comentario ha sido guardado exitosamente.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Por favor, ingresa todos los campos.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Comentarios de Serie')),
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Lista de Series'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Listaseries()),
              );
            },
          ),
        ],
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _serieController,
            decoration: InputDecoration(
              labelText: 'ID',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _nombreSerieController,
            decoration: InputDecoration(
              labelText: 'Nombre de la Serie',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _comentarioController,
            decoration: InputDecoration(
              labelText: 'Comentario',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _guardarComentario,
            child: Text('Guardar Comentario'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Welcome()), 
              );
            },
            child: Text('Salir'),
          ),
        ],
      ),
    ),
  );
}
}