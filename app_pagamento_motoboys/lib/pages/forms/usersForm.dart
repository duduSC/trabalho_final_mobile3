import 'package:app_pagamento_motoboys/model/user.dart';
import 'package:app_pagamento_motoboys/services/userService.dart';
import 'package:flutter/material.dart';

// 1. O construtor agora só precisa do serviço, já que não há mais edição.
class Usersform extends StatefulWidget {
  final UserService service;
  const Usersform({super.key, required this.service});

  @override
  State<Usersform> createState() => _UsersformState();
}

class _UsersformState extends State<Usersform> {
  final _formKey = GlobalKey<FormState>();
  // 2. Os controladores são inicializados diretamente, sem valores iniciais.
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  // 3. A função de salvar foi simplificada para APENAS criar.
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    
    try {
      final model = User(
        nome: _username.text.trim(),
        senha: _password.text.trim(),
      );

      await widget.service.createUser(model);
      
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Usuário'),
      ),
      body: AbsorbPointer(
        absorbing: _saving,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _username,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Informe username' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _password,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (v) {
                    final value = v?.trim() ?? '';
                    if (value.isEmpty) return 'Informe a senha';
                    return null; 
                  },
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _saving ? null : _save,
                  icon: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: const Text('Criar Usuario'), 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}