import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmatask/services/sembast_database/Auth/authentication_db.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120.w,
        child: ElevatedButton(
            onPressed: () {
              AuthDao authDao = AuthDao();
              authDao.logout();
              Navigator.pushReplacementNamed(context, 'sign_up');
            },
            child: const Text("Sign out")));
  }
}
