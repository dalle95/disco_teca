import 'package:app_disco_teca/domain/disco/entities/disco.dart';

abstract class DischiState {}

class DischiLoading extends DischiState {}

class DischiLoaded extends DischiState {
  final List<DiscoEntity> dischi;
  DischiLoaded({required this.dischi});
}

class DischiFailureLoad extends DischiState {
  final String errorMessage;
  DischiFailureLoad({required this.errorMessage});
}
