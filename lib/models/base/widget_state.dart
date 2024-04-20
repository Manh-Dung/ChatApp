enum State { OK, ERROR, LOADING }

///
/// --------------------------------------------
/// There are several [State]s in this class.
/// The [Function]s and [State]s in this class are only to be used in classes that extend in [BaseViewModel].
/// You can find and use on your Controller wich is the Controller extends [BaseController].

///
/// --------------------------------------------
/// There are several [State]s in this class.
/// The [Function]s and [State]s in this class are only to be used in classes that extend in [BaseView].
/// You can find and use on your Controller wich is the Controller extends [BaseController].
mixin class ScreenState {
  State _screenState = State.LOADING;
  State screenStateLoading = State.LOADING;
  State screenStateOk = State.OK;
  State screenStateError = State.ERROR;

  State get getScreenState => this._screenState;

  set setScreenState(State event) => this._screenState = event;

  bool get screenStateIsLoading => this._screenState == screenStateLoading;

  bool get screenStateIsOK => this._screenState == screenStateOk;

  bool get screenStateIsError => this._screenState == screenStateError;
}
