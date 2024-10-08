class ProfileState {
  const ProfileState({
    this.email,
    this.nDischi,
    this.nAlbum,
    this.nArtisti,
    this.nBrani,
    this.versioneApp = '1.0.0',
  });

  final String? email;
  final int? nDischi;
  final int? nAlbum;
  final int? nArtisti;
  final int? nBrani;
  final String versioneApp;

  ProfileState copyWith({
    String? email,
    int? nDischi,
    int? nAlbum,
    int? nArtisti,
    int? nBrani,
    String? versioneApp,
  }) {
    return ProfileState(
      email: email ?? this.email,
      nDischi: nDischi ?? this.nDischi,
      nAlbum: nAlbum ?? this.nAlbum,
      nArtisti: nArtisti ?? this.nArtisti,
      nBrani: nBrani ?? this.nBrani,
      versioneApp: versioneApp ?? this.versioneApp,
    );
  }
}

class ProfileLoadingState extends ProfileState {
  ProfileLoadingState() : super();
}
