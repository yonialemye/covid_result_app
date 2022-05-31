import 'package:covid_result_app/utils/colors.dart';
import 'package:covid_result_app/views/login_view.dart';
import 'package:covid_result_app/widgets/auth_views_widgets/auth_text_field.dart';
import 'package:covid_result_app/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';

import '../services/auth_services/auth_exceptions.dart';
import '../services/auth_services/auth_services.dart';
import '../widgets/animated_text_widget.dart';
import '../widgets/auth_views_widgets/logo_and_title.dart';
import '../widgets/submit_button_big.dart';
import '../widgets/submit_button_small.dart';
import '../widgets/text_widget_small.dart';
import 'verify_view.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = '/registerview/';

  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  String? emailError;
  String? passwordError;

  @override
  void initState() {
    _password.addListener(() => setState(() {}));
    _confirmPassword.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackground(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const LogoAndTitle(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.95),
                  // big container shadow
                  boxShadow: const [boxShadow1],
                ),
                child: _formField(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _formField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const AnimatedTextWidget(
          title1: 'Create new account',
          title2: 'Keep your distance!',
        ),
        const SizedBox(height: 5),
        const Divider(
          indent: 2,
          endIndent: 260,
          thickness: 3,
          color: secondaryColor,
        ),
        const TextWidgetSmall(text: 'Email address'),
        AuthTextField(
          controller: _email,
          hintText: 'name@organization.domain',
          error: emailError,
        ),
        const TextWidgetSmall(text: 'New password'),
        AuthTextField(
          controller: _password,
          isPassword: _password.text.isEmpty ? false : true,
          hintText: 'enter your password',
          borderColor: passwordError != null ? Colors.red.withOpacity(0.5) : null,
        ),
        const TextWidgetSmall(text: 'Confirm password'),
        Hero(
          tag: 'passTag',
          child: Material(
            color: Colors.transparent,
            child: AuthTextField(
              controller: _confirmPassword,
              isPassword: _confirmPassword.text.isEmpty ? false : true,
              hintText: 'repeat your password',
              error: passwordError,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Hero(
          tag: 'SubmitButtonBig',
          child: SubmitButtonBig(
            onTap: _registerCompany,
            text: 'Register',
            gradient: gradient1,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidgetSmall(
              text: 'Already have an account? ',
              havePadding: false,
            ),
            SubmitButtonSmall(
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                LoginView.routeName,
                (route) => false,
              ),
              text: 'Login.',
              context: context,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _registerCompany() async {
    // hide keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    passwordError = null;
    emailError = null;

    final String email = _email.text.trim().toLowerCase();
    final String password = _password.text.trim().toLowerCase();
    final String confirm = _confirmPassword.text.trim().toLowerCase();

    if (email.isEmpty || confirm.isEmpty || password.length != confirm.length) {
      if (email.isEmpty) {
        setEmailErrorMessage('Email can not be empty.');
      }
      if (confirm.isEmpty || password.isEmpty) {
        setPasswordErrorMessage('Password can not be empty.');
      } else if (password.length != confirm.length) {
        setPasswordErrorMessage("Those password didn't match. Try again.");
      }
    } else {
      try {
        // register new user
        await AuthServices.firebase().register(email: email, password: password);
        // send email verification to the user
        await AuthServices.firebase().sendEmailVerification();
        // goto the verification waiting screen
        if (mounted) Navigator.of(context).pushNamed(VerifyView.routeName);
      } on EmailAlreadyInUseAuthException {
        setEmailErrorMessage('The email is taken. Try another.');
      } on WeakPasswordAuthException {
        setPasswordErrorMessage('Use 6 characters or more for your password.');
      } on InvalidEmailAuthException {
        setEmailErrorMessage('The email is invalid. Try another');
      } on GenericAuthException {
        setPasswordErrorMessage('Something happend, Please try again!');
      }
    }
  }

  void setPasswordErrorMessage(String message) => setState(() => passwordError = message);

  void setEmailErrorMessage(String message) => setState(() => emailError = message);
}
