import 'package:app_pagamento_motoboys/model/motoboy.dart';
import 'package:app_pagamento_motoboys/services/motoboyService.dart';
import 'package:flutter/material.dart';

class Motoboysform extends StatefulWidget {
  final MotoboyService service;
  final Motoboy? initial;
  const Motoboysform({super.key, required this.service, this.initial});

  @override
  State<Motoboysform> createState() => _MotoboysformState();
}

class _MotoboysformState extends State<Motoboysform> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nome;
  late TextEditingController _cpf;
  late TextEditingController _telefone;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nome = TextEditingController(text: widget.initial?.nome ?? "");
    _cpf = TextEditingController(text: widget.initial?.cpf ?? "");
    _telefone = TextEditingController(text: widget.initial?.cpf ?? "");
  }

  @override
  void dispose() {
    _nome.dispose();
    _cpf.dispose();
    _telefone.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final model = Motoboy(
        id: widget.initial?.id,
        nome: _nome.text.trim(),
        telefone: _telefone.text.trim(),
        cpf: _cpf.text.trim(),
      );

      if (widget.initial == null) {
        await widget.service.createMotoboy(model);
      } else {
        await widget.service.updateMotoboy(model);
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro: $e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    if (widget.initial?.id == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remover motoboy'),
        content: const Text('Tem certeza que deseja remover este motoboy?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remover'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _saving = true);
    try {
      await widget.service.deleteMotoboy(widget.initial!.id!);
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro: $e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.initial != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Editar Motoboy' : 'Novo Motoboy'),
        actions: [
          if (editing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _saving ? null : _delete,
              tooltip: 'Remover',
            ),
        ],
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
                  controller: _nome,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cpf,
                  decoration: const InputDecoration(labelText: 'CPF'),
                  validator: (v) {
                    final value = v?.trim() ?? '';
                    if (value.isEmpty || v == null) return 'Informe o CPF';
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _telefone,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  validator: (v) {
                    final value = v?.trim() ?? '';
                    if (value.isEmpty || v == null) return 'Informe o telefone';
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
                  label: Text(editing ? 'Salvar alterações' : 'Criar motoboy'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
