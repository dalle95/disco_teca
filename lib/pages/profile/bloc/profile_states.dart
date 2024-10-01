class ProfileState {
  const ProfileState({
    this.email,
    this.nDischi,
    this.versioneApp = '1.0.0',
  });

  final String? email;
  final int? nDischi;
  final String versioneApp;

  ProfileState copyWith({
    String? email,
    int? nDischi,
    String? versioneApp,
  }) {
    return ProfileState(
      email: email ?? this.email,
      nDischi: nDischi ?? this.nDischi,
      versioneApp: versioneApp ?? this.versioneApp,
    );
  }
}

class ProfileLoadingState extends ProfileState {
  ProfileLoadingState() : super();
}
