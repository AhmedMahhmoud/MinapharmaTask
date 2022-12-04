import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmatask/Core/Extenstions/auth_extentions.dart';
import 'package:pharmatask/Core/enums/auth_enum.dart';
import '../../../../Core/Shared/Methods/shared_methods.dart';
import 'package:synchronized/extension.dart';
import 'package:synchronized/extension.dart';

class FormFieldInput extends StatelessWidget {
  const FormFieldInput(
      {super.key, required this.controller, required this.authField});

  final AuthFields authField;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        return SharedMethods.validate(value!,authField.parseFields(authField));
      },
      decoration: InputDecoration(
        hintText: ' Enter your ${authField.parseFields(authField)}',
        prefixIcon:  Icon(authField==AuthFields.username? Icons.person:Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.w),
        ),
      ),
    );
  }
}
