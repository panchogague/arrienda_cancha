import 'package:court_finder/modules/admin/providers/providers.dart';
import 'package:court_finder/modules/admin/widgets/widgets.dart';
import 'package:court_finder/modules/auth/services/auth_services.dart';
import 'package:court_finder/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPitchesScreen extends StatelessWidget {
  const MyPitchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Mis Canchas',
      floatingAction: FloatingActionButton(
        onPressed: () {
          final formProvider =
              Provider.of<PitchesFormProvider>(context, listen: false);
          formProvider.cleanValues();
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const FractionallySizedBox(
                  heightFactor: 0.9, child: PitchForm());
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      child: const _MyPitches(),
    );
  }
}

class _MyPitches extends StatelessWidget {
  const _MyPitches({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pitchService = Provider.of<PitchService>(context);
    final pitches = pitchService.pitches;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Canchas',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        const SizedBox(height: 10),
        Expanded(
            child: Center(
          child: SizedBox(
            width: 600,
            child: ListView.builder(
              itemBuilder: (_, i) => PitchCard(pitches[i]),
              itemCount: pitches.length,
            ),
          ),
        ))
      ],
    );
  }
}
