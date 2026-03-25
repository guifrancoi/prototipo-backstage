import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/musico.dart';
import '../models/oportunidade.dart';

class OportunidadeProvider extends ChangeNotifier {
  List<Musico> _musicos = [...MockData.musicos];
  List<Oportunidade> _oportunidades = [...MockData.oportunidades];

  String? _generoSelecionadoMusicos;
  String? _cidadeFiltroMusicos;

  List<Musico> get musicos => _musicos;
  List<Oportunidade> get oportunidades => _oportunidades;

  String? get generoSelecionadoMusicos => _generoSelecionadoMusicos;
  String? get cidadeFiltroMusicos => _cidadeFiltroMusicos;

  void filtrarMusicos({
    String? genero,
    String? cidade,
  }) {
    _generoSelecionadoMusicos = genero;
    _cidadeFiltroMusicos = cidade;

    _musicos = MockData.musicos.where((m) {
      final generoValido =
          genero == null || genero.isEmpty || m.generoMusical == genero;

      final cidadeValida = cidade == null ||
          cidade.isEmpty ||
          m.cidade.toLowerCase().contains(cidade.toLowerCase());

      return generoValido && cidadeValida;
    }).toList();

    notifyListeners();
  }

  void resetarFiltroMusicos() {
    _generoSelecionadoMusicos = null;
    _cidadeFiltroMusicos = null;
    _musicos = [...MockData.musicos];
    notifyListeners();
  }

  void filtrarOportunidades({
    String? genero,
    String? cidade,
  }) {
    _oportunidades = MockData.oportunidades.where((o) {
      final generoValido =
          genero == null || genero.isEmpty || o.generoMusical == genero;

      final cidadeValida = cidade == null ||
          cidade.isEmpty ||
          o.cidade.toLowerCase().contains(cidade.toLowerCase());

      return generoValido && cidadeValida;
    }).toList();

    notifyListeners();
  }

  void resetarFiltroOportunidades() {
    _oportunidades = [...MockData.oportunidades];
    notifyListeners();
  }
}