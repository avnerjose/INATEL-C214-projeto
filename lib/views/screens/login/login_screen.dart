import 'package:books_app/controllers/firebase_auth.dart';
import 'package:books_app/core/app_colors.dart';
import 'package:books_app/views/screens/home/home_screen.dart';
import 'package:books_app/views/screens/register/register_screen.dart';
import 'package:books_app/views/widgets/form_input.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {
        _errorMessage = "";
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _errorMessage = "";
      });
    });
  }

  Future<void> handleSignIn() async {
    try {
      FirebaseAuthHelper authHelper = FirebaseAuthHelper();
      await authHelper.signIn(
          _emailController.text, _passwordController.text, _rememberMe);
      setState(() {
        _errorMessage = "";
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: AppColors.dark,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                            text: "Book",
                            style: TextStyle(color: AppColors.purple)),
                        TextSpan(
                            text: "Control",
                            style: TextStyle(color: AppColors.green))
                      ]),
                ),
                const SizedBox(
                  height: 64,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Acesse sua conta",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      if (_errorMessage.trim() != '') ...[
                        Text(
                          _errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8)
                      ],
                      FormInput(
                          hintText: "Email",
                          icon: Icons.email,
                          controller: _emailController),
                      const SizedBox(
                        height: 8,
                      ),
                      FormInput(
                        hintText: "Senha",
                        icon: Icons.key,
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _rememberMe,
                              onChanged: (bool? value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              }),
                          const Text(
                            "Lembrar de mim",
                            style: TextStyle(
                                color: AppColors.lightGray, fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await handleSignIn();
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(56)),
                        child: const Text("Entrar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: const Text(
                            "Ainda não possuo uma conta",
                            style: TextStyle(color: AppColors.lightGray),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
