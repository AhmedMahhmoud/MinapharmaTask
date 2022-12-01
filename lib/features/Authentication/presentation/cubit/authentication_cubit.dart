import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmatask/Core/enums/auth_enum.dart';
import 'package:pharmatask/features/Authentication/data/model/auth_model.dart';
import 'package:pharmatask/features/Authentication/domain/usecases/login_usecase.dart';
import 'package:pharmatask/features/Authentication/domain/usecases/sign_up_usecase.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required this.loginUsecase, required this.signUpUsecase})
      : super(AuthenticationInitial());

  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;

  Future<void> login(AuthModel authModel) async {
    handleAuth(AuthType.login, authModel);
  }

  Future<void> signUp(AuthModel authModel) async {
    handleAuth(AuthType.signup, authModel);
  }

  handleAuth(AuthType authType, AuthModel authModel) async {
    try {
      if (authType == AuthType.login) {
        {
          emit(AuthLoadingSignInState());
          await Future.delayed(const Duration(milliseconds: 350));
          await loginUsecase(authModel);
        }
      } else if (authType == AuthType.signup) {
        emit(AuthLoadingSignUpState());
        await Future.delayed(const Duration(milliseconds: 350));
        await signUpUsecase(authModel);
      }
      emit(LoadedAuthState(authModel));
    } catch (e) {
      emit(ErrorAuthState(message: e.toString()));
      return;
    }
  }
}
