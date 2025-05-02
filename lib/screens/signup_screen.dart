import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  // Error messages
  String? _firstNameError;
  String? _lastNameError;
  String? _phoneError;
  String? _usernameError;
  String? _passwordError;
  String? _emailError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/logo.png',
                    width: 120,
                    height: 60,
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Signup Card
                  Container(
                    width: 373,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'انشاء حساب جديد',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        
                        SizedBox(height: 20),
                        
                        // Name Row
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _lastNameController,
                                hint: 'اسم العائلة *',
                                errorText: _lastNameError,
                                onChanged: (value) {
                                  setState(() {
                                    _lastNameError = value.isEmpty 
                                      ? 'برجاء إدخال اسم العائلة' 
                                      : null;
                                  });
                                }
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _buildTextField(
                                controller: _firstNameController,
                                hint: 'الاسم الأول *',
                                errorText: _firstNameError,
                                onChanged: (value) {
                                  setState(() {
                                    _firstNameError = value.isEmpty 
                                      ? 'برجاء إدخال الاسم الأول' 
                                      : null;
                                  });
                                }
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 15),
                        
                        // Phone Number
                        _buildTextField(
                          controller: _phoneController,
                          hint: 'رقم الهاتف الحمول *',
                          prefixText: '+20',
                          errorText: _phoneError,
                          onChanged: (value) {
                            setState(() {
                              _phoneError = value.isEmpty 
                                ? 'برجاء إدخال رقم الهاتف' 
                                : null;
                            });
                          }
                        ),
                        
                        SizedBox(height: 15),
                        
                        // Username
                        _buildTextField(
                          controller: _usernameController,
                          hint: 'اسم المستخدم *',
                          errorText: _usernameError,
                          onChanged: (value) {
                            setState(() {
                              _usernameError = value.isEmpty 
                                ? 'برجاء إدخال اسم المستخدم' 
                                : null;
                            });
                          }
                        ),
                        
                        SizedBox(height: 15),
                        
                        // Password
                        _buildTextField(
                          controller: _passwordController,
                          hint: 'كلمة السر *',
                          obscureText: true,
                          errorText: _passwordError,
                          onChanged: (value) {
                            setState(() {
                              _passwordError = value.isEmpty 
                                ? 'برجاء إدخال كلمة المرور' 
                                : null;
                            });
                          }
                        ),
                        
                        SizedBox(height: 15),
                        
                        // Email
                        _buildTextField(
                          controller: _emailController,
                          hint: 'البريد الإلكتروني *',
                          errorText: _emailError,
                          onChanged: (value) {
                            setState(() {
                              _emailError = value.isEmpty 
                                ? 'برجاء إدخال البريد الإلكتروني' 
                                : null;
                            });
                          }
                        ),
                        
                        SizedBox(height: 30),
                        
                        // Create Account Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _handleSignup,
                            child: Text(
                              'انشاء حساب',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
    TextDirection _getTextDirection(String text) {
    // Check if the text contains any Arabic characters
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    
    if (text.isEmpty) {
      return TextDirection.rtl; // Default to RTL for empty input
    }
    
    // If text contains Arabic characters, use RTL
    if (arabicRegex.hasMatch(text)) {
      return TextDirection.rtl;
    }
    
    // For non-Arabic text, use LTR
    return TextDirection.ltr;
  }
  
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    String? prefixText,
    String? errorText,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      textAlign: TextAlign.right,
      textDirection: _getTextDirection(controller.text),
      onChanged: (value) {
        setState(() {
          // Update text direction dynamically
          onChanged(value);
        });
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Color(0xFF767676),
          fontSize: 13,
          textBaseline: TextBaseline.alphabetic,
        ),
        prefixText: prefixText,
        filled: true,
        fillColor: Color(0xFFE3E3E3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        errorText: errorText,
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
      ),
    );
  }
  
  void _handleSignup() {
    setState(() {
      _firstNameError = _firstNameController.text.isEmpty 
        ? 'برجاء إدخال الاسم الأول' 
        : null;
      _lastNameError = _lastNameController.text.isEmpty 
        ? 'برجاء إدخال اسم العائلة' 
        : null;
      _phoneError = _phoneController.text.isEmpty 
        ? 'برجاء إدخال رقم الهاتف' 
        : null;
      _usernameError = _usernameController.text.isEmpty 
        ? 'برجاء إدخال اسم المستخدم' 
        : null;
      _passwordError = _passwordController.text.isEmpty 
        ? 'برجاء إدخال كلمة المرور' 
        : null;
      _emailError = _emailController.text.isEmpty 
        ? 'برجاء إدخال البريد الإلكتروني' 
        : null;
    });

    if (_firstNameError == null && 
        _lastNameError == null && 
        _phoneError == null && 
        _usernameError == null && 
        _passwordError == null && 
        _emailError == null) {
      // Proceed with signup
      print('All fields are valid');
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}