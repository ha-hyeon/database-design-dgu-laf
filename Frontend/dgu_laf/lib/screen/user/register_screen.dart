import 'package:dgu_laf/service/user_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  void _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await UserService.register(
        _usernameController.text,
        _passwordController.text,
        _phoneController.text,
      );

      if (response['status'] == 'success') {
        Navigator.pop(context); // 회원가입 후 이전 화면으로 돌아가기
      } else {
        setState(() {
          _errorMessage = '회원가입 실패. 다시 시도해주세요.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '서버와 연결할 수 없습니다. 나중에 다시 시도해주세요.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('아이디', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: 8),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: '아이디를 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('비밀번호', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호를 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('휴대폰 번호', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '휴대폰 번호를 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('회원가입'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
