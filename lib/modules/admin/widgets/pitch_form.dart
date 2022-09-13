import 'package:court_finder/helpers/format_helper.dart';
import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/admin/providers/providers.dart';
import 'package:court_finder/modules/admin/widgets/widgets.dart';
import 'package:court_finder/services/services.dart';
import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PitchForm extends StatefulWidget {
  const PitchForm({Key? key}) : super(key: key);

  @override
  State<PitchForm> createState() => _PitchFormState();
}

class _PitchFormState extends State<PitchForm> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return Scaffold(
          appBar: AppBar(
              title: const _Title(),
              bottom: TabBar(
                controller: tabController,
                onTap: (value) => setState(() {
                  tabController.index = value;
                }),
                indicatorColor: const Color(0xff264653),
                tabs: const [
                  Tab(
                      icon: Icon(Icons.sports_soccer_outlined),
                      text: 'General'),
                  Tab(
                    icon: Icon(Icons.attach_money_outlined),
                    text: 'Precios Variables',
                  ),
                ],
              )),
          body: TabBarView(
              controller: tabController,
              children: const [_General(), _Prices()]),
          floatingActionButton: tabController.index == 0
              ? const _FloatingActionButtonTab1()
              : const _FloatingActionButtonTab2(),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: const _Title(),
          ),
          body: _General(
              tab2: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color(0xff264653).withOpacity(0.2))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Precios Variables'),
                        SizedBox(height: 10),
                        _Prices(
                          isShrinkWrap: true,
                          color: Colors.white,
                        )
                      ]))),
          floatingActionButton: const _FloatingActionButtonTab1(),
        );
      }
    });
  }
}

class _FloatingActionButtonTab1 extends StatelessWidget {
  const _FloatingActionButtonTab1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<PitchesFormProvider>(context);

    return FloatingActionButton(
        onPressed: formProvider.isLoading
            ? null
            : () async {
                final pitchService =
                    Provider.of<PitchService>(context, listen: false);
                FocusScope.of(context).unfocus();

                final scaffold = ScaffoldMessenger.of(context);

                if (!formProvider.isValidForm()) return;

                formProvider.isLoading = true;
                final courtService =
                    Provider.of<CourtService>(context, listen: false);
                bool isInsert = formProvider.pitch == null;

                final resp = await formProvider.savePitch(courtService.court!);

                if (isInsert) {
                  pitchService.refreshGrid();
                }
                formProvider.isLoading = false;

                if (resp != null) {
                  NotificationService.showSnackbar(resp, scaffold: scaffold);
                } else {
                  NotificationService.showSnackbar('Datos guardados con éxito',
                      scaffold: scaffold);
                }
              },
        child: formProvider.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save));
  }
}

class _FloatingActionButtonTab2 extends StatelessWidget {
  const _FloatingActionButtonTab2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamicPriceProvider = Provider.of<DynamicPriceProvider>(context);

    return FloatingActionButton(
        backgroundColor: dynamicPriceProvider.pitch == null
            ? Colors.grey[400]
            : Theme.of(context).primaryColor,
        onPressed: dynamicPriceProvider.isLoading ||
                dynamicPriceProvider.pitch == null
            ? null
            : () async {
                FocusScope.of(context).unfocus();
                final navigator = Navigator.of(context);
                final courtService =
                    Provider.of<CourtService>(context, listen: false);

                dynamicPriceProvider.isLoading = true;

                final resp = await dynamicPriceProvider
                    .saveDynamicPrice(courtService.court!);

                dynamicPriceProvider.isLoading = false;
                navigator.pop();

                if (resp != null) {
                  NotificationService.showSnackbar(resp);
                } else {
                  NotificationService.showSnackbar('Datos guardados con éxito');
                }
              },
        child: dynamicPriceProvider.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save));
  }
}

class _General extends StatelessWidget {
  const _General({Key? key, this.tab2}) : super(key: key);
  final Widget? tab2;
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<PitchesFormProvider>(context);

    final Map<String, Widget> form = {
      'nombre_cancha': CustomInput(
        initialValue: formProvider.name,
        onChanged: (value) => formProvider.name = value,
        hintText: 'Nombre Cancha',
        icon: FontAwesomeIcons.addressCard,
      ),
      'categoria': CustomDropdown(
        hintText: 'Seleccione Categoría',
        icon: Icons.category_outlined,
        value: formProvider.categoryId,
        items: formProvider.categoriesDropdown.map((DropdownValueModel value) {
          return DropdownMenuItem<String>(
            value: value.value,
            child: Text(value.text),
          );
        }).toList(),
        onChanged: (value) {
          formProvider.sizeValue = null;
          formProvider.surfaceValue = null;
          formProvider.categoryId = value;
          formProvider.loadDropdown(value!);
        },
      ),
      'precio': CustomInput(
        initialValue: formProvider.price,
        onChanged: (value) => formProvider.price = value,
        keyboardType: TextInputType.number,
        hintText: 'Precio general',
        icon: Icons.attach_money_outlined,
      ),
      'tamaño': CustomDropdown(
        hintText: 'Seleccione Tamaño',
        icon: FontAwesomeIcons.ruler,
        value: formProvider.sizeValue,
        items: formProvider.sizeDropdown.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) => formProvider.sizeValue = value,
      ),
      'periodo': CustomDropdown(
        hintText: 'Seleccione Periodo',
        icon: Icons.timer_outlined,
        value: formProvider.period,
        items: formProvider.periodDropdown.map((DropdownValueModel value) {
          return DropdownMenuItem<String>(
            value: value.value,
            child: Text(value.text),
          );
        }).toList(),
        onChanged: (value) => formProvider.period = value!,
      ),
      'superficie': CustomDropdown(
        hintText: 'Seleccione Superficie',
        icon: Icons.layers_outlined,
        value: formProvider.surfaceValue,
        items: formProvider.surfaceDropdown.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) => formProvider.surfaceValue = value,
      ),
    };
    return Container(
      color: const Color(0xffF2F2F2),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formProvider.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _BuilWideContent(form, tab2!);
              } else {
                return _BuilNormalContent(form);
              }
            }),
          ),
        ),
      ),
    );
  }
}

class _Prices extends StatelessWidget {
  const _Prices({
    Key? key,
    this.isShrinkWrap = false,
    this.color = const Color(0xffF2F2F2),
  }) : super(key: key);

  final bool isShrinkWrap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final dynamicPriceProvider = Provider.of<DynamicPriceProvider>(context);
    final courtProvider = Provider.of<CourtService>(context, listen: false);

    if (courtProvider.court != null) {
      if (courtProvider.court!.openDays != null) {
        dynamicPriceProvider.loadApplicableDays(courtProvider.court!.openDays!);
      }
    }
    return Center(
      child: Container(
        color: color,
        child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: isShrinkWrap,
            children: [
              CardPrice(
                title: 'Hora baja',
                switchValue: dynamicPriceProvider.isActiveBaja,
                onSwitchChanged: (value) =>
                    dynamicPriceProvider.isActiveBaja = value,
                fromValue: dynamicPriceProvider.fromBaja,
                toValue: dynamicPriceProvider.toBaja,
                onConfirmFrom: (Picker picker, List value) {
                  DateTime? datePicked =
                      (picker.adapter as DateTimePickerAdapter).value;
                  if (datePicked != null) {
                    int hour = datePicked.hour;
                    int min = datePicked.minute;
                    dynamicPriceProvider.fromBaja =
                        FormatHelper.convertTime(hour, min);
                  }
                },
                onConfirmTo: (Picker picker, List value) {
                  DateTime? datePicked =
                      (picker.adapter as DateTimePickerAdapter).value;
                  if (datePicked != null) {
                    int hour = datePicked.hour;
                    int min = datePicked.minute;
                    dynamicPriceProvider.toBaja =
                        FormatHelper.convertTime(hour, min);
                  }
                },
                priceValue: dynamicPriceProvider.priceBaja,
                onPriceChanged: (value) =>
                    dynamicPriceProvider.priceBaja = value,
                items: dynamicPriceProvider.applicableDays,
                onConfirmDays: (value) =>
                    dynamicPriceProvider.applicableDaysBaja = value,
                initialValueDays: dynamicPriceProvider.applicableDaysBaja,
              ),
              CardPrice(
                title: 'Hora Media',
                switchValue: dynamicPriceProvider.isActiveMedia,
                onSwitchChanged: (value) =>
                    dynamicPriceProvider.isActiveMedia = value,
                fromValue: dynamicPriceProvider.fromMedia,
                toValue: dynamicPriceProvider.toMedia,
                onConfirmFrom: (Picker picker, List value) {
                  DateTime? datePicked =
                      (picker.adapter as DateTimePickerAdapter).value;
                  if (datePicked != null) {
                    int hour = datePicked.hour;
                    int min = datePicked.minute;
                    dynamicPriceProvider.fromMedia =
                        FormatHelper.convertTime(hour, min);
                  }
                },
                onConfirmTo: (Picker picker, List value) {
                  DateTime? datePicked =
                      (picker.adapter as DateTimePickerAdapter).value;
                  if (datePicked != null) {
                    int hour = datePicked.hour;
                    int min = datePicked.minute;
                    dynamicPriceProvider.toMedia =
                        FormatHelper.convertTime(hour, min);
                  }
                },
                priceValue: dynamicPriceProvider.priceMedia,
                onPriceChanged: (value) =>
                    dynamicPriceProvider.priceMedia = value,
                items: dynamicPriceProvider.applicableDays,
                onConfirmDays: (value) =>
                    dynamicPriceProvider.applicableDaysMedia = value,
                initialValueDays: dynamicPriceProvider.applicableDaysMedia,
              ),
              CardPrice(
                title: 'Hora Alta',
                switchValue: dynamicPriceProvider.isActiveAlta,
                onSwitchChanged: (value) =>
                    dynamicPriceProvider.isActiveAlta = value,
                fromValue: dynamicPriceProvider.fromAlta,
                toValue: dynamicPriceProvider.toAlta,
                onConfirmFrom: (Picker picker, List value) {
                  DateTime? datePicked =
                      (picker.adapter as DateTimePickerAdapter).value;
                  if (datePicked != null) {
                    int hour = datePicked.hour;
                    int min = datePicked.minute;
                    dynamicPriceProvider.fromAlta =
                        FormatHelper.convertTime(hour, min);
                  }
                },
                onConfirmTo: (Picker picker, List value) {
                  DateTime? datePicked =
                      (picker.adapter as DateTimePickerAdapter).value;
                  if (datePicked != null) {
                    int hour = datePicked.hour;
                    int min = datePicked.minute;
                    dynamicPriceProvider.toAlta =
                        FormatHelper.convertTime(hour, min);
                  }
                },
                priceValue: dynamicPriceProvider.priceAlta,
                onPriceChanged: (value) =>
                    dynamicPriceProvider.priceAlta = value,
                items: dynamicPriceProvider.applicableDays,
                onConfirmDays: (value) =>
                    dynamicPriceProvider.applicableDaysAlta = value,
                initialValueDays: dynamicPriceProvider.applicableDaysAlta,
              )
            ]),
      ),
    );
  }
}

class _BuilWideContent extends StatelessWidget {
  const _BuilWideContent(this.form, this.tab2, {Key? key}) : super(key: key);

  final Map<String, Widget> form;
  final Widget tab2;

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
              child: form['tamaño']!,
            ),
            const SizedBox(width: 20),
            Flexible(
              child: form['superficie']!,
            ),
          ],
        ),
        const SizedBox(height: 30),
        form['periodo']!,
        const SizedBox(height: 30),
        tab2
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
        form['nombre_cancha']!,
        form['categoria']!,
        form['superficie']!,
        form['tamaño']!,
        form['periodo']!,
        form['precio']!,
        const SizedBox(height: 30),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<PitchesFormProvider>(context);
    return Text(
      formProvider.id != null ? 'Editar Cancha' : 'Agregar Cancha',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
