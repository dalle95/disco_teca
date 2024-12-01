abstract class DownloadState {
  const DownloadState();
}

class DownloadInitial extends DownloadState {}

class DownloadInProgress extends DownloadState {
  final double progress;

  const DownloadInProgress(this.progress);
}

class DownloadSuccess extends DownloadState {
  final String filePath;

  const DownloadSuccess(this.filePath);
}

class DownloadFailure extends DownloadState {
  final String error;

  const DownloadFailure(this.error);
}
