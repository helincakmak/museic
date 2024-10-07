import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:museic/alternative/helper/router.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  PageController _controller = PageController();
  int _currentPage = 0;
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  void _nextPage() {
    if (_currentPage < 3) {
      setState(() {
        _currentPage++;
        _controller.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFF111111),
        body: PageView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildEmailPage(),
            _buildPasswordPage(),
            _buildGenderPage(),
            _buildNamePage(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(),
            SizedBox(height: 5.h),
            Text(
              "What's your email?",
              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 2.h),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 1.h),
            Text(
              "You’ll need to confirm this email later.",
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
            SizedBox(height: 2.h),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordPage() {
    TextEditingController passwordController = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(),
            SizedBox(height: 5.h),
            Text(
              "Create a password",
              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                hintText: 'Use at least 8 characters',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
              style: TextStyle(color: Colors.white),
              obscureText: true,
            ),
            SizedBox(height: 1.h),
            Text(
              "Use at least 8 characters.",
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
            SizedBox(height: 2.h),
            _buildNextButton(onPressed: () {
              if (passwordController.text.length < 8) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Password must be at least 8 characters long."),
                  ),
                );
              } else {
                _nextPage();
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(),
            SizedBox(height: 5.h),
            Text(
              "What's your gender?",
              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 2.h),
            DropdownButtonFormField<String>(
              items: ['Male', 'Female', 'Non-binary'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {},
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                hintText: 'Select your gender',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
              dropdownColor: Colors.grey[800],
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 2.h),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildNamePage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(),
                SizedBox(height: 5.h),
                Text(
                  "What's your name?",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 2.h),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 1.h),
                Text(
                  "This appears on your Spotify profile.",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                SizedBox(height: 1.5.h),
                Divider(color: Color(0xff777777)),
                SizedBox(height: 1.5.h),
                _buildTermsAndPrivacy(),
                SizedBox(height: 1.h),
                _buildCheckboxRow(
                  label: "Please send me news and offers from Spotify.",
                  value: _isChecked1,
                  onChanged: () {
                    setState(() {
                      _isChecked1 = !_isChecked1;
                    });
                  },
                ),
                SizedBox(height: 1.h),
                _buildCheckboxRow(
                  label: "Share my registration data with Spotify’s content providers for marketing purposes.",
                  value: _isChecked2,
                  onChanged: () {
                    setState(() {
                      _isChecked2 = !_isChecked2;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 32.h,),
            _buildCreateAccountButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        if (_currentPage > 0) {
          setState(() {
            _currentPage--;
            _controller.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        } else {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget _buildNextButton({VoidCallback? onPressed}) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed ?? _nextPage,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
          backgroundColor: Colors.grey[800],
          shape: StadiumBorder(),
        ),
        child: Text(
          'Next',
          style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildCheckboxRow({required String label, required bool value, required VoidCallback onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 13.sp),
          ),
        ),
        GestureDetector(
          onTap: onChanged,
          child: Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? Colors.green : Colors.transparent,
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/vectors/unchecked.svg',
                height: 5.w,
                width: 5.w,
                color: value ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndPrivacy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "By tapping on “Create account”, you agree to the Spotify Terms of Use.",
          style: TextStyle(color: Colors.grey, fontSize: 13.sp),
        ),
        SizedBox(height: 1.5.h),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Terms of Use",
            style: TextStyle(color: Colors.green, fontSize: 13.sp, decoration: TextDecoration.underline),
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          "To learn more about how Spotify collects, uses, shares and protects your personal data, please see the Spotify Privacy Policy.",
          style: TextStyle(color: Colors.grey, fontSize: 13.sp),
        ),
        SizedBox(height: 1.5.h),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Privacy Policy",
            style: TextStyle(color: Colors.green, fontSize: 13.sp, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccountButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRouter.homePageWrapper);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
          backgroundColor: Color(0xffF5F5F5),
          shape: StadiumBorder(),
        ),
        child: Text(
          'Create an account',
          style: TextStyle(fontSize: 17.sp, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
