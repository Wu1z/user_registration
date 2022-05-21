import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_registration/features/user_profile/viewmodel/user_profile_view_model.dart';
import 'package:user_registration/shared/connection/api_client.dart';
import 'package:user_registration/shared/models/person_model.dart';
import 'package:user_registration/shared/widgets/async_button.dart';
import 'package:user_registration/shared/widgets/default_text_field.dart';

class UserProfilePage extends StatefulWidget {
  final PersonModel? person;

  const UserProfilePage({
    Key? key, 
    this.person,
  }) : super(key: key);

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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if(widget.person != null) {
      _nameController.text = widget.person!.name ?? "";
      _cpfController.text = widget.person!.cpf ?? "";
      _emailController.text = widget.person!.email ?? "";
      _passwordController.text = widget.person!.password ?? "";
    }
  }

  Future<bool> post(PersonModel person) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return ApiClient().post(person, token);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Wrap(
                spacing: 10,
                children: [
                  FilterChip(
                    label: const Text('USER'),
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
                    label: const Text('MANAGER'),
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
                    label: const Text('ADMINISTRATOR'),
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
            AsyncButton(
              text: "SAVE",
              isLoading: _isLoading,
              onPressed: _startLoading
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

  void _startLoading() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    });
  }

  Future<bool> sendPerson() async {
    final person = PersonModel(
      name: _nameController.text,
      cpf: _cpfController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    return post(person);
  }
}