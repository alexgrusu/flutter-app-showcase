import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  )   : email = '',
        password = '',
        loginInProgress = false;

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.email,
    required this.password,
    required this.loginInProgress,
  });

  final String email;

  final String password;

  final bool loginInProgress;

  @override
  bool get isLoginEnabled => email.isNotEmpty && password.isNotEmpty;

  @override
  bool get isAuthenticating => loginInProgress;

  LoginPresentationModel copyWith({
    String? email,
    String? password,
    bool? loginInProgress,
  }) {
    return LoginPresentationModel._(
      email: email ?? this.email,
      password: password ?? this.password,
      loginInProgress: loginInProgress ?? this.loginInProgress,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoginEnabled;

  bool get isAuthenticating;
}
