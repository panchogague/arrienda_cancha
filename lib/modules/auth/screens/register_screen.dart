import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:court_finder/modules/auth/controllers/controllers.dart';
import 'package:court_finder/modules/auth/providers/login_form_provider.dart';
import 'package:court_finder/modules/auth/ui/input_decorations.dart';
import 'package:court_finder/modules/auth/widgets/widgets.dart';

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
                const _LoginForm()
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
    final loginFormCtrl = Get.find<LoginFormController>();
    loginFormCtrl.formKey = GlobalKey<FormState>();
    return Obx(() => Form(
        key: loginFormCtrl.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => loginFormCtrl.email.value = value,
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
              onChanged: (value) => loginFormCtrl.password.value = value,
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
              onPressed: loginFormCtrl.isLoading.value
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authCtrl = Get.find<AuthController>();

                      if (!loginFormCtrl.isValidForm()) return;

                      loginFormCtrl.isLoading.value = true;

                      final String? errorMessage = await authCtrl.createUser(
                          loginFormCtrl.email.value,
                          loginFormCtrl.password.value);

                      loginFormCtrl.isLoading.value = false;
                      if (errorMessage == null) {
                        Get.offAllNamed('/home');
                      } else {
                        Get.snackbar('Error', errorMessage);
                      }
                    },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginFormCtrl.isLoading.value ? 'Wait ...' : 'Enter',
                    style: const TextStyle(color: Colors.white),
                  )),
            )
          ],
        )));
  }
}
