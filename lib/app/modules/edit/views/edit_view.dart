import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/edit_controller.dart';

class EditView extends GetView<EditController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Editar Perfil',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Editar Perfil',
                style: textTheme.headline2?.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                // ignore: lines_longer_than_80_chars
                'Lorem ipsum dolor sit amet, consectetur  adi sed do eiusmod tempor  incididunt ut labore etdolore magna aliqua.  Ut enim ad minim veniam.',
                style: textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              MoralarTextField(
                label: 'Nome do profissional',
                color: MoralarColors.waterBlue,
                controller: TextEditingController(text: 'Lucas'),
                style: textTheme.bodyText1
                    ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
              ),
              const SizedBox(height: 16),
              MoralarTextField(
                label: 'Cargo',
                color: MoralarColors.waterBlue,
                controller: TextEditingController(text: 'Desenvolvedor Mobile'),
                style: textTheme.bodyText1
                    ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
              ),
              const SizedBox(height: 16),
              MoralarTextField(
                label: 'CPF',
                color: MoralarColors.waterBlue,
                formats: [Formats.cpfMaskFormatter],
                controller: TextEditingController(text: '777.777.777-77'),
                keyboard: TextInputType.number,
                style: textTheme.bodyText1
                    ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
              ),
              const SizedBox(height: 16),
              MoralarTextField(
                label: 'E-Mail',
                color: MoralarColors.waterBlue,
                controller: TextEditingController(text: 'lucas@megaleios.com'),
                keyboard: TextInputType.emailAddress,
                style: textTheme.bodyText1
                    ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
              ),
              const SizedBox(height: 16),
              MoralarTextField(
                label: 'Telefone',
                color: MoralarColors.waterBlue,
                formats: [
                  Formats.phoneMaskFormatter,
                ],
                controller: TextEditingController(text: '(77)77777-7777'),
                keyboard: TextInputType.emailAddress,
                style: textTheme.bodyText1
                    ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
              ),
              const SizedBox(height: 32),
              MoralarButton(
                onPressed: () {
                  print('Editar Perfil');
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Salvar Alterações',
                    style: textTheme.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
