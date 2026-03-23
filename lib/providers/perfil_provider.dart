import 'package:flutter/material.dart';
import '../models/musico.dart';

class PerfilProvider extends ChangeNotifier {
  Musico? _perfilMusico;

  Musico? get perfilMusico => _perfilMusico;

  void carregarPerfilMock() {
    _perfilMusico = Musico(
      id: '1',
      nomeArtistico: 'The VooDooS',
      generoMusical: 'Metal',
      cidade: 'Ribeirão Preto',
      descricao: 'Banda com repertório nacional e internacional.',
      cacheMedio: 1200,
      portfolioLinks: [
        'hhttps://www.youtube.com/@thevoodoosoficial',
        'https://www.instagram.com/voodoos.ofc/',
      ],
      datasDisponiveis: ['2026-03-20', '2026-03-25'],
      fotoPath: null,
    );
    notifyListeners();
  }

  void atualizarPerfil({
    required String nomeArtistico,
    required String generoMusical,
    required String cidade,
    required double cacheMedio,
    required String descricao,
    required List<String> portfolioLinks,
    String? fotoPath,
  }) {
    if (_perfilMusico == null) return;

    _perfilMusico = _perfilMusico!.copyWith(
      nomeArtistico: nomeArtistico,
      generoMusical: generoMusical,
      cidade: cidade,
      cacheMedio: cacheMedio,
      descricao: descricao,
      portfolioLinks: portfolioLinks,
      fotoPath: fotoPath,
    );

    notifyListeners();
  }
}