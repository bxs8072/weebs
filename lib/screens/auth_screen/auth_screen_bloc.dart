import 'package:flutter/material.dart';
import 'package:freeforweebs/apis/auth.dart';
import 'package:freeforweebs/resources/message_dialog.dart';
import 'package:freeforweebs/screens/auth_screen/error_dialog.dart';

class AuthScreenBloc {
  Key key = GlobalKey();
  Auth auth = Auth();

  Future<void> onSubmit({
    required String email,
    required String password,
    required bool isLoginFormType,
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    bool isValidate = formKey.currentState!.validate();
    if (isValidate) {
      if (isLoginFormType) {
        await auth.login(email, password).then((value) {}).catchError((error) {
          showDialog(
              context: context,
              builder: (ctx) {
                return ErrorDialog(message: error);
              });
        });
      } else {
        await auth
            .register(email, password)
            .then((value) {})
            .catchError((error) {
          showDialog(
              context: context,
              builder: (ctx) {
                return ErrorDialog(message: error);
              });
        });
      }
    }
  }

  Future<void> onForgetPassword({
    required String email,
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    bool isValidate = formKey.currentState!.validate();
    if (isValidate) {
      auth.forgetPassword(email).then((value) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (ctx) {
              return MessageDialog(
                message: "",
                title: "",
                key: key,
              );
            });
      }).catchError((error) {
        showDialog(
            context: context,
            builder: (ctx) {
              return ErrorDialog(key: key, message: error);
            });
      });
    }
  }
}
