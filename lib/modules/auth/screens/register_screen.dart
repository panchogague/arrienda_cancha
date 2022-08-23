import 'package:court_finder/modules/auth/providers/login_form_provider.dart';
import 'package:court_finder/modules/auth/services/services.dart';
import 'package:court_finder/modules/auth/ui/input_decorations.dart';
import 'package:court_finder/modules/auth/widgets/widgets.dart';
import 'package:court_finder/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 250),
            CardContainer(
              child: Column(children: [
                const SizedBox(height: 10),
                Text('Register', style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: const _LoginForm(),
                )
              ]),
            ),
            const SizedBox(height: 50),
            TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                  overlayColor: MaterialStateProperty.all(
                      Colors.indigo.withOpacity(0.1))),
              child: const Text(
                'Do you have already an account?',
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
            ),
            const SizedBox(height: 50),
          ],
        )),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => loginForm.email = value,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'john.smith@email.com',
                  labelText: 'Email',
                  prefixIcon: Icons.alternate_email_sharp),
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Email is not valid';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              onChanged: (value) => loginForm.password = value,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '****',
                  labelText: 'Password',
                  prefixIcon: Icons.lock_outline),
              validator: (value) {
                if (value != null && value.length >= 6) return null;

                return 'Password has to be 6 or more characters';
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      final navigator = Navigator.of(context);
                      FocusScope.of(context).unfocus();

                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      final String? errorMessage = await authService.createUser(
                          loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        navigator.pushReplacementNamed('home');
                      } else {
                        NotificationService.showSnackbar(errorMessage);
                        loginForm.isLoading = false;
                      }
                    },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'Wait ...' : 'Enter',
                    style: const TextStyle(color: Colors.white),
                  )),
            )
          ],
        ));
  }
}
