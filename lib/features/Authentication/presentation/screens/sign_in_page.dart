import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:pharmatask/Core/enums/auth_enum.dart';
import 'package:pharmatask/features/Authentication/data/model/auth_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmatask/features/Authentication/presentation/widgets/sign_snackbar.dart';
import '../../../../Core/Shared/Methods/shared_methods.dart';
import '../cubit/authentication_cubit.dart';
import '../widgets/sign_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocListener<AuthenticationCubit, AuthenticationState>(
          listenWhen: (previous, current) => previous is AuthLoadingSignInState,
          listener: (context, state) {
            if (state is ErrorAuthState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: SignSnackbar(
                message: state.message,
                success: false,
              )));
            } else if (state is LoadedAuthState) {
              Navigator.pushNamed(context, "dashboard", arguments: _email.text);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  'Sign in',
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
                        authModel: AuthModel(
                            password: _password.text, username: _email.text),
                        authType: AuthType.login,
                        formKey: _formKey,
                        callBack: () {
                          context.read<AuthenticationCubit>().login(AuthModel(
                              username: _email.text, password: _password.text));
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AutoSizeText('Dont have an account yet?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, "sign_up");
                            },
                            child: const AutoSizeText(
                              'Sign Up',
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
