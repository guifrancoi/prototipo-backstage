import 'dart:async';

import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/interesse.dart';
import '../models/interesse_musico.dart';
import '../models/musico.dart';
import '../models/oportunidade.dart';
import '../services/firebase_data_service.dart';

class OportunidadeProvider extends ChangeNotifier {
  OportunidadeProvider({FirebaseDataService? service})
    : _service = service ?? FirebaseDataService() {
    if (_service.isEnabled) {
      _authSubscription = _service.authUserIds.listen((_) => carregarDados());
      carregarDados();
    }
  }

  final FirebaseDataService _service;
  StreamSubscription<String?>? _authSubscription;

  List<Musico> _todosMusicos = [...MockData.musicos];
  List<Oportunidade> _todasOportunidades = [...MockData.oportunidades];
  List<Musico> _musicos = [...MockData.musicos];
  List<Oportunidade> _oportunidades = [...MockData.oportunidades];

  List<Interesse> _interesses = [];
  List<InteresseMusico> _interessesMusicos = [];

  bool _isLoading = false;
  String? _generoSelecionadoMusicos;
  String? _cidadeFiltroMusicos;

  List<Musico> get musicos => _musicos;
  List<Oportunidade> get oportunidades => _oportunidades;
  List<Interesse> get interesses => _interesses;
  List<InteresseMusico> get interessesMusicos => _interessesMusicos;
  bool get isLoading => _isLoading;

  String? get generoSelecionadoMusicos => _generoSelecionadoMusicos;
  String? get cidadeFiltroMusicos => _cidadeFiltroMusicos;

  List<Oportunidade> get oportunidadesComInteresse =>
      _oportunidades.where((o) => o.interesseEnviado).toList();

  List<Musico> get musicosComInteresse =>
      _musicos.where((m) => m.interesseEnviado).toList();

  Future<void> carregarDados() async {
    if (!_service.isEnabled) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _service.seedDadosIniciais();

      final usuarioId = _service.currentUserId;
      final results = await Future.wait([
        _service.listarMusicos(),
        _service.listarOportunidades(),
        if (usuarioId != null) _service.listarInteresses(usuarioId),
        if (usuarioId != null) _service.listarInteressesMusicos(usuarioId),
      ]);

      _todosMusicos = results[0] as List<Musico>;
      _todasOportunidades = results[1] as List<Oportunidade>;
      _interesses = usuarioId == null ? [] : results[2] as List<Interesse>;
      _interessesMusicos = usuarioId == null
          ? []
          : results[3] as List<InteresseMusico>;

      _aplicarStatusInteresses();
      _aplicarFiltrosAtuais();
    } catch (_) {
      _todosMusicos = [...MockData.musicos];
      _todasOportunidades = [...MockData.oportunidades];
      _interesses = [];
      _interessesMusicos = [];
      _aplicarStatusInteresses();
      _aplicarFiltrosAtuais();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filtrarMusicos({String? genero, String? cidade}) {
    _generoSelecionadoMusicos = genero;
    _cidadeFiltroMusicos = cidade;
    _aplicarFiltrosAtuais();
    notifyListeners();
  }

  void resetarFiltroMusicos() {
    _generoSelecionadoMusicos = null;
    _cidadeFiltroMusicos = null;
    _aplicarFiltrosAtuais();
    notifyListeners();
  }

  void filtrarOportunidades({String? genero, String? cidade}) {
    _oportunidades = _todasOportunidades.where((o) {
      final generoValido =
          genero == null || genero.isEmpty || o.generoMusical == genero;

      final cidadeValida =
          cidade == null ||
          cidade.isEmpty ||
          o.cidade.toLowerCase().contains(cidade.toLowerCase());

      return generoValido && cidadeValida;
    }).toList();

    notifyListeners();
  }

  void resetarFiltroOportunidades() {
    _oportunidades = [..._todasOportunidades];
    notifyListeners();
  }

  bool jaDemonstrouInteresse(String oportunidadeId) {
    return _oportunidades.any(
      (o) => o.id == oportunidadeId && o.interesseEnviado,
    );
  }

  Future<void> demonstrarInteresse({
    required String oportunidadeId,
    required String usuarioId,
  }) async {
    final index = _oportunidades.indexWhere((o) => o.id == oportunidadeId);
    if (index == -1 || _oportunidades[index].interesseEnviado) return;

    final idUsuario = _usuarioId(usuarioId);
    final interesse = Interesse(
      id: '${idUsuario}_$oportunidadeId',
      oportunidadeId: oportunidadeId,
      usuarioId: idUsuario,
      dataHora: DateTime.now(),
    );

    _interesses.add(interesse);
    _marcarOportunidade(oportunidadeId, interesseEnviado: true);
    notifyListeners();

    if (_service.isEnabled) {
      await _service.salvarInteresse(interesse);
    }
  }

  Future<void> removerInteresse(String oportunidadeId) async {
    final interesse = _interesses
        .where((i) => i.oportunidadeId == oportunidadeId)
        .firstOrNull;

    _interesses.removeWhere((i) => i.oportunidadeId == oportunidadeId);
    _marcarOportunidade(oportunidadeId, interesseEnviado: false);
    notifyListeners();

    if (_service.isEnabled && interesse != null) {
      await _service.removerInteresse(interesse.id);
    }
  }

  Future<void> demonstrarInteresseEmMusico({
    required String musicoId,
    required String usuarioId,
  }) async {
    final index = _musicos.indexWhere((m) => m.id == musicoId);
    if (index == -1 || _musicos[index].interesseEnviado) return;

    final idUsuario = _usuarioId(usuarioId);
    final interesse = InteresseMusico(
      id: '${idUsuario}_$musicoId',
      musicoId: musicoId,
      usuarioId: idUsuario,
      dataHora: DateTime.now(),
    );

    _interessesMusicos.add(interesse);
    _marcarMusico(musicoId, interesseEnviado: true);
    notifyListeners();

    if (_service.isEnabled) {
      await _service.salvarInteresseMusico(interesse);
    }
  }

  Future<void> removerInteresseEmMusico(String musicoId) async {
    final interesse = _interessesMusicos
        .where((i) => i.musicoId == musicoId)
        .firstOrNull;

    _interessesMusicos.removeWhere((i) => i.musicoId == musicoId);
    _marcarMusico(musicoId, interesseEnviado: false);
    notifyListeners();

    if (_service.isEnabled && interesse != null) {
      await _service.removerInteresseMusico(interesse.id);
    }
  }

  Musico? buscarMusicoPorId(String id) {
    try {
      return _musicos.firstWhere((m) => m.id == id);
    } catch (_) {
      try {
        return _todosMusicos.firstWhere((m) => m.id == id);
      } catch (_) {
        return null;
      }
    }
  }

  Oportunidade? buscarOportunidadePorId(String id) {
    try {
      return _oportunidades.firstWhere((o) => o.id == id);
    } catch (_) {
      try {
        return _todasOportunidades.firstWhere((o) => o.id == id);
      } catch (_) {
        return null;
      }
    }
  }

  void _aplicarStatusInteresses() {
    _todosMusicos = _todosMusicos.map((musico) {
      final interesseExiste = _interessesMusicos.any(
        (interesse) => interesse.musicoId == musico.id,
      );
      return musico.copyWith(interesseEnviado: interesseExiste);
    }).toList();

    _todasOportunidades = _todasOportunidades.map((oportunidade) {
      final interesseExiste = _interesses.any(
        (interesse) => interesse.oportunidadeId == oportunidade.id,
      );
      return oportunidade.copyWith(interesseEnviado: interesseExiste);
    }).toList();
  }

  void _aplicarFiltrosAtuais() {
    _musicos = _todosMusicos.where((m) {
      final genero = _generoSelecionadoMusicos;
      final cidade = _cidadeFiltroMusicos;

      final generoValido =
          genero == null || genero.isEmpty || m.generoMusical == genero;

      final cidadeValida =
          cidade == null ||
          cidade.isEmpty ||
          m.cidade.toLowerCase().contains(cidade.toLowerCase());

      return generoValido && cidadeValida;
    }).toList();

    _oportunidades = [..._todasOportunidades];
  }

  void _marcarMusico(String musicoId, {required bool interesseEnviado}) {
    _todosMusicos = _todosMusicos
        .map(
          (musico) => musico.id == musicoId
              ? musico.copyWith(interesseEnviado: interesseEnviado)
              : musico,
        )
        .toList();
    _aplicarFiltrosAtuais();
  }

  void _marcarOportunidade(
    String oportunidadeId, {
    required bool interesseEnviado,
  }) {
    _todasOportunidades = _todasOportunidades
        .map(
          (oportunidade) => oportunidade.id == oportunidadeId
              ? oportunidade.copyWith(interesseEnviado: interesseEnviado)
              : oportunidade,
        )
        .toList();
    _aplicarFiltrosAtuais();
  }

  String _usuarioId(String fallback) {
    return _service.currentUserId ?? fallback;
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
