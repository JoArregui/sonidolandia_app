import 'package:flutter/material.dart';
import 'package:sonidolandia/animal_list_screen.dart';

// Modelo de datos para cada animal
class Animal {
  final String nombre;
  final String imagenPath;
  final String sonidoPath;

  const Animal({required this.nombre, required this.imagenPath, required this.sonidoPath});
}

// Modelo de datos para cada nivel
class Level {
  final String nombre;
  final String imagenPath;
  final List<Animal> animals;

  const Level({required this.nombre, required this.imagenPath, required this.animals});
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sonidolandia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LevelSelectionScreen(title: 'Sonidolandia'),
    );
  }
}

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key, required this.title});
  final String title;

  // Lista de niveles disponibles, ahora completamente constante
  final List<Level> _levels = const [
    Level(
      nombre: 'Granja',
      imagenPath: 'assets/images/farm_level.png',
      animals: [
        Animal(nombre: 'Gato', imagenPath: 'assets/images/gato.png', sonidoPath: 'sounds/gato.mp3'),
        Animal(nombre: 'Vaca', imagenPath: 'assets/images/vaca.png', sonidoPath: 'sounds/vaca.mp3'),
        Animal(nombre: 'Cerdo', imagenPath: 'assets/images/cerdo.png', sonidoPath: 'sounds/cerdo.mp3'),
        Animal(nombre: 'Caballo', imagenPath: 'assets/images/caballo.png', sonidoPath: 'sounds/caballo.mp3'),
      ],
    ),
    Level(
      nombre: 'Zoo',
      imagenPath: 'assets/images/zoo_level.png',
      animals: [
        Animal(nombre: 'León', imagenPath: 'assets/images/leon.png', sonidoPath: 'sounds/leon.mp3'),
        Animal(nombre: 'Elefante', imagenPath: 'assets/images/elefante.png', sonidoPath: 'sounds/elefante.mp3'),
        Animal(nombre: 'Rana', imagenPath: 'assets/images/rana.png', sonidoPath: 'sounds/rana.mp3'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Elige un nivel:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: _levels.length,
                itemBuilder: (context, index) {
                  final level = _levels[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimalListScreen(
                            title: level.nombre,
                            animals: level.animals,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                level.imagenPath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          level.nombre,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}