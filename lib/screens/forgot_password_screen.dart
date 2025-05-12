import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../core/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _emailError;
  bool _isLoading = false;

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
                                  onPressed: _isLoading ? null : _sendResetLink,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          'تـأكـيـد',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                                ) ,
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

 
Future<void> _sendResetLink() async {
  final email = _emailController.text.trim();
  

  setState(() {
    _emailError = null;
  });

  // Validate input
  if (email.isEmpty) {
    setState(() {
      _emailError = 'يرجى إدخال البريد الإلكتروني';
    });
    return;
  }

  final emailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  if (!emailValid) {
    setState(() {
      _emailError = 'يرجى إدخال بريد إلكتروني صحيح';
    });
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال رابط إعادة تعيين كلمة المرور إذا كان البريد الإلكتروني مسجلاً.'),
        ),
      );
      Navigator.pop(context); // Return to previous screen (e.g., login)
    }
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    switch (e.code) {
      case 'invalid-email':
        errorMessage = 'البريد الإلكتروني غير صالح.';
        break;
      default:
        errorMessage = 'حدث خطأ أثناء الإرسال. حاول مرة أخرى.';
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ غير متوقع. حاول مرة أخرى.')),
      );
    }
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}
@override
void dispose() {
  _emailController.dispose();
  super.dispose();
}



}