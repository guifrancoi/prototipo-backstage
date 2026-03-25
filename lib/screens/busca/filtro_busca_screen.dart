import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../providers/oportunidade_provider.dart';
import '../../routes/app_routes.dart';

class FiltroBuscaScreen extends StatefulWidget {
  const FiltroBuscaScreen({super.key});

  @override
  State<FiltroBuscaScreen> createState() => _FiltroBuscaScreenState();
}

class _FiltroBuscaScreenState extends State<FiltroBuscaScreen> {
  final _cidadeController = TextEditingController();
  String? _generoSelecionado;

  @override
  void initState() {
    super.initState();

    final provider = context.read<OportunidadeProvider>();
    _generoSelecionado = provider.generoSelecionadoMusicos;
    _cidadeController.text = provider.cidadeFiltroMusicos ?? '';
  }

  @override
  void dispose() {
    _cidadeController.dispose();
    super.dispose();
  }

  void _aplicarFiltro() {
    final provider = context.read<OportunidadeProvider>();

    provider.filtrarMusicos(
      genero: _generoSelecionado,
      cidade: _cidadeController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filtro aplicado com sucesso.'),
      ),
    );

    Navigator.pushNamed(context, AppRoutes.listaMusicos);
  }

  void _limparFiltro() {
    final provider = context.read<OportunidadeProvider>();

    provider.resetarFiltroMusicos();

    setState(() {
      _generoSelecionado = null;
      _cidadeController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filtros resetados.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filtro de busca')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _generoSelecionado,
              decoration: const InputDecoration(
                labelText: 'Gênero musical',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem<String>(
                  value: '',
                  child: Text('Todos'),
                ),
                ...AppStrings.generosMusicais.map(
                  (genero) => DropdownMenuItem<String>(
                    value: genero,
                    child: Text(genero),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _generoSelecionado = (value == null || value.isEmpty) ? null : value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cidadeController,
              decoration: const InputDecoration(
                labelText: 'Cidade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _aplicarFiltro,
                child: const Text('Aplicar filtro'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _limparFiltro,
                child: const Text('Limpar filtro'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}