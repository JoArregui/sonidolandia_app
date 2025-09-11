import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'main.dart'; 

class AnimalListScreen extends StatefulWidget {
  final String title;
  final List<Animal> animals;

  const AnimalListScreen({super.key, required this.title, required this.animals});

  @override
  State<AnimalListScreen> createState() => _AnimalListScreenState();
}

class _AnimalListScreenState extends State<AnimalListScreen> {
  final AudioPlayer _player = AudioPlayer();

  void _playSound(Animal animal) async {
    // Detiene cualquier sonido que se esté reproduciendo
    await _player.stop();
    // Reproduce el nuevo sonido desde el asset
    await _player.play(AssetSource(animal.sonidoPath));
  }

  @override
  void dispose() {
    // Libera los recursos del reproductor al salir de la pantalla
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Animales de la ${widget.title.toLowerCase()}:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                itemCount: widget.animals.length,
                itemBuilder: (context, index) {
                  final animal = widget.animals[index];
                  return GestureDetector(
                    onTap: () => _playSound(animal),
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
                                animal.imagenPath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          animal.nombre,
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