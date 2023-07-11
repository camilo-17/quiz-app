import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translate_this/models.dart';

class AppStateProps {
  List<bool> points;
  bool showNextQuestion;
  Options? selectedOption;
  AppStateProps(this.points, this.showNextQuestion, this.selectedOption);
}

abstract class AppStateEvent {
  const AppStateEvent();
}

class SetPointsEvent extends AppStateEvent {
  const SetPointsEvent();
}

class UnSetPointsEvent extends AppStateEvent {
  const UnSetPointsEvent();
}

class AppStateBloc extends Bloc<AppStateEvent, AppStateProps> {
  AppStateBloc(AppStateProps initState) : super(initState) {
    on<SetPointsEvent>((event, emit) {
      emit(AppStateProps(
          state.points, state.showNextQuestion, state.selectedOption));
    });
    on<UnSetPointsEvent>((event, emit) {
      // emit(AppStateProps([false]));
    });
  }
}
