import 'package:flutter/material.dart';
import '../models/musico.dart';

class MusicoCard extends StatelessWidget {
  final Musico musico;
  final VoidCallback onDemonstrarInteresse;

  const MusicoCard({
    super.key,
    required this.musico,
    required this.onDemonstrarInteresse,
  });

  @override
  Widget build(BuildContext context) {
    final interesseEnviado = musico.interesseEnviado;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                child: Icon(Icons.music_note),
              ),
              title: Text(musico.nomeArtistico),
              subtitle: Text('${musico.generoMusical} • ${musico.cidade}'),
              trailing: Text('R\$ ${musico.cacheMedio.toStringAsFixed(0)}'),
            ),
            const SizedBox(height: 8),
            Text(musico.descricao),
            const SizedBox(height: 12),
            const Text(
              'Portfólio:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            if (musico.portfolioLinks.isEmpty)
              const Text('Nenhum link cadastrado.')
            else
              ...musico.portfolioLinks.map(
                (link) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(link),
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: interesseEnviado ? null : onDemonstrarInteresse,
                child: Text(
                  interesseEnviado
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