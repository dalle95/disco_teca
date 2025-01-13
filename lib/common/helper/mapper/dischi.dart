import '/data/disco/models/disco.dart';
import '/domain/disco/entities/disco.dart';

class DischiMapper {
  static DiscoEntity toEntity(DiscoModel disco) {
    return DiscoEntity(
      id: disco.id,
      userID: disco.userID,
      titoloAlbum: disco.titoloAlbum,
      artista: disco.artista,
      anno: disco.anno,
      giri: disco.giri,
      posizione: disco.posizione,
      ordine: disco.ordine,
      valore: disco.valore,
      anteprima: disco.anteprima,
      brano1A: disco.brano1A,
      brano2A: disco.brano2A,
      brano3A: disco.brano3A,
      brano4A: disco.brano4A,
      brano5A: disco.brano5A,
      brano6A: disco.brano6A,
      brano7A: disco.brano7A,
      brano8A: disco.brano8A,
      brano1B: disco.brano1B,
      brano2B: disco.brano2B,
      brano3B: disco.brano3B,
      brano4B: disco.brano4B,
      brano5B: disco.brano5B,
      brano6B: disco.brano6B,
      brano7B: disco.brano7B,
      brano8B: disco.brano8B,
    );
  }
}
