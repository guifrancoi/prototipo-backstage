import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/oportunidade_provider.dart';
import '../../widgets/musico_card.dart';

class ListaMusicosScreen extends StatelessWidget {
  const ListaMusicosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OportunidadeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de músicos')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.musicos.length,
        itemBuilder: (context, index) {
          return MusicoCard(musico: provider.musicos[index]);
        },
      ),
    );
  }
}