import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:freeforweebs/screens/auth_screen/auth_screen_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  AuthScreenBloc authScreenBloc = AuthScreenBloc();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: ThemeTool(context).isDark
                    ? AppTheme.dark().data.scaffoldBackgroundColor
                    : AppTheme.purple().data.scaffoldBackgroundColor,
                foregroundColor: ThemeTool(context).appBarForegroundColor,
                pinned: true,
                title: Text(
                  "Forget Password",
                  style: GoogleFonts.lato(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: ThemeTool(context).isDark
                                ? const Color(0xFF242424)
                                : const Color(0XFFE8EAED),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              border: InputBorder.none,
                              hintText: "Eg. abcd@test.com",
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              bool isValidEmail = EmailValidator.validate(val!);
                              if (isValidEmail) {
                                return null;
                              } else {
                                return "Please enter valid email address";
                              }
                            },
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            authScreenBloc.onForgetPassword(
                              email: emailController.text.trim().toLowerCase(),
                              context: context,
                              formKey: formKey,
                            );
                          },
                          child: Text(
                            "Reset Password",
                            style: GoogleFonts.lato(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
