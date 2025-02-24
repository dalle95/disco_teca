import '/domain/disco/entities/disco.dart';

class DischiCubitState {
  final bool isLoading;
  final String? errorMessage;

  final List<DiscoEntity> dischi; // Complete list
  final List<DiscoEntity> dischiFiltrati; // Filtered list

  const DischiCubitState({
    this.isLoading = false,
    this.errorMessage,
    this.dischi = const [],
    this.dischiFiltrati = const [],
  });

  DischiCubitState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<DiscoEntity>? dischi,
    List<DiscoEntity>? dischiFiltrati,
  }) {
    return DischiCubitState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      dischi: dischi ?? this.dischi,
      dischiFiltrati: dischiFiltrati ?? this.dischiFiltrati,
    );
  }
}
