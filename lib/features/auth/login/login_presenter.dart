import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';

import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPresenter extends Cubit<LoginViewModel>
    with CubitToCubitCommunicationMixin<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.useCase,
    this.navigator,
  );

  final LoginNavigator navigator;
  final LogInUseCase useCase;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  void updateEmail(String inputEmail) {
    emit(_model.copyWith(email: inputEmail));
  }

  void updatePassword(String inputPassword) {
    emit(_model.copyWith(password: inputPassword));
  }

  Future<void> login() async {
    if (!_model.loginInProgress) {
      emit(_model.copyWith(loginInProgress: true));
      await await useCase
          .execute(username: _model.email, password: _model.password)
          .observeStatusChanges(
        (result) {
          if (result.status != FutureStatus.pending) {
            emit(_model.copyWith(loginInProgress: false));
          }
        },
      ).asyncFold(
        (failure) => navigator.showError(failure.displayableFailure()),
        (succeeded) => navigator.showAlert(
          title: appLocalizations.logInSucceededStatus,
          message: appLocalizations.logInSucceededMessage,
        ),
      );
    }
  }
}
