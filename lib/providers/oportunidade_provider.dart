import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/interesse.dart';
import '../models/interesse_musico.dart';
import '../models/musico.dart';
import '../models/oportunidade.dart';

class OportunidadeProvider extends ChangeNotifier {
  List<Musico> _musicos = [...MockData.musicos];
  List<Oportunidade> _oportunidades = [...MockData.oportunidades];

  final List<Interesse> _interesses = [];
  final List<InteresseMusico> _interessesMusicos = [];

  String? _generoSelecionadoMusicos;
  String? _cidadeFiltroMusicos;

  List<Musico> get musicos => _musicos;
  List<Oportunidade> get oportunidades => _oportunidades;
  List<Interesse> get interesses => _interesses;
  List<InteresseMusico> get interessesMusicos => _interessesMusicos;

  String? get generoSelecionadoMusicos => _generoSelecionadoMusicos;
  String? get cidadeFiltroMusicos => _cidadeFiltroMusicos;

  List<Oportunidade> get oportunidadesComInteresse =>
      _oportunidades.where((o) => o.interesseEnviado).toList();

  List<Musico> get musicosComInteresse =>
      _musicos.where((m) => m.interesseEnviado).toList();

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

    // reaplica status de interesse dos músicos já marcados
    for (var i = 0; i < _musicos.length; i++) {
      final interesseExiste = _interessesMusicos.any(
        (interesse) => interesse.musicoId == _musicos[i].id,
      );

      if (interesseExiste && !_musicos[i].interesseEnviado) {
        _musicos[i] = _musicos[i].copyWith(interesseEnviado: true);
      }
    }

    notifyListeners();
  }

  void resetarFiltroMusicos() {
    _generoSelecionadoMusicos = null;
    _cidadeFiltroMusicos = null;
    _musicos = [...MockData.musicos];

    for (var i = 0; i < _musicos.length; i++) {
      final interesseExiste = _interessesMusicos.any(
        (interesse) => interesse.musicoId == _musicos[i].id,
      );

      _musicos[i] = _musicos[i].copyWith(interesseEnviado: interesseExiste);
    }

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

    for (var i = 0; i < _oportunidades.length; i++) {
      final interesseExiste = _interesses.any(
        (interesse) => interesse.oportunidadeId == _oportunidades[i].id,
      );

      if (interesseExiste && !_oportunidades[i].interesseEnviado) {
        _oportunidades[i] = _oportunidades[i].copyWith(interesseEnviado: true);
      }
    }

    notifyListeners();
  }

  void resetarFiltroOportunidades() {
    _oportunidades = [...MockData.oportunidades];

    for (var i = 0; i < _oportunidades.length; i++) {
      final interesseExiste = _interesses.any(
        (interesse) => interesse.oportunidadeId == _oportunidades[i].id,
      );

      _oportunidades[i] =
          _oportunidades[i].copyWith(interesseEnviado: interesseExiste);
    }

    notifyListeners();
  }

  bool jaDemonstrouInteresse(String oportunidadeId) {
    return _oportunidades.any(
      (o) => o.id == oportunidadeId && o.interesseEnviado,
    );
  }

  void demonstrarInteresse({
    required String oportunidadeId,
    required String usuarioId,
  }) {
    final index = _oportunidades.indexWhere((o) => o.id == oportunidadeId);
    if (index == -1) return;

    if (_oportunidades[index].interesseEnviado) return;

    _interesses.add(
      Interesse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        oportunidadeId: oportunidadeId,
        usuarioId: usuarioId,
        dataHora: DateTime.now(),
      ),
    );

    _oportunidades[index] = _oportunidades[index].copyWith(
      interesseEnviado: true,
    );

    notifyListeners();
  }

  void removerInteresse(String oportunidadeId) {
    final index = _oportunidades.indexWhere((o) => o.id == oportunidadeId);
    if (index == -1) return;

    _oportunidades[index] = _oportunidades[index].copyWith(
      interesseEnviado: false,
    );

    _interesses.removeWhere((i) => i.oportunidadeId == oportunidadeId);

    notifyListeners();
  }

  void demonstrarInteresseEmMusico({
    required String musicoId,
    required String usuarioId,
  }) {
    final index = _musicos.indexWhere((m) => m.id == musicoId);
    if (index == -1) return;

    if (_musicos[index].interesseEnviado) return;

    _interessesMusicos.add(
      InteresseMusico(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        musicoId: musicoId,
        usuarioId: usuarioId,
        dataHora: DateTime.now(),
      ),
    );

    _musicos[index] = _musicos[index].copyWith(
      interesseEnviado: true,
    );

    notifyListeners();
  }

  void removerInteresseEmMusico(String musicoId) {
    final index = _musicos.indexWhere((m) => m.id == musicoId);
    if (index == -1) return;

    _musicos[index] = _musicos[index].copyWith(
      interesseEnviado: false,
    );

    _interessesMusicos.removeWhere((i) => i.musicoId == musicoId);

    notifyListeners();
  }
}