import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pharmatask/features/Authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/enums/auth_enum.dart';
import '../../data/model/auth_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignButton extends StatelessWidget {
  final AuthModel authModel;
  final AuthType authType;
  final VoidCallback callBack;
  final GlobalKey<FormState> formKey;
  const SignButton(
      {required this.authModel,
      required this.callBack,
      required this.authType,
      required this.formKey,
      super.key});

  @override
  Widget build(BuildContext context) {
    final authProv =
        BlocProvider.of<AuthenticationCubit>(context, listen: true);
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthLoadingSignInState ||
            state is AuthLoadingSignUpState) {
          return const CircularProgressIndicator();
        } else {
          return SizedBox(
            width: 130.w,
            child: ElevatedButton(
              child: AutoSizeText(
                authType == AuthType.signup ? 'Sign up' : 'Login',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                } else {
                  callBack();
                }
              },
            ),
          );
        }
      },
    );
  }
}
