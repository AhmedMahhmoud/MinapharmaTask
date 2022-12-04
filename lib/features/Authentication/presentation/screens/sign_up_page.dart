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

import '../widgets/already_registered_display.dart';
import '../widgets/sign_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

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
                         FormFieldInput(controller: _email,authField: AuthFields.username,),
                   
                      SizedBox(
                        height: 20.h,
                      ),
                           FormFieldInput(controller: _password,authField: AuthFields.password,),
                  
                      SizedBox(
                        height: 20.h,
                      ),
                      SignButton(
                          callBack: () {
                            context.read<AuthenticationCubit>().signUp(
                                AuthModel(
                                    username: _email.text,
                                    password: _password.text));
                          },
                          authType: AuthType.signup,
                          authModel: AuthModel(
                            username: _email.text,
                            password: _password.text,
                          ),
                          formKey: _formKey),
                      SizedBox(
                        height: 20.h,
                      ),
                      AlreadyRegistered(),
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
