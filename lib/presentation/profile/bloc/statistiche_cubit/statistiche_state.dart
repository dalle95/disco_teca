abstract class StatisticheState {}

class StatisticheLoading extends StatisticheState {}

class StatisticheLoaded extends StatisticheState {
  final int nDischi;
  final int nAlbum;
  final int nArtisti;
  final int nBrani;
  StatisticheLoaded({
    required this.nDischi,
    required this.nAlbum,
    required this.nArtisti,
    required this.nBrani,
  });
}

class StatisticheFailureLoad extends StatisticheState {
  final String errorMessage;
  StatisticheFailureLoad({required this.errorMessage});
}
