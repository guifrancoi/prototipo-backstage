import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/oportunidade_provider.dart';

class DetalheOportunidadeScreen extends StatelessWidget {
  final String oportunidadeId;

  const DetalheOportunidadeScreen({super.key, required this.oportunidadeId});

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }

  Future<void> _confirmarInteresse(BuildContext context) async {
    final provider = context.read<OportunidadeProvider>();
    final oportunidade = provider.buscarOportunidadePorId(oportunidadeId);

    if (oportunidade == null) return;

    if (oportunidade.interesseEnviado == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Você já demonstrou interesse nesta oportunidade.'),
        ),
      );
      return;
    }

    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Demonstrar interesse'),
        content: Text(
          'Deseja demonstrar interesse na oportunidade "${oportunidade.titulo}"?',
        ),
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

    await provider.demonstrarInteresse(
      oportunidadeId: oportunidadeId,
      usuarioId: 'musico_logado_1',
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Interesse enviado com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OportunidadeProvider>();
    final oportunidade = provider.buscarOportunidadePorId(oportunidadeId);

    if (oportunidade == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalhes da oportunidade')),
        body: const Center(child: Text('Oportunidade não encontrada.')),
      );
    }

    final interesseEnviado = oportunidade.interesseEnviado == true;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da oportunidade')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    oportunidade.titulo,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Contratante: ${oportunidade.contratante}'),
                  const SizedBox(height: 8),
                  Text('Cidade: ${oportunidade.cidade}'),
                  const SizedBox(height: 8),
                  Text('Gênero musical: ${oportunidade.generoMusical}'),
                  const SizedBox(height: 8),
                  Text(
                    'Data do evento: ${_formatarData(oportunidade.dataEvento)}',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cachê oferecido: R\$ ${oportunidade.cacheOferecido.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Descrição',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(oportunidade.descricao),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: interesseEnviado
                  ? null
                  : () => _confirmarInteresse(context),
              icon: const Icon(Icons.favorite_border),
              label: Text(
                interesseEnviado
                    ? 'Interesse já enviado'
                    : 'Demonstrar interesse',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
