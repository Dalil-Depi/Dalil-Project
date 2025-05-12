import 'package:dalil/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Validation functions
bool isValidPhone(String phone) {
  final regex = RegExp(r'^01[0-9]{9}$');
  return regex.hasMatch(phone);
}

bool isValidPassword(String password) {
  final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
  return regex.hasMatch(password);
}

bool isValidEmail(String email) {
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return regex.hasMatch(email);
}


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
                                          hint: 'رقم الهاتف المحمول *',
                                          prefixText: '+20',
                                          errorText: _phoneError,
                                          onChanged: (value) {
                                            setState(() {
                                              _phoneError = isValidPhone(value)
                                                  ? null
                                                  : 'رقم الهاتف يجب أن يكون 11 رقما ويبدأ بـ 01';
                                            });
                                          },
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
                                            _passwordError = isValidPassword(value)
                                                ? null
                                                : 'كلمة المرور يجب أن تحتوي على حرف كبير، صغير، رقم، ورمز (!@#...) ولا تقل عن 8 أحرف';
                                          });
                                        },
                                      ),
                        
                        SizedBox(height: 15),
                        
                        // Email
                       _buildTextField(
                                        controller: _emailController,
                                        hint: 'البريد الإلكتروني *',
                                        errorText: _emailError,
                                        onChanged: (value) {
                                          setState(() {
                                            _emailError = isValidEmail(value)
                                                ? null
                                                : 'البريد الإلكتروني غير صالح';
                                          });
                                        },
                                      ),

                        
                        SizedBox(height: 30),
                        
                        // Create Account Button
                   SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _isSigningUp ? null : _handleSignup,
                                child: _isSigningUp
                                    ? CircularProgressIndicator(color: Colors.white)
                                    : Text(
                                        'انشاء حساب',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                      ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            )
,
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
errorMaxLines: 3, // Allow up to 3 lines for wrapping
errorStyle: TextStyle(
  color: Colors.red,
  fontSize: 12,
  height: 1.2,
  overflow: TextOverflow.visible,
),

    ),
    );
  }
  

bool _isSigningUp = false; // Add this at the class level

Future<void> _handleSignup() async {
  setState(() => _isSigningUp = true);

  // Re-validate fields as fallback
  setState(() {
    _firstNameError = _firstNameController.text.isEmpty ? 'برجاء إدخال الاسم الأول' : null;
    _lastNameError = _lastNameController.text.isEmpty ? 'برجاء إدخال اسم العائلة' : null;
    _phoneError = isValidPhone(_phoneController.text) ? null : 'رقم الهاتف يجب أن يكون 11 رقما ويبدأ بـ 01';
   _usernameError = _usernameController.text.isEmpty ? 'برجاء إدخال اسم المستخدم' : null;
    _passwordError = isValidPassword(_passwordController.text) ? null : 'كلمة المرور يجب أن تحتوي على حرف كبير، صغير، رقم، ورمز (!@#...) ولا تقل عن 8 أحرف';
    _emailError = isValidEmail(_emailController.text) ? null : 'البريد الإلكتروني غير صالح';
 });

  if ([_firstNameError, _lastNameError, _phoneError, _usernameError, _passwordError, _emailError].any((e) => e != null)) {
    setState(() => _isSigningUp = false);
    return;
  }

  // Show loading spinner
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(child: CircularProgressIndicator()),
  );

  try {
    final auth = FirebaseAuth.instance;
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    final userId = userCredential.user!.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'username': _usernameController.text.trim(),
      'email': _emailController.text.trim(),
      'createdAt': Timestamp.now(),
    });

    // Dismiss spinner
    Navigator.of(context).pop();

    // Show success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم إنشاء الحساب بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate to login after short delay
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  } on FirebaseAuthException catch (e) {
    Navigator.of(context).pop(); // Dismiss spinner
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('فشل في التسجيل: '),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    setState(() => _isSigningUp = false);
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