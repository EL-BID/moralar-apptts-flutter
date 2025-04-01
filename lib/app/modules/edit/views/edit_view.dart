import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:validatorless/validatorless.dart';

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
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Obx(() {
                  return Visibility(
                    visible: controller.isLoading.value,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 128),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    replacement: Column(
                      children: [
                        MoralarTextField(
                          label: 'Nome do profissional',
                          color: MoralarColors.waterBlue,
                          validators: [
                            Validatorless.required(
                              'Nome não pode estar em branco',
                            )
                          ],
                          controller: controller.name,
                          labelStyle: textTheme.bodyLarge?.copyWith(
                              color: MoralarColors.waterBlue, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        MoralarTextField(
                          label: 'Cargo',
                          validators: [
                            Validatorless.required(
                              'Cargo não pode estar em branco',
                            )
                          ],
                          color: MoralarColors.waterBlue,
                          controller: controller.job,
                          labelStyle: textTheme.bodyLarge?.copyWith(
                              color: MoralarColors.waterBlue, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        MoralarTextField(
                          label: 'CPF',
                          color: MoralarColors.waterBlue,
                          formats: [Formats.cpfMaskFormatter],
                          controller: controller.cpf,
                          readOnly: true,
                          validators: [
                            Validatorless.required(
                              'CPF não pode estar em branco',
                            ),
                            Validatorless.cpf('Digite um CPF existente')
                          ],
                          keyboard: const TextInputType.numberWithOptions(
                            signed: true,
                          ),
                          labelStyle: textTheme.bodyLarge?.copyWith(
                              color: MoralarColors.waterBlue, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        MoralarTextField(
                          label: 'E-Mail',
                          color: MoralarColors.waterBlue,
                          validators: [
                            Validatorless.required(
                              'E-mail não pode estar em branco',
                            ),
                            Validatorless.email('Digite um e-mail existente')
                          ],
                          controller: controller.email,
                          keyboard: TextInputType.emailAddress,
                          labelStyle: textTheme.bodyLarge?.copyWith(
                              color: MoralarColors.waterBlue, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        MoralarTextField(
                          label: 'Telefone',
                          color: MoralarColors.waterBlue,
                          formats: [
                            Formats.phoneMaskFormatter,
                          ],
                          controller: controller.tel,
                          keyboard: TextInputType.emailAddress,
                          labelStyle: textTheme.bodyLarge?.copyWith(
                              color: MoralarColors.waterBlue, fontSize: 16),
                        ),
                        const SizedBox(height: 32),
                        MoralarButton(
                          isLoading: controller.buttonLoading.value,
                          onPressed: () {
                            controller.editProfile();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Salvar Alterações',
                              style: textTheme.labelLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
