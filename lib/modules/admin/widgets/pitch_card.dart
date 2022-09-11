import 'package:court_finder/helpers/show_alert_helper.dart';
import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/admin/providers/providers.dart';
import 'package:court_finder/modules/admin/widgets/widgets.dart';
import 'package:court_finder/modules/auth/services/services.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:court_finder/services/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PitchCard extends StatelessWidget {
  const PitchCard(this.model, {Key? key}) : super(key: key);

  final PitchModel model;

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<PitchesFormProvider>(context);
    final pitchService = Provider.of<PitchService>(context);
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.category!,
                    style: Theme.of(context).textTheme.subtitle1),
                const Divider(),
                Text(
                  model.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 10),
                IconText(
                    text: 'Tamaño: ${model.size}',
                    style: Theme.of(context).textTheme.subtitle2,
                    icon: Icon(
                      FontAwesomeIcons.ruler,
                      color: Theme.of(context).primaryColor,
                      size: 15,
                    )),
                const SizedBox(height: 5),
                IconText(
                    text: 'Superficie: ${model.surface}',
                    style: Theme.of(context).textTheme.subtitle2,
                    icon: Icon(
                      Icons.layers_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    )),
                const Divider(),
                Row(
                  children: [
                    MaterialButton(
                        minWidth: 10,
                        onPressed: () {
                          formProvider.setValues(model);
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return const FractionallySizedBox(
                                  heightFactor: 0.9, child: PitchForm());
                            },
                          );
                        },
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 1,
                        child: const Icon(
                          Icons.edit_note_outlined,
                          color: Colors.white,
                        )),
                    const SizedBox(width: 20),
                    MaterialButton(
                        minWidth: 10,
                        onPressed: () {
                          //TODO: validar que no existan bookings asociados a la cancha a borrar
                          ShowConfirmHelper(
                              title: 'Por favor, confirme',
                              subtitle: formProvider.isLoading
                                  ? 'Borrando...'
                                  : '¿Estas seguro de querer borrar esta cancha?',
                              onPressed: () async {
                                final navigator = Navigator.of(context);
                                final courtService = Provider.of<CourtService>(
                                    context,
                                    listen: false);
                                final resp = await formProvider.deletePitch(
                                    courtService.court!, model.id!);
                                navigator.pop();
                                if (resp != null) {
                                  NotificationService.showSnackbar(resp);
                                } else {
                                  pitchService.refreshGrid();
                                  NotificationService.showSnackbar(
                                      'Cancha eliminada con éxito');
                                }
                              }).showAlert(context);

                          if (formProvider.isLoading) {}
                        },
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 1,
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        )),
                    const Spacer(),
                    Text(model.priceFormated,
                        style: Theme.of(context).textTheme.bodyText1),
                    Text('/ ${model.periodFormated}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
