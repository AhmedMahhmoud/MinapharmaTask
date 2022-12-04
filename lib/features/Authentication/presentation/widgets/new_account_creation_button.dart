
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';


class NewAccountCreationButton extends StatelessWidget {
  const NewAccountCreationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}


