import 'package:bloc/bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0); // Partiamo dalla prima slide

  void nextPage(int index) {
    emit(index); // Aggiorna l'indice della pagina corrente
  }
}
