import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../core/app_colors.dart';
import 'login_screen.dart';  // Import your login screen

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFEEEEEE),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    Image.asset(
                      'assets/logo.png',
                      height: 80,
                      width: 80,
                    ),
                    SizedBox(height: 16),
                    
                    Text(
                      'إعادة تعيين كلمة المرور',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    
                    // New Password Field
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(8),
                        border: _passwordError != null 
                            ? Border.all(color: Colors.red, width: 1.0)
                            : null,
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'كلمة المرور الجديدة',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          prefixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          if (_passwordError != null) {
                            setState(() {
                              _passwordError = null;
                            });
                          }
                        },
                      ),
                    ),
                    
                    if (_passwordError != null)
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          _passwordError!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    
                    SizedBox(height: 16),
                    
                    // Confirm Password Field
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(8),
                        border: _confirmPasswordError != null 
                            ? Border.all(color: Colors.red, width: 1.0)
                            : null,
                      ),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'تأكيد كلمة المرور',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          prefixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          if (_confirmPasswordError != null) {
                            setState(() {
                              _confirmPasswordError = null;
                            });
                          }
                        },
                      ),
                    ),
                    
                    if (_confirmPasswordError != null)
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          _confirmPasswordError!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    
                    SizedBox(height: 30),
                    
                    // Reset Password Button
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _resetPassword,
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
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  void _resetPassword() {
    setState(() {
      _passwordError = null;
      _confirmPasswordError = null;
    });
    
    // Validate password
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'يرجى إدخال كلمة المرور الجديدة';
      });
      return;
    }
    
    // Check password strength (example: at least 8 characters)
    if (_passwordController.text.length < 8) {
      setState(() {
        _passwordError = 'كلمة المرور يجب أن تتكون من 8 أحرف على الأقل';
      });
      return;
    }
    
    // Validate confirm password
    if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        _confirmPasswordError = 'يرجى تأكيد كلمة المرور';
      });
      return;
    }
    
    // Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _confirmPasswordError = 'كلمات المرور غير متطابقة';
      });
      return;
    }
    
    // Here you would implement your actual password reset logic
    // For example:
    // authService.resetPassword(widget.email, _passwordController.text)
    //   .then((success) {
    //     if (success) {
    //       // Show success message and navigate back to login
    //       showSuccessDialog();
    //     } else {
    //       // Handle error
    //     }
    //   });
    
    // For demo, show success dialog
    print('Resetting password for: ${widget.email}');
    print('New password: ${_passwordController.text}');
    
    showSuccessDialog();
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تم تغيير كلمة المرور بنجاح'),
        content: Text('يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              
              // Navigate back to login screen
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false, // Remove all previous routes
              );
            },
            child: Text('تسجيل الدخول'),
          ),
        ],
      ),
    );
  }
}