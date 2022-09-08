import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/admin/providers/providers.dart';
import 'package:court_finder/modules/auth/services/auth_services.dart';
import 'package:court_finder/services/services.dart';
import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PitchForm extends StatelessWidget {
  const PitchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categorieService = Provider.of<CategoryService>(context);
    final formProvider = Provider.of<MyPitchesFormProvider>(context);
    formProvider.loadCategoriesDropdown(categorieService.categories);

    final Map<String, Widget> form = {
      'nombre_cancha': CustomInput(
        initialValue: formProvider.pitch.name,
        onChanged: (value) => formProvider.pitch.name = value,
        hintText: 'Nombre Cancha',
        icon: FontAwesomeIcons.addressCard,
      ),
      'categoria': CustomDropdown(
        hintText: 'Seleccione Categoría',
        icon: Icons.category_outlined,
        items: formProvider.categoriesDropdown.map((DropdownValueModel value) {
          return DropdownMenuItem<DropdownValueModel>(
            value: value,
            child: Text(value.text),
          );
        }).toList(),
        onChanged: (value) {
          formProvider.pitch.categoryId = value!.value;
          formProvider.loadDropdown(value.value);
        },
      ),
      'precio': CustomInput(
        initialValue:
            formProvider.pitch.price > 0 ? '${formProvider.pitch.price}' : '',
        onChanged: (value) => formProvider.pitch.price = int.parse(value),
        keyboardType: TextInputType.number,
        hintText: 'Precio',
        icon: Icons.attach_money_outlined,
      ),
      'tamaño': CustomDropdown(
        hintText: 'Seleccione Tamaño',
        icon: FontAwesomeIcons.ruler,
        items: formProvider.sizeDropdown.map((DropdownValueModel value) {
          return DropdownMenuItem<DropdownValueModel>(
            value: value,
            child: Text(value.text),
          );
        }).toList(),
        onChanged: (value) => formProvider.pitch.size = value!.text,
      ),
      'periodo': CustomDropdown(
        hintText: 'Seleccione Periodo',
        icon: Icons.timer_outlined,
        items: formProvider.periodDropdown.map((DropdownValueModel value) {
          return DropdownMenuItem<DropdownValueModel>(
            value: value,
            child: Text(value.text),
          );
        }).toList(),
        onChanged: (value) =>
            formProvider.pitch.period = int.parse(value!.value),
      ),
      'superficie': CustomDropdown(
        hintText: 'Seleccione Superficie',
        icon: Icons.layers_outlined,
        items: formProvider.surfaceDropdown.map((DropdownValueModel value) {
          return DropdownMenuItem<DropdownValueModel>(
            value: value,
            child: Text(value.text),
          );
        }).toList(),
        onChanged: (value) => formProvider.pitch.surface = value!.text,
      ),
    };
    return Container(
      height: size.height * 0.6,
      color: const Color(0xffF2F2F2),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.only(top: 5, right: 5),
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.white),
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formProvider.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Agregar Cancha',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return _BuilWideContent(form);
                      } else {
                        return _BuilNormalContent(form);
                      }
                    })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuilWideContent extends StatelessWidget {
  const _BuilWideContent(
    this.form, {
    Key? key,
  }) : super(key: key);

  final Map<String, Widget> form;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 40),
        Row(
          children: [
            Flexible(child: form['nombre_cancha']!),
            const SizedBox(width: 20),
            Flexible(child: form['categoria']!),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Flexible(
              child: form['precio']!,
            ),
            const SizedBox(width: 20),
            Flexible(
              child: form['tamaño']!,
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Flexible(
              child: form['periodo']!,
            ),
            const SizedBox(width: 20),
            Flexible(
              child: form['superficie']!,
            ),
          ],
        ),
        const SizedBox(height: 30),
        const _SaveButton(),
      ],
    );
  }
}

class _BuilNormalContent extends StatelessWidget {
  const _BuilNormalContent(
    this.form, {
    Key? key,
  }) : super(key: key);

  final Map<String, Widget> form;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 40),
        form['nombre_cancha']!,
        const SizedBox(width: 20),
        form['categoria']!,
        const SizedBox(width: 20),
        form['precio']!,
        const SizedBox(width: 20),
        form['tamaño']!,
        const SizedBox(height: 20),
        form['periodo']!,
        const SizedBox(height: 20),
        form['superficie']!,
        const SizedBox(height: 30),
        const _SaveButton(),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<MyPitchesFormProvider>(context);
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        disabledColor: Colors.grey,
        elevation: 0,
        color: Theme.of(context).primaryColor,
        onPressed: formProvider.isLoading
            ? null
            : () async {
                FocusScope.of(context).unfocus();
                final navigator = Navigator.of(context);
                if (!formProvider.isValidForm()) return;

                formProvider.isLoading = true;
                final authService =
                    Provider.of<AuthService>(context, listen: false);

                final resp = await formProvider
                    .savePitch(authService.userLogin!.adminCourts[0].id!);

                formProvider.isLoading = false;
                navigator.pop();

                if (resp != null) {
                  NotificationService.showSnackbar(resp);
                } else {
                  NotificationService.showSnackbar('Datos guardados con éxito');
                }
              },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Text(
              formProvider.isLoading ? 'Guardando...' : 'Guardar',
              style: const TextStyle(color: Colors.white),
            )));
  }
}
