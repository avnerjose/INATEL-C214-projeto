import 'dart:ffi';

import 'package:books_app/controllers/firebase_auth.dart';
import 'package:books_app/core/app_colors.dart';
import 'package:books_app/views/screens/editProfile/components/edit_input.dart';
import 'package:books_app/views/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late User? user = null;
  String _errorMessage = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmController =
      TextEditingController();
  final TextEditingController _photoURLController = TextEditingController();
  bool isPhotoUrlInputActive = false;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          this.user = user;
        });
        _nameController.text = user.displayName ?? "";
        _emailController.text = user.email ?? "";
      }
    });

    super.initState();
  }

  Future<void> _handleEditProfile(context) async {
    if (_newPasswordController.text != _newPasswordConfirmController.text) {
      setState(() {
        _errorMessage = "Senhas não conferem";
      });
      return;
    }

    if (_newPasswordController.text.length < 6 &&
        _newPasswordController.text.isNotEmpty &&
        _newPasswordConfirmController.text.isNotEmpty) {
      setState(() {
        _errorMessage = "Senha deve ter no mínimo 6 caracteres";
      });
      return;
    }

    try {
      await FirebaseAuthHelper(FirebaseAuth.instance).editProfile(
          _nameController.text,
          _emailController.text,
          _newPasswordController.text,
          _photoURLController.text);

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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text("Editar perfil",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.dark),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: [
                  Stack(children: [
                    ProfilePicture(
                        name: user?.displayName ?? "",
                        radius: 40,
                        fontsize: 32),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.green,
                        child: IconButton(
                          iconSize: 16,
                          onPressed: () {
                            setState(() {
                              isPhotoUrlInputActive = !isPhotoUrlInputActive;
                            });
                          },
                          icon: Icon(
                              isPhotoUrlInputActive ? Icons.close : Icons.edit),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                  if (_errorMessage.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8)
                  ],
                  if (isPhotoUrlInputActive)
                    EditInput(
                      controller: _photoURLController,
                      label: "URL da foto",
                    ),
                  EditInput(
                    controller: _nameController,
                    label: "Nome completo",
                  ),
                  const SizedBox(height: 8),
                  EditInput(controller: _emailController, label: "E-mail"),
                  const SizedBox(height: 8),
                  EditInput(
                    controller: _newPasswordController,
                    label: "Nova senha",
                  ),
                  EditInput(
                    controller: _newPasswordConfirmController,
                    label: "Confirmar nova senha",
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          },
                          style: OutlinedButton.styleFrom(
                              primary: AppColors.lightGray,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 8),
                              side: const BorderSide(
                                  color: AppColors.lightGray, width: 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: const Text("CANCELAR",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ))),
                      ElevatedButton(
                          onPressed: () async {
                            await _handleEditProfile(context);
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 8),
                              primary: AppColors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: const Text("SALVAR",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)))
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
