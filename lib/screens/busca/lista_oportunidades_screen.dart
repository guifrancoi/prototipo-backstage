import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/oportunidade_provider.dart';
import '../../widgets/oportunidade_card.dart';

class ListaOportunidadesScreen extends StatelessWidget {
  const ListaOportunidadesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OportunidadeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de oportunidades')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.oportunidades.length,
        itemBuilder: (context, index) {
          return OportunidadeCard(oportunidade: provider.oportunidades[index]);
        },
      ),
    );
  }
}