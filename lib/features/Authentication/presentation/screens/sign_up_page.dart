import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmatask/Core/Shared/Methods/shared_methods.dart';
import 'package:pharmatask/Core/enums/auth_enum.dart';
import 'package:pharmatask/features/Authentication/presentation/cubit/authentication_cubit.dart';
import 'package:pharmatask/features/Authentication/presentation/widgets/sign_button.dart';
import 'package:pharmatask/features/Authentication/presentation/widgets/sign_snackbar.dart';
import '../../data/model/auth_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: BlocListener<AuthenticationCubit, AuthenticationState>(
          listenWhen: (previous, current) => previous is AuthLoadingSignUpState,
          listener: (context, state) {
            if (state is ErrorAuthState) {
              log("entered SignUpPage");
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: SignSnackbar(
                message: state.message,
                success: false,
              )));
            } else if (state is LoadedAuthState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: SignSnackbar(
                message:
                    "Successfully registered\nPlease go to the login page now .",
                success: true,
              )));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  'Sign up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.sp,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        controller: _email,
                        validator: (value) {
                          return SharedMethods.validate(value!, "Username");
                        },
                        decoration: InputDecoration(
                          hintText: '  Enter your username',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        controller: _password,
                        validator: (value) {
                          return SharedMethods.validate(value!, "Password");
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: '  Enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SignButton(
                          authType: AuthType.signup,
                          authModel: AuthModel(
                              username: _email.text, password: _password.text),
                          formKey: _formKey),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AutoSizeText('Already registered?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, "sign_in");
                            },
                            child: const AutoSizeText(
                              'Sign in',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
