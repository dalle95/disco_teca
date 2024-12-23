import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/dettaglio_disco/bloc/ui_state/ui_state_state.dart';

class UIStateCubit extends Cubit<UIState> {
  UIStateCubit() : super(Idle());

  void setLoading() => emit(Loading());
  void setError(String message) => emit(Error(message));
  void setSuccess(String message) => emit(Success(message: message));
}
