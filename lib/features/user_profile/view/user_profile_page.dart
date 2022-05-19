// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:user_registration/features/user_profile/viewmodel/user_profile_view_model.dart';
import 'package:user_registration/shared/models/profiles_enum.dart';
import 'package:user_registration/shared/widgets/default_text_field.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _viewModel = UserProfileViewModel();
  bool _hidePassword = true;
  bool _isUser = false;
  bool _isManager = false;
  bool _isAdministrator = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Wrap(
                spacing: 10,
                children: [
                  FilterChip(
                    label: Text('USER'),
                    selected: _isUser,
                    elevation: 0,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    onSelected: (value) {
                      setState(() {
                        _isUser = value;
                      });
                    },
                  ),
                  FilterChip(
                    label: Text('MANAGER'),
                    selected: _isManager,
                    elevation: 0,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    onSelected: (value) {
                      setState(() {
                        _isManager = value;
                      });
                    },
                  ),
                  FilterChip(
                    label: Text('ADMINISTRATOR'),
                    selected: _isAdministrator,
                    elevation: 0,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    onSelected: (value) {
                      setState(() {
                        _isAdministrator = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            DefaultTextField(
              label: "Name", 
              controller: _nameController,
              maxLength: 50,
              icon: const Icon(Icons.person),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: _viewModel.cpfErrorText,
              builder: (context, String? error, child) {
                return DefaultTextField(
                  label: "CPF", 
                  controller: _cpfController,
                  errorText: error,
                  onChanged: (text) => _viewModel.validateCpf(text),
                  icon: const Icon(Icons.person_pin_rounded),
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: "###.###.###-##", 
                      filter: { 
                        "#": RegExp(r'[0-9]') 
                      },
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: _viewModel.emailErrorText,
              builder: (context, String? error, child) {
                return DefaultTextField(
                  label: "Email", 
                  controller: _emailController,
                  maxLength: 20,
                  icon: const Icon(Icons.mail_rounded),
                  errorText: error,
                  inputType: TextInputType.emailAddress,
                  onChanged: (value) => _viewModel.validateMail(value),
                );
              },
            ),
            const SizedBox(height: 20),
            DefaultTextField(
              label: "Password", 
              controller: _passwordController,
              maxLength: 10,
              isPassword: _hidePassword,
              icon: const Icon(Icons.key_rounded),
              suffixIcon: IconButton(
                icon: const Icon(Icons.remove_red_eye_rounded),
                color: _hidePassword 
                  ? Colors.grey
                  : Theme.of(context).colorScheme.primary,
                onPressed: () => _onShowPassword()
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                color: Theme.of(context).colorScheme.primary,
                height: 60,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "SAVE",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary, 
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onShowPassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }
}