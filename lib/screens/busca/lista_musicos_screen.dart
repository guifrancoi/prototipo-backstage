import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/oportunidade_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/musico_card.dart';

class ListaMusicosScreen extends StatelessWidget {
  const ListaMusicosScreen({super.key});

  Future<void> _confirmarInteresse(
    BuildContext context, {
    required String musicoId,
  }) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Demonstrar interesse'),
        content: const Text('Deseja demonstrar interesse neste artista?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );

    if (confirmar != true || !context.mounted) return;

    await context.read<OportunidadeProvider>().demonstrarInteresseEmMusico(
      musicoId: musicoId,
      usuarioId: 'casa_show_logada_1',
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Interesse no artista enviado com sucesso!'),
      ),
    );
  }

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
                final musico = provider.musicos[index];

                return MusicoCard(
                  musico: musico,
                  onDemonstrarInteresse: () =>
                      _confirmarInteresse(context, musicoId: musico.id),
                  onVerDetalhes: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.detalheMusico,
                      arguments: musico.id,
                    );
                  },
                );
              },
            ),
    );
  }
}
