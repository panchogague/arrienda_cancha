import 'package:court_finder/modules/admin/providers/providers.dart';
import 'package:court_finder/modules/admin/widgets/widgets.dart';
import 'package:court_finder/modules/auth/services/services.dart';
import 'package:court_finder/services/services.dart';
import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CourtProfileScreen extends StatelessWidget {
  const CourtProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourtProfileProvider(),
      child: const CustomScaffold(
          title: 'Perfil Recinto',
          floatingAction: _SubmitButton(),
          child: _CourtProfile()),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courtForm = Provider.of<CourtProfileProvider>(context);
    return FloatingActionButton(
      onPressed: courtForm.isLoading
          ? null
          : () async {
              FocusScope.of(context).unfocus();
              if (!courtForm.isValidForm()) return;

              courtForm.isLoading = true;
              final authService =
                  Provider.of<AuthService>(context, listen: false);

              final resp = await courtForm
                  .createOrUpdateCourt(authService.userLogin!.userId!);

              if (resp != null) {
                NotificationService.showSnackbar(resp);
              } else {
                NotificationService.showSnackbar('Datos guardados con éxito');
              }

              courtForm.isLoading = false;
            },
      child: courtForm.isLoading
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : const Icon(Icons.save),
    );
  }
}

class _CourtProfile extends StatelessWidget {
  const _CourtProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courtForm = Provider.of<CourtProfileProvider>(context, listen: false);
    final auth = Provider.of<AuthService>(context, listen: false);
    if (auth.userLogin!.adminCourts.isNotEmpty) {
      courtForm.initialize(auth.userLogin!.adminCourts[0]);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Información del recinto',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(height: 10),
            _FormCourtProfile(),
          ],
        ),
      ),
    );
  }
}

class _FormCourtProfile extends StatelessWidget {
  const _FormCourtProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courtForm = Provider.of<CourtProfileProvider>(context);
    return Form(
      key: courtForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Flexible(
                  child: CustomInput(
                initialValue: courtForm.court.name,
                onChanged: (value) => courtForm.court.name = value,
                hintText: 'Nombre del recinto',
                icon: FontAwesomeIcons.addressCard,
              )),
              const SizedBox(width: 20),
              Flexible(
                child: CustomInput(
                  initialValue: courtForm.court.location,
                  onChanged: (value) => courtForm.court.location = value,
                  hintText: 'Ubicación',
                  icon: Icons.location_on_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Flexible(
                child: CustomInput(
                  initialValue: courtForm.court.howToAccess,
                  onChanged: (value) => courtForm.court.howToAccess = value,
                  keyboardType: TextInputType.multiline,
                  maxLine: 5,
                  hintText: 'Cómo llegar',
                  icon: FontAwesomeIcons.key,
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: CustomInput(
                  initialValue: courtForm.court.cancellationPolicy,
                  onChanged: (value) =>
                      courtForm.court.cancellationPolicy = value,
                  keyboardType: TextInputType.multiline,
                  maxLine: 5,
                  hintText: 'Política de cancelación',
                  icon: Icons.cancel_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          CustomInput(
            initialValue: courtForm.court.description,
            onChanged: (value) => courtForm.court.description = value,
            keyboardType: TextInputType.multiline,
            maxLine: 5,
            hintText: 'Descripción del recinto',
            icon: Icons.description_outlined,
          ),
          const SizedBox(height: 30),
          const _SelectArea(),
        ],
      ),
    );
  }
}

class _SelectArea extends StatelessWidget {
  const _SelectArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return (size.width > 850.0)
        ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Expanded(child: _OpenDays()),
            SizedBox(width: 30),
            Expanded(child: _Facilities())
          ])
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [_OpenDays(), SizedBox(height: 10), _Facilities()]);
  }
}

class _OpenDays extends StatelessWidget {
  const _OpenDays({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courtForm = Provider.of<CourtProfileProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff264653).withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Días abiertos'),
          const SizedBox(height: 10),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: courtForm.daysOfWeeks.length,
            itemBuilder: (_, i) => CheckboxListTile(
              title: Text(courtForm.daysOfWeeks[i].name),
              value: courtForm.daysOfWeeks[i].value,
              onChanged: (value) => courtForm.checkDaysOfWeek(value!, i),
            ),
          ),
        ],
      ),
    );
  }
}

class _Facilities extends StatelessWidget {
  const _Facilities({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courtForm = Provider.of<CourtProfileProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff264653).withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Facilidades'),
          const SizedBox(height: 10),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: courtForm.facilities.length,
            itemBuilder: (_, i) => CheckboxListTile(
              title: Text(courtForm.facilities[i].name),
              value: courtForm.facilities[i].value,
              onChanged: (value) => courtForm.checkFacilities(value!, i),
            ),
          ),
        ],
      ),
    );
  }
}
