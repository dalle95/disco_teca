abstract class FiltroDischiEvent {}

class LoadingEvent extends FiltroDischiEvent {
  LoadingEvent();
}

class FiltroDischiInitEvent extends FiltroDischiEvent {
  final String? posizione;
  List<String> listaPosizioni;
  FiltroDischiInitEvent({
    this.posizione,
    this.listaPosizioni = const [],
  });
}

class UpdatePosizioneEvent extends FiltroDischiEvent {
  final String posizione;
  UpdatePosizioneEvent({required this.posizione});
}

class UpdateGiriEvent extends FiltroDischiEvent {
  final String giri;
  UpdateGiriEvent({required this.giri});
}
