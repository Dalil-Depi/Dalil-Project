import 'package:dalil/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../core/app_colors.dart';
import '../screens/forgot_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                        'assets/logo_light.png', 
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
                              'ادخل البريد الإلكتروني وكلمة السر',
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
                                border:
                                    _usernameError != null
                                        ? Border.all(
                                          color: Colors.red,
                                          width: 1.0,
                                        )
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
                                  hintText: 'البريد الإلكتروني',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
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
                                border:
                                    _passwordError != null
                                        ? Border.all(
                                          color: Colors.red,
                                          width: 1.0,
                                        )
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
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  prefixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
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
                                            onPressed: _isLoading ? null : _performLogin,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: _isLoading
                                                ? const SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                    ),
                                                  )
                                                : const Text(
                                                    'تسجيل الدخول',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                          ),
                                      ),
                            SizedBox(height: 15),

                            // Forgot Password Text
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ForgotPasswordScreen(),
                                  ),
                                );
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => SignupScreen(),
                                  ),
                                );
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
      // Using custom bottom navigation bar
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

bool _isLoading = false;

Future<void> _performLogin() async {
  final email = _usernameController.text.trim();
  final password = _passwordController.text;

  setState(() {
    _usernameError = null;
    _passwordError = null;
    _isLoading = true;
  });

  bool hasError = false;

  if (email.isEmpty) {
    setState(() {
      _usernameError = 'يرجى إدخال البريد الإلكتروني';
    });
    hasError = true;
  }

  if (password.isEmpty) {
    setState(() {
      _passwordError = 'يرجى إدخال كلمة المرور';
    });
    hasError = true;
  }

  if (hasError) {
    setState(() {
      _isLoading = false;
    });
    return;
  }

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Clear input fields
    _usernameController.clear();
    _passwordController.clear();

    setState(() {
      _isLoading = false;
    });

    // Show login success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
    );

    // Navigate to the home screen (uncomment for production)
    // Navigator.pushReplacementNamed(context, '/home');

  } on FirebaseAuthException catch (e) {
    setState(() {
      _isLoading = false;
    });

    switch (e.code) {
      case 'invalid-credential':
        _showErrorDialog(
          context,
          title: 'خطأ في تسجيل الدخول',
          message: 'البريد الإلكتروني أو كلمة المرور غير صحيحة. حاول مرة أخرى.',
        );
        break;
      case 'invalid-email':
        setState(() {
          _usernameError = 'البريد الإلكتروني غير صالح.';
        });
        break;
      default:
        _showErrorDialog(
          context,
          title: 'حدث خطأ',
          message: e.message ?? 'حدث خطأ غير متوقع أثناء تسجيل الدخول.',
        );
        break;
    }
  } catch (_) {
    setState(() {
      _isLoading = false;
    });
    _showErrorDialog(
      context,
      title: 'خطأ غير متوقع',
      message: 'حدث خطأ أثناء تسجيل الدخول. حاول مرة أخرى لاحقًا.',
    );
  }
}

void _showErrorDialog(BuildContext context, {
  required String title,
  required String message,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.right),
      content: Text(message, textAlign: TextAlign.right),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('حسناً'),
        ),
      ],
    ),
  );
}

@override
void dispose() {
  _usernameController.dispose();
  _passwordController.dispose();
  super.dispose();
}
}
