import 'package:flutter/material.dart';
import '../models/oportunidade.dart';

class OportunidadeCard extends StatelessWidget {
  final Oportunidade oportunidade;
  final VoidCallback onDemonstrarInteresse;

  const OportunidadeCard({
    super.key,
    required this.oportunidade,
    required this.onDemonstrarInteresse,
  });

  String get dataFormatada {
    final data = oportunidade.dataEvento;
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              oportunidade.titulo,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Contratante: ${oportunidade.contratante}'),
            Text('Cidade: ${oportunidade.cidade}'),
            Text('Gênero: ${oportunidade.generoMusical}'),
            Text('Data: $dataFormatada'),
            Text(
              'Cachê: R\$ ${oportunidade.cacheOferecido.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 8),
            Text(oportunidade.descricao),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: oportunidade.interesseEnviado
                    ? null
                    : onDemonstrarInteresse,
                child: Text(
                  oportunidade.interesseEnviado
                      ? 'Interesse enviado'
                      : 'Demonstrar interesse',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}