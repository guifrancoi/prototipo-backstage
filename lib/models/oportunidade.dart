class Oportunidade {
  final String id;
  final String titulo;
  final String descricao;
  final String cidade;
  final String generoMusical;
  final DateTime dataEvento;
  final double cacheOferecido;
  final String contratante;
  final bool interesseEnviado;

  Oportunidade({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.cidade,
    required this.generoMusical,
    required this.dataEvento,
    required this.cacheOferecido,
    required this.contratante,
    bool? interesseEnviado,
  }) : interesseEnviado = interesseEnviado ?? false;

  Oportunidade copyWith({
    String? id,
    String? titulo,
    String? descricao,
    String? cidade,
    String? generoMusical,
    DateTime? dataEvento,
    double? cacheOferecido,
    String? contratante,
    bool? interesseEnviado,
  }) {
    return Oportunidade(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      cidade: cidade ?? this.cidade,
      generoMusical: generoMusical ?? this.generoMusical,
      dataEvento: dataEvento ?? this.dataEvento,
      cacheOferecido: cacheOferecido ?? this.cacheOferecido,
      contratante: contratante ?? this.contratante,
      interesseEnviado: interesseEnviado ?? this.interesseEnviado,
    );
  }

  factory Oportunidade.fromMap(String id, Map<String, dynamic> map) {
    return Oportunidade(
      id: id,
      titulo: map['titulo'] as String? ?? '',
      descricao: map['descricao'] as String? ?? '',
      cidade: map['cidade'] as String? ?? '',
      generoMusical: map['generoMusical'] as String? ?? '',
      dataEvento: _dateTimeFromValue(map['dataEvento']),
      cacheOferecido: (map['cacheOferecido'] as num?)?.toDouble() ?? 0,
      contratante: map['contratante'] as String? ?? '',
      interesseEnviado: map['interesseEnviado'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'cidade': cidade,
      'generoMusical': generoMusical,
      'dataEvento': dataEvento,
      'cacheOferecido': cacheOferecido,
      'contratante': contratante,
      'interesseEnviado': interesseEnviado,
    };
  }
}

DateTime _dateTimeFromValue(dynamic value) {
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value) ?? DateTime.now();

  try {
    return value.toDate() as DateTime;
  } catch (_) {
    return DateTime.now();
  }
}
