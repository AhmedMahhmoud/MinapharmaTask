import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmatask/features/Dashboard/Presentation/widgets/sign_out_button.dart';

class DashboardPage extends StatelessWidget {
  final String username;
  const DashboardPage({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello $username !",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 120.w,
              child: ElevatedButton(
                onPressed: () {
                 
                  Navigator.pushNamed(context, 'movies');
                },
                child: const Text("Go to movies"),
              ),
            ),
            const SignOutButton()
          ],
        ),
      ),
    );
  }
}
