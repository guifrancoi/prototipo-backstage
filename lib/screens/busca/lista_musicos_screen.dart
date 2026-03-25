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
      body: provider.musicos.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Nenhum músico encontrado com os filtros informados.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.musicos.length,
              itemBuilder: (context, index) {
                return MusicoCard(musico: provider.musicos[index]);
              },
            ),
    );
  }
}