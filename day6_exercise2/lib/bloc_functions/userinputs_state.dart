abstract class UserInputsState {}

class DetectUserInputsFilledState extends UserInputsState {}

class DetectUserInputsEmptyState extends UserInputsState {}

class CapitalizeState extends UserInputsState {
  late String userStr;

  CapitalizeState(String inputData) {
    userStr = inputData.toUpperCase();
  }
}
