import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/musico.dart';
import '../models/oportunidade.dart';

class OportunidadeProvider extends ChangeNotifier {
  List<Musico> _musicos = [...MockData.musicos];
  List<Oportunidade> _oportunidades = [...MockData.oportunidades];

  List<Musico> get musicos => _musicos;
  List<Oportunidade> get oportunidades => _oportunidades;

  void filtrarMusicos({
    String? genero,
    String? cidade,
  }) {
    _musicos = MockData.musicos.where((m) {
      final generoValido = genero == null || genero.isEmpty || m.generoMusical == genero;
      final cidadeValida = cidade == null || cidade.isEmpty || m.cidade == cidade;
      return generoValido && cidadeValida;
    }).toList();

    notifyListeners();
  }

  void resetarFiltroMusicos() {
    _musicos = [...MockData.musicos];
    notifyListeners();
  }

  void filtrarOportunidades({
    String? genero,
    String? cidade,
  }) {
    _oportunidades = MockData.oportunidades.where((o) {
      final generoValido = genero == null || genero.isEmpty || o.generoMusical == genero;
      final cidadeValida = cidade == null || cidade.isEmpty || o.cidade == cidade;
      return generoValido && cidadeValida;
    }).toList();

    notifyListeners();
  }

  void resetarFiltroOportunidades() {
    _oportunidades = [...MockData.oportunidades];
    notifyListeners();
  }
}