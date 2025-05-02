import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../core/app_colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Error state variables
  String? _usernameError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Navy Section with Logo (reduced height)
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            color: AppColors.primary,
            child: Stack(
              children: [
                // Arrow icon at top right
                Positioned(
                  top: 40,
                  right: 20,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                // Logo and welcome text centered
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      // Logo image
                      Image.asset(
                        'assets/logo_light.png', // Make sure this path exists
                        width: 100,
                        height: 80,
                      ),
                      SizedBox(height: 10),
                      // Welcome text
                      Text(
                        'اهلاً بكم في دليل',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Light gray background for the rest of the screen
          Expanded(
            child: Container(
              color: Color(0xFFEEEEEE),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      
                      // White login card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Login title
                            Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5),
                            
                            // Subtitle
                            Text(
                              'أدخل اسم المستخدم أو البريد الإلكتروني وكلمة السر',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 25),
                            
                            // Username TextField
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(8),
                                border: _usernameError != null 
                                    ? Border.all(color: Colors.red, width: 1.0)
                                    : null,
                              ),
                              child: TextField(
                                controller: _usernameController,
                                textAlign: TextAlign.right,
                                onChanged: (value) {
                                  // Clear error when user types
                                  if (_usernameError != null) {
                                    setState(() {
                                      _usernameError = null;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'اسم المستخدم',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                              ),
                            ),
                            
                            // Username error message
                            if (_usernameError != null)
                              Container(
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 8, top: 4),
                                child: Text(
                                  _usernameError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            
                            SizedBox(height: 15),
                            
                            // Password TextField
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
                                onChanged: (value) {
                                  // Clear error when user types
                                  if (_passwordError != null) {
                                    setState(() {
                                      _passwordError = null;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'كلمة المرور',
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
                              ),
                            ),
                            
                            // Password error message
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
                              
                            SizedBox(height: 25),
                            
                            // Login Button
                            Container(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _performLogin,
                                child: Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            
                            // Forgot Password Text
                            TextButton(
                              onPressed: () {
                                // Handle forgot password
                              },
                              child: Text(
                                'هل نسيت كلمة المرور ؟',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            
                            // Register New Account Text
                            TextButton(
                              onPressed: () {
                                // Handle registration
                              },
                              child: Text(
                                'تسجيل حساب جديد',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 14,
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
        ],
      ),
      // Using your custom bottom navigation bar
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  void _performLogin() {
    // Reset previous errors
    setState(() {
      _usernameError = null;
      _passwordError = null;
    });
    
    // Validate fields
    bool hasError = false;
    
    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameError = 'يرجى إدخال اسم المستخدم';
      });
      hasError = true;
    }
    
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'يرجى إدخال كلمة المرور';
      });
      hasError = true;
    }
    
    if (hasError) {
      return;
    }
    
    // Proceed with login
    print('Logging in with:');
    print('Username: ${_usernameController.text}');
    print('Password: ${_passwordController.text}');
    
    // Here you would implement actual authentication logic
    // For example:
    // authService.login(_usernameController.text, _passwordController.text)
    //   .then((success) {
    //     if (success) {
    //       // Navigate to home
    //     } else {
    //       setState(() {
    //         _passwordError = 'اسم المستخدم أو كلمة المرور غير صحيحة';
    //       });
    //     }
    //   });
  }
}