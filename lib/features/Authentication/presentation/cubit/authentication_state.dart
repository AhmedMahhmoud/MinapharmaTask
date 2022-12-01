part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthLoadingSignInState extends AuthenticationState {}

class AuthLoadingSignUpState extends AuthenticationState {}

class LoadedAuthState extends AuthenticationState {
  final AuthModel _authModel;
  LoadedAuthState(this._authModel);
  @override
  List<Object> get props => [_authModel];
}

class ErrorAuthState extends AuthenticationInitial {
  final String message;

  ErrorAuthState({required this.message});

  @override
  List<Object> get props => [message];
}
