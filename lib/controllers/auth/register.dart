import 'package:flutter/material.dart';
import 'package:food_order/screens/login.dart';
import 'package:food_order/screens/success.dart';
import 'package:food_order/utils/constants.dart';
import 'package:food_order/widgets/login/button.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxBool isUserInvalid = true.obs;
  RxBool isFullnameInvalid = true.obs;
  RxBool isEmailInvalid = true.obs;
  RxBool isPwdInvalid = true.obs;
  RxBool isRPwdInvalid = true.obs;
  RxBool btnEnabled = false.obs;
  RxBool isLoading = false.obs;
  RxString usernameInvalidMsg = ''.obs;
  RxString emailInvalidMsg = ''.obs;

  void onRegSuccess() {
    Get.offAll(
      () => SuccessScreen(
        title: 'Sign Up Successful 🎉',
        content:
            'Thanks for signing up. Welcome to our community. We are happy to have you on board.',
        successBtn: AuthButton(
          btnLabel: 'Back to Sign In',
          onPressed: () {
            Get.offAll(() => LoginScreen());
          },
          btnColor: secondaryBGColor,
          textColor: Colors.white,
        ),
      ),
    );
  }

  void onRegError(String msg) {
    btnDispose();
    if (msg == 'User Already Exists') {
      isUserInvalid(true);
      usernameInvalidMsg('User already exists');
    } else {
      isEmailInvalid(true);
      emailInvalidMsg('Must be an email');
    }
  }

  void checkAll() {
    !isUserInvalid.value &&
            !isFullnameInvalid.value &&
            !isEmailInvalid.value &&
            !isPwdInvalid.value &&
            !isRPwdInvalid.value
        ? btnEnabled(true)
        : btnEnabled(false);
  }

  void inputUsernameOnchanged(String text) {
    if (GetUtils.isUsername(text)) {
      isUserInvalid(false);
      checkAll();
    } else {
      usernameInvalidMsg('');
      isUserInvalid(true);
      btnEnabled(false);
    }
  }

  void inputFullnameOnchanged(String text) {
    if (text.length > 5) {
      isFullnameInvalid(false);
      checkAll();
    } else {
      isFullnameInvalid(true);
      btnEnabled(false);
    }
  }

  void inputEmailOnchanged(String text) {
    if (GetUtils.isEmail(text)) {
      isEmailInvalid(false);
      checkAll();
    } else {
      emailInvalidMsg('');
      isEmailInvalid(true);
      btnEnabled(false);
    }
  }

  void inputEmailFGOnchanged(String text) {
    if (GetUtils.isEmail(text)) {
      isEmailInvalid(false);
      btnEnabled(true);
    } else {
      emailInvalidMsg('');
      isEmailInvalid(true);
      btnEnabled(false);
    }
  }

  void inputPasswordOnchanged(String text) {
    if (GetUtils.isPassport(text)) {
      isPwdInvalid(false);
      checkAll();
    } else {
      isPwdInvalid(true);
      btnEnabled(false);
    }
  }

  void btnDispose() {
    btnEnabled(false);
    isLoading(false);
  }
}
