import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/custom_bottom_nav_bar.dart';
import '../core/app_colors.dart';
import 'forgot_password_screen.dart';  // Import the separate reset password screen

class VerificationCodeScreen extends StatefulWidget {
  final String email;

  const VerificationCodeScreen({Key? key, required this.email}) : super(key: key);

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? _codeError;
  bool _isResendingCode = false;
  int _resendCountdown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initially set the countdown to 0 (code can be resent)
    _resendCountdown = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startResendCountdown() {
    setState(() {
      _isResendingCode = true;
      _resendCountdown = 60; // 60 seconds countdown
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _isResendingCode = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFEEEEEE), // Light gray background
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // White Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    // Logo
                    Image.asset(
                      'assets/logo.png',
                      height: 80,
                      width: 80,
                    ),
                    SizedBox(height: 16),
                    
                    // Title - Account Recovery
                    Text(
                      'استرجاع الحساب',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    
                    // Verification Code Input
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(8),
                        border: _codeError != null 
                            ? Border.all(color: Colors.red, width: 1.0)
                            : null,
                      ),
                      child: TextField(
                        controller: _codeController,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'ادخل الكود المرسل',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                        onChanged: (value) {
                          if (_codeError != null) {
                            setState(() {
                              _codeError = null;
                            });
                          }
                        },
                      ),
                    ),
                    
                    // Verification code error message
                    if (_codeError != null)
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          _codeError!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      
                    SizedBox(height: 16),
                    
                    // Resend Code Button
                    TextButton.icon(
                      onPressed: _isResendingCode ? null : _resendCode,
                      icon: Icon(
                        Icons.refresh, 
                        color: _isResendingCode ? Colors.grey : Colors.red,
                        size: 20,
                      ),
                      label: Text(
                        _isResendingCode 
                          ? 'إعادة الإرسال بعد $_resendCountdown ثانية' 
                          : 'إعادة إرسال الكود',
                        style: TextStyle(
                          color: _isResendingCode ? Colors.grey : Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Confirm Button
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _verifyCode,
                        child: Text(
                          'تـأكـيـد',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation bar
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  void _resendCode() {
    print('Resending verification code to: ${widget.email}');
    
    // Here you would implement your actual code resend logic
    // For example:
    // authService.resendVerificationCode(widget.email)
    //   .then((success) {
    //     if (success) {
    //       _startResendCountdown();
    //     } else {
    //       // Handle error
    //     }
    //   });
    
    // For demo, just start the countdown
    _startResendCountdown();
    
    // Show a snackbar to inform the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم إعادة إرسال الكود إلى البريد الإلكتروني'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _verifyCode() {
    setState(() {
      _codeError = null;
    });
    
    // Validate code
    if (_codeController.text.isEmpty) {
      setState(() {
        _codeError = 'يرجى إدخال الكود المرسل';
      });
      return;
    }
    
    // Check if the code is 6 digits
    if (_codeController.text.length != 6) {
      setState(() {
        _codeError = 'الكود يجب أن يتكون من 6 أرقام';
      });
      return;
    }
    
    // Here you would implement your actual code verification logic
    // For example:
    // authService.verifyCode(widget.email, _codeController.text)
    //   .then((success) {
    //     if (success) {
    //       Navigator.pushReplacement(
    //         context, 
    //         MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: widget.email)),
    //       );
    //     } else {
    //       setState(() {
    //         _codeError = 'الكود غير صحيح. يرجى المحاولة مرة أخرى';
    //       });
    //     }
    //   });
    
    // For demo, navigate to reset password screen
    print('Verifying code: ${_codeController.text}');
    
    // Navigate to the next screen (Reset Password)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPasswordScreen(),
      ),
    );
  }
}