import 'package:barber_portal/shared/widgets/brb_button.dart';
import 'package:barber_portal/shared/widgets/brb_container.dart';
import 'package:barber_portal/shared/widgets/brb_text.dart';
import 'package:barber_portal/shared/widgets/brb_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomerRegister extends StatelessWidget {
  CustomerRegister({super.key, this.onSavePressed});

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  final Function(String, String)? onSavePressed;

  @override
  Widget build(BuildContext context) {
    return BRBContainer(
      color: Colors.white,
      borderRadius: 10,
      width: 700,
      height: 500,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BRBText.title1(text: 'Cadastrar cliente'),
              const SizedBox(width: 24),
              IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
            ],
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BRBTextFormField(
                    controller: _nameController,
                    label: 'Nome',
                  ),
                  const SizedBox(height: 16),
                  BRBTextFormField(
                    controller: _phoneController,
                    label: 'Descrição',
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BRBButton(
                text: 'Cancelar',
                width: 200,
                onPressed: () => context.pop(),
              ),
              const SizedBox(width: 24),
              BRBButton(
                text: 'Salvar',
                width: 200,
                onPressed: () {
                  onSavePressed?.call(
                    _nameController.text,
                    _phoneController.text,
                  );
                  context.pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
