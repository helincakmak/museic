import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museic/common/widgets/appbar/app_bar.dart';
import 'package:museic/common/widgets/button/basic_app_button.dart';
import 'package:museic/core/configs/assets/app_vectors.dart';
import 'package:museic/presentation/auth/pages/signup.dart';
import 'package:museic/presentation/pages/home_page.dart';
import 'package:museic/data/api_service.dart';  // Import edin

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _authService = ApiService();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _authService.login(
        _usernameController.text.trim(),  // `username` kullanın
        _passwordController.text.trim()
      );

      print('Login successful: $response');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    } catch (e) {
      print('Login failed: $e');
      setState(() {
        _errorMessage = 'Giriş başarısız: ${e.toString()}';
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
      bottomNavigationBar: _signupText(context),
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 50,
          width: 50,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 50),
            _usernameField(context),  // `email` yerine `username` alanı kullanın
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 20),
            if (_isLoading) 
              const CircularProgressIndicator(), 
            if (_errorMessage != null) 
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            BasicAppButton(
              onPressed: _isLoading ? null : _login,  
              title: 'Sign In',
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _usernameField(BuildContext context) {  // `email` alanını `username` olarak değiştirin
    return TextField(
      controller: _usernameController,
      decoration: InputDecoration(
        hintText: 'Enter Username',
        border: OutlineInputBorder(),
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
        border: OutlineInputBorder(),
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
      obscureText: true,
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member? ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SignupPage(),
                ),
              );
            },
            child: const Text('Register Now'),
          ),
        ],
      ),
    );
  }
}
