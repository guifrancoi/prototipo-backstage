import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            Text(
              'Backstage',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Objetivo do aplicativo:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Conectar músicos e casas de show de forma prática, centralizando portfólios, oportunidades, agendas e comunicação.',
            ),
            SizedBox(height: 16),
            Text(
              'Equipe de desenvolvimento:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('• Integrante 1'),
            Text('• Integrante 2'),
            Text('• Integrante 3'),
            SizedBox(height: 16),
            Text('Disciplina: Desenvolvimento Mobile'),
            Text('Instituição: Unaerp'),
            Text('Professor: Rodrigo Plotze'),
            Text('Versão: 1.0.0'),
          ],
        ),
      ),
    );
  }
}