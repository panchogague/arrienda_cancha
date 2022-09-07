import 'package:court_finder/modules/admin/providers/providers.dart';
import 'package:court_finder/modules/admin/widgets/court_form.dart';
import 'package:court_finder/modules/admin/widgets/widgets.dart';
import 'package:court_finder/modules/auth/services/services.dart';
import 'package:court_finder/services/services.dart';
import 'package:flutter/material.dart';
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
            CourtForm(),
          ],
        ),
      ),
    );
  }
}
