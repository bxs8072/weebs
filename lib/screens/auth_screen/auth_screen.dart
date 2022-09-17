import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:freeforweebs/screens/auth_screen/auth_screen_bloc.dart';
import 'package:freeforweebs/screens/auth_screen/forget_password_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool isLoginFormType = true;

  final AuthScreenBloc authScreenBloc = AuthScreenBloc();

  toggleFormType() {
    setState(() {
      isLoginFormType = !isLoginFormType;
      formKey.currentState!.reset();
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  submit() async {
    await authScreenBloc.onSubmit(
      email: emailController.text.trim().toLowerCase(),
      password: passwordController.text.trim(),
      isLoginFormType: isLoginFormType,
      context: context,
      formKey: formKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              pinned: true,
              foregroundColor: ThemeTool(context).appBarForegroundColor,
              centerTitle: true,
              title: Text(
                "Weebs",
                style: GoogleFonts.pacifico(
                  fontSize: Go(context).size.height * 0.03,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  child: ListTile(
                    leading: const Card(
                      color: Colors.black,
                      shape: CircleBorder(),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.dark_mode,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      "Dark Mode",
                      style: GoogleFonts.lato(),
                    ),
                    subtitle: Text(
                      "Change Theme",
                      style: GoogleFonts.lato(),
                    ),
                    trailing: Switch(
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        ThemeTool(context).switchTheme;
                      },
                      value: ThemeTool(context).isDark,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          isLoginFormType ? "Login" : "Register",
                          style: GoogleFonts.lato(
                            fontSize: Go(context).size.height * 0.035,
                            letterSpacing: 1.5,
                            color: Colors.purpleAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Go(context).size.height * 0.05),
                        Container(
                          decoration: BoxDecoration(
                            color: ThemeTool(context).isDark
                                ? const Color(0xFF242424)
                                : const Color(0XFFE8EAED),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: TextFormField(
                            focusNode: emailFocusNode,
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
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            color: ThemeTool(context).isDark
                                ? const Color(0xFF242424)
                                : const Color(0XFFE8EAED),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: TextFormField(
                            focusNode: passwordFocusNode,
                            controller: passwordController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              border: InputBorder.none,
                              hintText: "********",
                              labelText: "Password",
                              prefixIcon: Icon(Icons.password),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (val) {
                              if (val!.length < 6) {
                                return "Password must be atleast 6 character length";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {});
                            },
                            onEditingComplete: submit,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Go(context)
                                .push(ForgetPasswordPage(key: widget.key));
                            formKey.currentState!.reset();
                          },
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.ubuntu(),
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.purple,
                          onPressed: submit,
                          child: Text(
                            isLoginFormType ? "Login" : "Register",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: toggleFormType,
                          child: Text(
                            isLoginFormType
                                ? "Need an account? Sign Up"
                                : "Already have an account? Sign In",
                            style: GoogleFonts.lato(
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
