import 'package:flutter/material.dart';
import 'package:chatapp/utils/logger.dart';
import 'package:chatapp/views/register/register_account_controller.dart';
import 'package:chatapp/views/register/register_account_body.dart';
import 'package:get/get.dart';

class RegisterAccountPage extends GetView<RegisterAccountController> {
  @override
  Widget build(BuildContext context) {
    logger.i('渲染 —— RegisterPage');
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 40,
        ),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: RegisterAccountBody(),
    );
  }
}
