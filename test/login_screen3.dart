import 'package:flutter/material.dart'; // 导入flutter库
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // 登录页面
  @override // 定义状态类
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState(); // 创建状态类
}

class _LoginPageState extends State<LoginPage> // 登录页面状态类
    with
        SingleTickerProviderStateMixin {
  // 定义状态类
  late TabController _tabController; // 定义TabController
  String phoneNumber = ''; // 用于存储手机号
  // ignore: prefer_final_fields
  TextEditingController _phoneNumberControllerTab1 = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _phoneNumberControllerTab2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _phoneNumberControllerTab1.addListener(() => _syncTextControllers());
    _phoneNumberControllerTab2.addListener(() => _syncTextControllers());
  }

  void _syncTextControllers() {
    // 同步控制器的文本，无论当前是哪个tab
    if (_phoneNumberControllerTab1.text != _phoneNumberControllerTab2.text) {
      String currentText = _tabController.index == 0
          ? _phoneNumberControllerTab1.text
          : _phoneNumberControllerTab2.text;
      _phoneNumberControllerTab1.text = currentText;
      _phoneNumberControllerTab2.text = currentText;
    }
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      FocusScope.of(context).requestFocus(FocusNode());
      if (FocusScope.of(context).hasFocus) {
        FocusScope.of(context).unfocus();
      }
      _syncTextControllers(); // 同步控制器的文本
    }
  }

  @override
  void dispose() {
    _phoneNumberControllerTab1.dispose();
    _phoneNumberControllerTab2.dispose();
    super.dispose();
  }

  @override // 登录页面
  Widget build(BuildContext context) {
    // 登录页面
    Color cardcolor = Theme.of(context).colorScheme.background; // 卡片背景色
    final screenWidth = MediaQuery.of(context).size.width;
    Widget _buildContent() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(text: '密码登录'),
                Tab(text: '验证码登录'),
              ],
            ),
            SizedBox(
              height: 380,
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  LoginForm(phoneNumberController: _phoneNumberControllerTab1),
                  PhoneLoginForm(
                      phoneNumberController: _phoneNumberControllerTab2),
                ],
              ),
            ),
          ],
        ),
      );
    } // 获取屏幕宽度

    return Scaffold(
      // 登录页面
      appBar: AppBar(
        // 导航栏
        title: const Text('登录'), // 标题
        leading: IconButton(
          // 返回按钮
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0), // 左右边距
              // 居中显示
              child: ConstrainedBox(
                // 限制最大宽度
                constraints: const BoxConstraints(maxWidth: 360), // 最大宽度
                child: screenWidth < 600
                    ? _buildContent() // 如果屏幕宽度小于600，直接显示内容
                    : Card(
                        color: cardcolor,
                        child: _buildContent(), // 否则将内容包装在Card中
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final TextEditingController phoneNumberController;

  const LoginForm({
    super.key,
    required this.phoneNumberController,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _passwordController;
  bool _isObscure = true;
  bool _isFormValid = false;
  bool _isAgreed = false; // 追踪复选框的状态
  void _toggleCheckbox(bool? newValue) {
    setState(() {
      _isAgreed = newValue ?? false;
      _validateForm(); // 也可以根据需要更新表单验证状态
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    widget.phoneNumberController.addListener(() {
      // 使用 widget.phoneNumberController
      _validateForm();
    });
    _passwordController.addListener(() {
      _validateForm();
    });
  }

  void _validateForm() {
    if (!mounted) return; // 在调用setState之前检查mounted
    setState(() {
      _isFormValid = widget.phoneNumberController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _isAgreed;
    });
  }

  void _submitForm() {
    if (_isFormValid) {
      // 提交表单逻辑
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 32.0),
          TextField(
            controller: widget.phoneNumberController,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '账号/手机号',
              counterText: '',
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            maxLength: 16,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: '密码',
              counterText: '',
              suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
            obscureText: _isObscure,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _isFormValid ? _submitForm : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56.0),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: const Text('登录'),
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              Checkbox(
                value: _isAgreed, // 使用_isAgreed作为当前状态
                onChanged: _toggleCheckbox,
              ), // 点击时调用_toggleCheckbox方法),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    const TextSpan(
                      style: TextStyle(fontSize: 12),
                      text: '我已阅读并同意',
                    ),
                    TextSpan(
                      text: '《用户协议》',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: 在这里添加点击《用户协议》时的逻辑
                        },
                    ),
                    const TextSpan(
                      text: ' 和 ',
                      style: TextStyle(fontSize: 12), // 普通文本样式
                    ),
                    TextSpan(
                      text: '《隐私政策》',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: 在这里添加点击《隐私政策》时的逻辑
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 68),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  // TODO: 实现忘记密码的逻辑
                },
                child: const Text('忘记密码'),
              ),
              const SizedBox(width: 16.0),
              TextButton(
                onPressed: () {
                  // TODO: 实现忘记密码的逻辑
                },
                child: const Text('现在注册'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.phoneNumberController.removeListener(_validateForm);
    _passwordController.dispose();
    super.dispose();
  }
}

class PhoneLoginForm extends StatefulWidget {
  final TextEditingController phoneNumberController;

  const PhoneLoginForm({
    super.key,
    required this.phoneNumberController,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PhoneLoginFormState createState() => _PhoneLoginFormState();
}

class _PhoneLoginFormState extends State<PhoneLoginForm> {
  late TextEditingController _codeController;
  bool _isFormValid = false;
  bool _isAgreed = false; // 追踪复选框的状态

  void _toggleCheckbox(bool? newValue) {
    setState(() {
      _isAgreed = newValue ?? false;
      _validateForm(); // 也可以根据需要更新表单验证状态
    });
  }

  @override
  void initState() {
    super.initState();

    _codeController = TextEditingController();
    widget.phoneNumberController.addListener(() {
      _validateForm();
    });
    _codeController.addListener(() {
      _validateForm();
    });
  }

  void _validateForm() {
    if (!mounted) return; // 在调用setState之前检查mounted
    setState(() {
      _isFormValid = widget.phoneNumberController.text.isNotEmpty &&
          _codeController.text.isNotEmpty &&
          _isAgreed;
    });
  }

  void _submitForm() {
    if (_isFormValid) {
      // 提交表单逻辑
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 32.0),
          TextField(
            controller: widget.phoneNumberController,
            maxLength: 11,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '账号/手机号',
              counterText: '',
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _codeController,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '验证码',
                    counterText: '',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16.0),
              TextButton(
                onPressed: () {
                  // 获取验证码逻辑
                  // ...
                },
                child: const Text('获取验证码'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _isFormValid ? _submitForm : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56.0),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: const Text('注册或登录'),
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              Checkbox(
                value: _isAgreed, // 使用_isAgreed作为当前状态
                onChanged: _toggleCheckbox,
              ), // 点击时调用_toggleCheckbox方法),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    const TextSpan(
                      style: TextStyle(fontSize: 12),
                      text: '我已阅读并同意',
                    ),
                    TextSpan(
                      text: '《用户协议》',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: 在这里添加点击《用户协议》时的逻辑
                        },
                    ),
                    const TextSpan(
                      text: ' 和 ',
                      style: TextStyle(fontSize: 12), // 普通文本样式
                    ),
                    TextSpan(
                      text: '《隐私政策》',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: 在这里添加点击《隐私政策》时的逻辑
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 68),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  // TODO: 实现忘记密码的逻辑
                },
                child: const Text('遇到问题？'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.phoneNumberController.removeListener(_validateForm);
    _codeController.dispose();
    super.dispose();
  }
}
