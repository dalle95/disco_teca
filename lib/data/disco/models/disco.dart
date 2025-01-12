class DiscoModel {
  final String? id;
  final String? userID;
  final String? giri;
  final String? artista;
  final String? posizione;
  final int? ordine;
  final String? titoloAlbum;
  final String? anno;
  final double? valore;
  final String? anteprima;
  final String? brano1A;
  final String? brano2A;
  final String? brano3A;
  final String? brano4A;
  final String? brano5A;
  final String? brano6A;
  final String? brano7A;
  final String? brano8A;
  final String? brano1B;
  final String? brano2B;
  final String? brano3B;
  final String? brano4B;
  final String? brano5B;
  final String? brano6B;
  final String? brano7B;
  final String? brano8B;

  const DiscoModel({
    this.id,
    this.userID,
    this.giri,
    this.artista,
    this.posizione,
    this.ordine,
    this.titoloAlbum,
    this.anno,
    this.valore,
    this.anteprima,
    this.brano1A,
    this.brano2A,
    this.brano3A,
    this.brano4A,
    this.brano5A,
    this.brano6A,
    this.brano7A,
    this.brano8A,
    this.brano1B,
    this.brano2B,
    this.brano3B,
    this.brano4B,
    this.brano5B,
    this.brano6B,
    this.brano7B,
    this.brano8B,
  });

  factory DiscoModel.empty() {
    return const DiscoModel(
      id: null,
      userID: null,
      giri: '33',
      artista: '',
      posizione: '',
      ordine: 0,
      titoloAlbum: '',
      anno: '',
      valore: 0,
      anteprima: null,
      brano1A: '',
      brano2A: '',
      brano3A: '',
      brano4A: '',
      brano5A: '',
      brano6A: '',
      brano7A: '',
      brano8A: '',
      brano1B: '',
      brano2B: '',
      brano3B: '',
      brano4B: '',
      brano5B: '',
      brano6B: '',
      brano7B: '',
      brano8B: '',
    );
  }

  DiscoModel copyWith({
    String? id,
    String? userID,
    String? tipologia,
    String? autore,
    String? posizione,
    int? ordine,
    String? titoloAlbum,
    String? anno,
    double? valore,
    String? anteprima,
    String? brano1A,
    String? brano2A,
    String? brano3A,
    String? brano4A,
    String? brano5A,
    String? brano6A,
    String? brano7A,
    String? brano8A,
    String? brano1B,
    String? brano2B,
    String? brano3B,
    String? brano4B,
    String? brano5B,
    String? brano6B,
    String? brano7B,
    String? brano8B,
  }) {
    return DiscoModel(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      giri: tipologia ?? giri,
      artista: autore ?? artista,
      posizione: posizione ?? this.posizione,
      ordine: ordine ?? this.ordine,
      titoloAlbum: titoloAlbum ?? this.titoloAlbum,
      anno: anno ?? this.anno,
      valore: valore ?? this.valore,
      anteprima: anteprima ?? this.anteprima,
      brano1A: brano1A ?? this.brano1A,
      brano2A: brano2A ?? this.brano2A,
      brano3A: brano3A ?? this.brano3A,
      brano4A: brano4A ?? this.brano4A,
      brano5A: brano5A ?? this.brano5A,
      brano6A: brano6A ?? this.brano6A,
      brano7A: brano7A ?? this.brano7A,
      brano8A: brano8A ?? this.brano8A,
      brano1B: brano1B ?? this.brano1B,
      brano2B: brano2B ?? this.brano2B,
      brano3B: brano3B ?? this.brano3B,
      brano4B: brano4B ?? this.brano4B,
      brano5B: brano5B ?? this.brano5B,
      brano6B: brano6B ?? this.brano6B,
      brano7B: brano7B ?? this.brano7B,
      brano8B: brano8B ?? this.brano8B,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'tipologia': giri,
      'autore': artista,
      'posizione': posizione,
      'ordine': ordine,
      'titoloAlbum': titoloAlbum,
      'anno': anno,
      'valore': valore,
      'anteprima': anteprima,
      'brano1A': brano1A,
      'brano2A': brano2A,
      'brano3A': brano3A,
      'brano4A': brano4A,
      'brano5A': brano5A,
      'brano6A': brano6A,
      'brano7A': brano7A,
      'brano8A': brano8A,
      'brano1B': brano1B,
      'brano2B': brano2B,
      'brano3B': brano3B,
      'brano4B': brano4B,
      'brano5B': brano5B,
      'brano6B': brano6B,
      'brano7B': brano7B,
      'brano8B': brano8B,
    };
  }

  static DiscoModel fromJson(Map<String, dynamic> json) {
    return DiscoModel(
      id: json['id'],
      userID: json['userID'],
      giri: json['tipologia'],
      artista: json['autore'],
      posizione: json['posizione'],
      ordine: json['ordine'],
      titoloAlbum: json['titoloAlbum'],
      anno: json['anno'],
      valore: // Use type-safe conversion for both int and double
          (json['valore'] is int)
              ? (json['valore'] as int).toDouble()
              : double.tryParse(json['valore'].toString()) ?? 0.0,
      anteprima: json['anteprima'],
      brano1A: json['brano1A'],
      brano2A: json['brano2A'],
      brano3A: json['brano3A'],
      brano4A: json['brano4A'],
      brano5A: json['brano5A'],
      brano6A: json['brano6A'],
      brano7A: json['brano7A'],
      brano8A: json['brano8A'],
      brano1B: json['brano1B'],
      brano2B: json['brano2B'],
      brano3B: json['brano3B'],
      brano4B: json['brano4B'],
      brano5B: json['brano5B'],
      brano6B: json['brano6B'],
      brano7B: json['brano7B'],
      brano8B: json['brano8B'],
    );
  }
}
