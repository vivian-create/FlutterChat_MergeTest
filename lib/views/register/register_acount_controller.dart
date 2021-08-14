import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/views/chatrooms.dart';

class RegisterAccountController extends GetxController {
  bool isLoading = false;

  /// 加入輸入檢查，用 Form 這個 Widget 搭配 GlobalKey<FormState> formKey
  final Function toggleView = Get.find();
  final formKey = Get.find().GlobalKey<FormState>();

  /// 宣告三個 TextEditingController : email、password、username
  /// 來監聽文字輸入框內容，當按鈕按下印出輸入文字框文字內容
  final TextEditingController emailEditingController = Get.find();
  final TextEditingController passwordEditingController = Get.find();
  final TextEditingController usernameEditingController = Get.find();

  /// 取得註冊Email、Password到firebase的授權服務
  final AuthService authService = Get.find();

  /// 取得Method能夠給其他Function調用Firebase所儲存的資料
  final DatabaseMethods databaseMethods = Get.find();

  /// 加入輸入檢查，用 Form 這個 Widget 搭配 GlobalKey<FormState> formKey
  Future<void> singUp() async {
    ///輸入檢查功能(formKey 以及 validate() if no error will return true)
    if (formKey.currentState.validate()) {
      isLoading = true;

      /// if no error，isLoading = true
    }

    await authService

        /// 非同步操作，等待controller監聽結果，並輸入對應的usernName和userEmail。
        .signUpWithEmailAndPassword(
            emailEditingController.text, passwordEditingController.text)
        .then((result) {
      if (result != null) {
        Map<String, String> userDataMap = {
          "userName": usernameEditingController.text,
          "userEmail": emailEditingController.text
        };

        databaseMethods.addUserInfo(userDataMap);

        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserNameSharedPreference(
            usernameEditingController.text);
        HelperFunctions.saveUserEmailSharedPreference(
            emailEditingController.text);

        /// 成功輸入 -> 成功登入，跳轉到ChatRoom頁面。
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      }
    });
  }
}
