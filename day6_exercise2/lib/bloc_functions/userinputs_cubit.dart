import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_day6/bloc_functions/userinputs_state.dart';

class DetectUserInput extends Cubit<UserInputsState> {
  DetectUserInput() : super(DetectUserInputsEmptyState());

  void ValidCheck() {
    emit(DetectUserInputsFilledState());
  }

  void InvalidCheck() {
    emit(DetectUserInputsEmptyState());
  }

  void toCapital(String userInput) {
    emit(CapitalizeState(userInput));
  }
}
