import 'package:flutter/material.dart';
import '../models/musico.dart';

class MusicoCard extends StatelessWidget {
  final Musico musico;

  const MusicoCard({
    super.key,
    required this.musico,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.music_note),
        ),
        title: Text(musico.nomeArtistico),
        subtitle: Text('${musico.generoMusical} • ${musico.cidade}'),
        trailing: Text('R\$ ${musico.cacheMedio.toStringAsFixed(0)}'),
      ),
    );
  }
}