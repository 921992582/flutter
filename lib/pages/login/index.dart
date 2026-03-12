import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/api/user.dart';
import 'package:flutter_test_project/stores/TokenManager.dart';
import 'package:flutter_test_project/stores/UserController.dart';
import 'package:flutter_test_project/utils/loadingDialog.dart';
import 'package:flutter_test_project/utils/toastUtils.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController(); // 账号控制器
  TextEditingController _codeController = TextEditingController(); // 密码控制器

  final UserController _userController = Get.find();
  // 用户账号Widget
  Widget _buildPhoneTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "手机号不能为空";
        }
        // 校验手机号格式
        RegExp phoneRegExp = RegExp(r'^1[3-9]\d{9}$');
        if (!phoneRegExp.hasMatch(value)) {
          return "请输入正确的手机号";
        }

        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入账号",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 用户密码Widget
  Widget _buildCodeTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "密码不能为空";
        }

        // 校验密码格式
        RegExp codeRegExp = RegExp(r'^[0-9a-zA-Z]{6,16}$');
        if (!codeRegExp.hasMatch(value)) {
          return "请输入6-12位数字或字母密码";
        }
        return null;
      },
      controller: _codeController,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入密码",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  void _login() async {
    // 调用登录接口
    Loadingdialog.show(context, message: "努力登录中");
    try {
      final res = await loginApi({
        "account": _phoneController.text,
        "password": _codeController.text,
      });

      _userController.updateUserInfo(res);
      tokenManager.setToken(res.token); // 写入持久化
      ToastUtils.showToast(context, "登录成功");
      Navigator.pop(context);
    } catch (e) {
      // 登录失败，提示用户
      ToastUtils.showToast(context, (e as DioException).message);
    } finally {
      Loadingdialog.hide(context);
    }
  }

  // 登录按钮Widget
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 登录逻辑
          if (_formKey.currentState!.validate()) {
            // 校验通过，执行登录逻辑
            if (_isChecked) {
              // 勾选了隐私条款和用户协议
              // 执行登录逻辑
              _login();
            } else {
              // 未勾选隐私条款和用户协议
              // 提示用户勾选
              ToastUtils.showToast(context, "请勾选隐私条款和用户协议");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  bool _isChecked = false;
  // 勾选Widget
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ),
          // 可选：设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 头部Widget
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("惠多美登录", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildCodeTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
