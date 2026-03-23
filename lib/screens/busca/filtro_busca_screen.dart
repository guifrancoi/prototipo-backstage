import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/oportunidade_provider.dart';

class FiltroBuscaScreen extends StatefulWidget {
  const FiltroBuscaScreen({super.key});

  @override
  State<FiltroBuscaScreen> createState() => _FiltroBuscaScreenState();
}

class _FiltroBuscaScreenState extends State<FiltroBuscaScreen> {
  final _generoController = TextEditingController();
  final _cidadeController = TextEditingController();

  @override
  void dispose() {
    _generoController.dispose();
    _cidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OportunidadeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Filtro de busca')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _generoController,
              decoration: const InputDecoration(
                labelText: 'Gênero musical',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cidadeController,
              decoration: const InputDecoration(
                labelText: 'Cidade',
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  provider.filtrarMusicos(
                    genero: _generoController.text.trim(),
                    cidade: _cidadeController.text.trim(),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Filtro aplicado na lista de músicos.'),
                    ),
                  );
                },
                child: const Text('Aplicar filtro'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  provider.resetarFiltroMusicos();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filtros resetados.')),
                  );
                },
                child: const Text('Limpar filtro'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}