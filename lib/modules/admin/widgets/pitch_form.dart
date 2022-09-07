import 'package:court_finder/models/models.dart';
import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PitchForm extends StatelessWidget {
  const PitchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey.withOpacity(0.6)),
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Agregar Cancha',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth > 600) {
                      return const _BuilWideContent();
                    } else {
                      return const _BuilNormalContent();
                    }
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuilWideContent extends StatelessWidget {
  const _BuilWideContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 40),
        Row(
          children: [
            Flexible(
                child: CustomInput(
              initialValue: '',
              onChanged: (value) => value,
              hintText: 'Nombre Cancha',
              icon: FontAwesomeIcons.addressCard,
            )),
            const SizedBox(width: 20),
            Flexible(
              child: CustomDropdown(
                hintText: 'Seleccione Categoría',
                icon: Icons.category_outlined,
                items: <DropdownValueModel>[
                  DropdownValueModel('1', 'Futbol'),
                  DropdownValueModel('2', 'Basquetbol'),
                  DropdownValueModel('3', 'Padel'),
                  DropdownValueModel('4', 'Tenis')
                ].map((DropdownValueModel value) {
                  return DropdownMenuItem<DropdownValueModel>(
                    value: value,
                    child: Text(value.text),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Flexible(
              child: CustomInput(
                initialValue: '',
                onChanged: (value) => value,
                keyboardType: TextInputType.number,
                hintText: 'Precio',
                icon: Icons.attach_money_outlined,
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: CustomDropdown(
                hintText: 'Seleccione Tamaño',
                icon: Icons.layers_outlined,
                items: <DropdownValueModel>[
                  DropdownValueModel('1', '1v1'),
                  DropdownValueModel('2', '2v2'),
                  DropdownValueModel('3', '6v6'),
                  DropdownValueModel('4', '11v11')
                ].map((DropdownValueModel value) {
                  return DropdownMenuItem<DropdownValueModel>(
                    value: value,
                    child: Text(value.text),
                  );
                }).toList(),
              ),
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
  const _BuilNormalContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 40),
        CustomInput(
          initialValue: '',
          onChanged: (value) => value,
          hintText: 'Nombre Cancha',
          icon: FontAwesomeIcons.addressCard,
        ),
        const SizedBox(width: 20),
        CustomDropdown(
          hintText: 'Seleccione Categoría',
          icon: Icons.category_outlined,
          items: <DropdownValueModel>[
            DropdownValueModel('1', 'Futbol'),
            DropdownValueModel('2', 'Basquetbol'),
            DropdownValueModel('3', 'Padel'),
            DropdownValueModel('4', 'Tenis')
          ].map((DropdownValueModel value) {
            return DropdownMenuItem<DropdownValueModel>(
              value: value,
              child: Text(value.text),
            );
          }).toList(),
        ),
        const SizedBox(width: 20),
        CustomInput(
          initialValue: '',
          onChanged: (value) => value,
          keyboardType: TextInputType.number,
          hintText: 'Precio',
          icon: Icons.attach_money_outlined,
        ),
        const SizedBox(width: 20),
        CustomDropdown(
          hintText: 'Seleccione Tamaño',
          icon: Icons.layers_outlined,
          items: <DropdownValueModel>[
            DropdownValueModel('1', '1v1'),
            DropdownValueModel('2', '2v2'),
            DropdownValueModel('3', '6v6'),
            DropdownValueModel('4', '11v11')
          ].map((DropdownValueModel value) {
            return DropdownMenuItem<DropdownValueModel>(
              value: value,
              child: Text(value.text),
            );
          }).toList(),
        ),
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
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        disabledColor: Colors.grey,
        elevation: 0,
        color: Theme.of(context).primaryColor,
        onPressed: () {},
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: const Text(
              'Guardar',
              style: TextStyle(color: Colors.white),
            )));
  }
}
