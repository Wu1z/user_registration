import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_registration/features/user_profile/viewmodel/user_profile_view_model.dart';
import 'package:user_registration/shared/connection/api_exception.dart';
import 'package:user_registration/shared/models/person_model.dart';
import 'package:user_registration/shared/models/register_action_enum.dart';
import 'package:user_registration/shared/repositories/person_repository.dart';
import 'package:user_registration/shared/widgets/async_button.dart';
import 'package:user_registration/shared/widgets/confirm_dialog.dart';
import 'package:user_registration/shared/widgets/default_text_field.dart';
import 'package:user_registration/shared/widgets/my_choice_chip.dart';

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
  final _repository = PersonRepository(Client());
  final _mask = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  final List<String> _profiles = ["USER"];
  bool _hidePassword = true;
  bool _isLoading = false;
  bool _isNew = true;

  @override
  void initState() {
    super.initState();
    if(widget.person != null) {
      _isNew = false;
      _nameController.text = widget.person!.name ?? "";
      _cpfController.text = widget.person!.cpf ?? "";
      _emailController.text = widget.person!.email ?? "";
      _passwordController.text = widget.person!.password ?? "";
      if(widget.person!.profiles != null && widget.person!.profiles!.isNotEmpty) {
        _addProfile(widget.person!.profiles!.first);
      }
    }
  }

  Future<bool> post(PersonModel person) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return _repository.post(person, token);
  }

  Future<bool> put(PersonModel person) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return _repository.put(person, token);
  }
  
  Future<bool> delete(PersonModel? person) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return _repository.delete(person?.id, token);
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
            MyChoiceChip(
              initialValue: _profiles.first,
              onChanged: (value) {
                _addProfile(value);
              },
            ),
            const SizedBox(height: 20),
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
                  inputType: TextInputType.number,
                  inputFormatters: [_mask],
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
              onPressed: _onPressedSave
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: !_isNew,
              child: AsyncButton(
                text: "DELETE",
                isLoading: _isLoading,
                onPressed: _onPressedDelete
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> sendPerson() async {
    final person = PersonModel(
      id: widget.person?.id,
      name: _nameController.text,
      cpf: _cpfController.text,
      email: _emailController.text,
      password: _passwordController.text,
      profiles: _profiles,
    );
    return _isNew ? post(person) : put(person);
  }

  _onShowPassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void _onPressedSave() async {
    _changeLoadingState(true);
    await sendPerson().then((success) {
      _changeLoadingState(false);
      _backToList(success);
    }).catchError((error, stackTrace) {
      _showError(error);
    });
    _changeLoadingState(false);
  }

  void _backToList(bool success) {
    if(success) {
      final action = _isNew ? RegisterAction.insert : RegisterAction.update;
      Navigator.pop(context, action);
    }
  }

  void _onPressedDelete() {
    _changeLoadingState(true);
    _showConfirmDialog();
    _changeLoadingState(false);
  }

  void _showConfirmDialog() {
    showDialog(
      context: context, 
      builder: (_) {
        return ConfirmDialog(
          titulo: "Attention", 
          descricao: "Do you really want to delete this person?", 
          onConfirm: () => delete(widget.person).then((value) {
            if(value) {
              Navigator.pop(context);
              Navigator.pop(context, RegisterAction.delete);
            }
          }).catchError((error) {
            _showError(error);
          }),
        );
      },
    );
  }

  void _changeLoadingState(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _addProfile(String value) {
    debugPrint(value);
    _profiles.clear();
    _profiles.add(value);
  }

  void _showError(AppException error) {
    showDialog(
      context: context, 
      builder: (_) {
        return AlertDialog(
          content: Text(error.toString()),
          actions: [
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                child: const Text("CONFIRM"),
                onPressed: () {
                  Navigator.pop(context);
                }, 
              ),
            ),
          ],
        );
      }
    );
  }
}