import 'package:flutter/material.dart';
import 'package:resturant/screens/login_screen.dart';
import 'package:resturant/widgets/custom_button.dart';
import 'package:resturant/widgets/custom_textfield.dart';
// Assuming your logo is in assets
import 'package:resturant/constants/app_assets.dart';
import 'package:resturant/services/auth_service.dart';
import 'package:resturant/screens/menu_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    if (_passwordController.text.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 6 characters long.'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final user = await _authService.signUpWithEmailAndPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (user != null && mounted) {
      // TODO: Save user's name and phone number to a 'users' collection in Firestore.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create account. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAssets.logo, height: 100),
                const SizedBox(height: 16),
                const Text(
                  'Create an account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Enter Your Name',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter Your Email',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _phoneController,
                  hintText: 'Enter Your Phone Number',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter Your Password',
                  isPassword: !_isPasswordVisible,
                  suffixIcon: _isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onSuffixIconPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: _isLoading ? null : _signUp,
                ),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                  ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
