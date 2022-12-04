import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class AlreadyRegistered extends StatelessWidget {
  const AlreadyRegistered({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
