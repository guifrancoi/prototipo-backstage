import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class RecuperarSenhaScreen extends StatefulWidget {
  const RecuperarSenhaScreen({super.key});

  @override
  State<RecuperarSenhaScreen> createState() => _RecuperarSenhaScreenState();
}

class _RecuperarSenhaScreenState extends State<RecuperarSenhaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _recuperar() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<AuthProvider>();
    await provider.recuperarSenha(_emailController.text.trim());

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Recuperação de senha'),
        content: const Text(
          'Se o e-mail estiver cadastrado, as instruções serão enviadas.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar senha')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _emailController,
                label: 'E-mail cadastrado',
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validarEmail,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: provider.isLoading ? 'Enviando...' : 'Recuperar senha',
                onPressed: provider.isLoading ? null : _recuperar,
              ),
            ],
          ),
        ),
      ),
    );
  }
}