import 'package:books_app/controllers/firebase_auth.dart';
import 'package:books_app/core/app_colors.dart';
import 'package:books_app/views/screens/home/home_screen.dart';
import 'package:books_app/views/screens/login/login_screen.dart';
import 'package:books_app/views/widgets/form_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _errorMessage = "";
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() {
      setState(() {
        _errorMessage = "";
      });
    });
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
    _confirmPasswordController.addListener(() {
      setState(() {
        _errorMessage = "";
      });
    });
  }

  Future<void> _handleSignUp() async {
    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      setState(() {
        _errorMessage = "As senhas não coincidem";
      });
      return;
    }

    try {
      FirebaseAuthHelper authHelper = FirebaseAuthHelper(FirebaseAuth.instance);
      await authHelper.signUp(_nameController.text, _emailController.text,
          _passwordController.text, _rememberMe);
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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
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
                        "Crie sua conta",
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
                          hintText: "Nome Completo",
                          icon: Icons.person,
                          controller: _nameController),
                      const SizedBox(height: 8),
                      FormInput(
                          hintText: "Email",
                          icon: Icons.email,
                          controller: _emailController),
                      const SizedBox(height: 8),
                      FormInput(
                        hintText: "Senha",
                        icon: Icons.key,
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 8),
                      FormInput(
                        hintText: "Confirmar senha",
                        icon: Icons.key,
                        controller: _confirmPasswordController,
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
                          await _handleSignUp();
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(56)),
                        child: const Text("Cadastrar",
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
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            "Já possuo uma conta",
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
