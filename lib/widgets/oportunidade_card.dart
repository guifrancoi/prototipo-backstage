import 'package:flutter/material.dart';
import '../models/oportunidade.dart';

class OportunidadeCard extends StatelessWidget {
  final Oportunidade oportunidade;

  const OportunidadeCard({
    super.key,
    required this.oportunidade,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(oportunidade.titulo),
        subtitle: Text('${oportunidade.generoMusical} • ${oportunidade.cidade}'),
        trailing: Text('R\$ ${oportunidade.cacheOferecido.toStringAsFixed(0)}'),
      ),
    );
  }
}