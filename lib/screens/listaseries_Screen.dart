import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:prueba_02/screens/comentarios_Screen.dart';

class Listaseries extends StatefulWidget {
  const Listaseries({super.key});

  @override
  _ListaseriesState createState() => _ListaseriesState();
}

class _ListaseriesState extends State<Listaseries> {
  List<dynamic> _seriesList = [];

  Future<void> _fetchSeries() async {
    final response = await http.get(Uri.parse('https://jritsqmet.github.io/web-api/peliculas2.json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _seriesList = data['peliculas']; 
      });
    } else {
      print('Error al cargar los datos');
    }
  }

  void _showSerieDetails(String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Series'),
        backgroundColor: Colors.blueAccent, // Ajuste de color para AppBar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent, // Asegurar consistencia en el color
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
              title: Text('Comentarios'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Comentarios()),
                );
              },
            ),
          ],
        ),
      ),
      body: _seriesList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _seriesList.length,
              itemBuilder: (context, index) {
                var serie = _seriesList[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        serie['enlaces']['image'],
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      serie['titulo'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      serie['descripcion'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      _showSerieDetails(serie['titulo'], serie['descripcion']);
                    },
                  ),
                );
              },
            ),
    );
  }
}
