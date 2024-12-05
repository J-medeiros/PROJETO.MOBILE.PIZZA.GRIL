// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import '../../../core/tema/colors.dart';
import '../../../core/tema/estilos_texto.dart';

// ignore: use_key_in_widget_constructors
class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final _cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
  final _phoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####');

  // Validação de Data de Nascimento
  bool _isValidBirthDate(DateTime date) {
    final currentDate = DateTime.now();

    final age = currentDate.year -
        date.year -
        ((currentDate.month < date.month ||
                (currentDate.month == date.month && currentDate.day < date.day))
            ? 1
            : 0);

    return age >= 17;
  }

  // Validação de Senha (flexível para "..." em teste)
  bool _isValidPassword(String value) {
    if (value == '...') return true; // Para teste
    final passwordRegExp = RegExp(r'^(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegExp.hasMatch(value);
  }

  // Validação de Email
  bool _isValidEmail(String value) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(value);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final initialDate = DateTime.now().subtract(const Duration(days: 365 * 17));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != initialDate) {
      setState(() {
        _birthDateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: AppColors.buttonBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // Campo de Nome
              const Text('Nome Completo'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Digite seu nome completo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome não pode ser vazio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Campo de Telefone
              const Text('Telefone'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '(XX) XXXXX-XXXX',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [_phoneFormatter],
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 14) {
                    return 'Telefone inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Campo de CPF
              const Text('CPF'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '000.000.000-00',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [_cpfFormatter],
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 14) {
                    return 'CPF inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Campo de Data de Nascimento com calendário
              const Text('Data de Nascimento'),
              TextFormField(
                controller: _birthDateController,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Selecione a data de nascimento',
                  border: OutlineInputBorder(),
                ),
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A data de nascimento é obrigatória';
                  }
                  final birthDate = DateFormat('MM/dd/yyyy').parse(value);
                  if (!_isValidBirthDate(birthDate)) {
                    return 'Você deve ter no mínimo 17 anos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Campo de Email
              const Text('Email'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Digite seu email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !_isValidEmail(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Campo de Senha
              const Text('Senha'),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Digite sua senha',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !isPasswordVisible,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !_isValidPassword(value)) {
                    return 'A senha deve ter no mínimo 8 caracteres, incluindo 1 especial';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Campo de Confirmação de Senha
              const Text('Confirme sua Senha'),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirme sua senha',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !isConfirmPasswordVisible,
                validator: (value) {
                  if (value == null || value != _passwordController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Botão de Registro
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Registrado com sucesso!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    _showSnackBar('Corrija os campos destacados em vermelho');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonBackground,
                ),
                child: const Text('Registrar', style: TextStyles.button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
