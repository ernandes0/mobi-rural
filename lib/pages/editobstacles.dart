import 'package:flutter/material.dart';
import 'package:mobirural/models/obstacle_model.dart';
import 'package:mobirural/services/obstacle_service.dart';
import 'package:provider/provider.dart';

class EditObstacleScreen extends StatefulWidget {
  final ObstacleModel obstacle;

  const EditObstacleScreen({super.key, required this.obstacle});

  @override
  State<EditObstacleScreen> createState() => _EditObstacleScreenState();
}

class _EditObstacleScreenState extends State<EditObstacleScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  int _difficulty = 0;

  @override
  void initState() {
    super.initState();

    // Preencher os controladores com os dados atuais do obstáculo
    _titleController.text = widget.obstacle.title ?? '';
    _detailsController.text = widget.obstacle.details ?? '';
    _difficulty = widget.obstacle.difficulty ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Obstáculo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _detailsController,
              maxLines: null,
              decoration: const InputDecoration(labelText: 'Detalhes'),
            ),
            const SizedBox(height: 16.0),
            Text('Dificuldade: $_difficulty'),
            Slider(
              value: _difficulty.toDouble(),
              min: 0,
              max: 5,
              divisions: 5,
              onChanged: (value) {
                setState(() {
                  _difficulty = value.round();
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await _saveChanges();
              },
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveChanges() async {
    final updatedObstacle = widget.obstacle.copyWith(
      title: _titleController.text,
      details: _detailsController.text,
      difficulty: _difficulty,
    );

    await Provider.of<ObstacleService>(context, listen: false)
        .updateObstacle(updatedObstacle);

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
