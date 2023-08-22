abstract class Statesdark {}
class InitialStatesdark extends Statesdark{}
class ChangeModeState extends Statesdark{}
class ChangeModeStateFail extends Statesdark{
  final String error;

  ChangeModeStateFail(this.error);
}
