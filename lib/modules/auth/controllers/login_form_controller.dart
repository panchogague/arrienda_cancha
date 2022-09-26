import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
