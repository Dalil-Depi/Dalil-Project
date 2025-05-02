import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../core/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _emailError;

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
                    
                    // Email Input
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(8),
                        border: _emailError != null 
                            ? Border.all(color: Colors.red, width: 1.0)
                            : null,
                      ),
                      child: TextField(
                        controller: _emailController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'البريد الإلكتروني',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                        onChanged: (value) {
                          if (_emailError != null) {
                            setState(() {
                              _emailError = null;
                            });
                          }
                        },
                      ),
                    ),
                    
                    // Email error message
                    if (_emailError != null)
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          _emailError!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      
                    SizedBox(height: 30),
                    
                    // Confirm Button
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _sendResetLink,
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

  void _sendResetLink() {
    setState(() {
      _emailError = null;
    });
    
    // Validate email
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = 'يرجى إدخال البريد الإلكتروني';
      });
      return;
    }
    
    // Basic email validation
    bool emailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text);
    if (!emailValid) {
      setState(() {
        _emailError = 'يرجى إدخال بريد إلكتروني صحيح';
      });
      return;
    }
    
    // If valid, proceed with password reset process
    print('Sending password reset email to: ${_emailController.text}');
    
    // Here you would implement your actual password reset logic
    // For example:
    // authService.sendPasswordResetEmail(_emailController.text)
    //   .then((success) {
    //     if (success) {
    //       showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: Text('تم إرسال رابط إعادة تعيين كلمة المرور'),
    //           content: Text('يرجى التحقق من بريدك الإلكتروني'),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //                 Navigator.pop(context); // Return to login screen
    //               },
    //               child: Text('حسناً'),
    //             )
    //           ],
    //         ),
    //       );
    //     } else {
    //       setState(() {
    //         _emailError = 'لم يتم العثور على حساب بهذا البريد الإلكتروني';
    //       });
    //     }
    //   });
    
    // For demo, show a success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تم إرسال رابط إعادة تعيين كلمة المرور'),
        content: Text('يرجى التحقق من بريدك الإلكتروني'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Return to login screen
            },
            child: Text('حسناً'),
          )
        ],
      ),
    );
  }
}