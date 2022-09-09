import 'package:court_finder/modules/admin/providers/providers.dart';
import 'package:court_finder/modules/admin/widgets/widgets.dart';
import 'package:court_finder/modules/auth/services/auth_services.dart';
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
            context: context,
            builder: (BuildContext context) {
              return const PitchForm();
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
    final authService = Provider.of<AuthService>(context);
    final pitches = authService.userLogin!.adminCourts[0].pitches;
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

// class _ListPitches extends StatelessWidget {
//   const _ListPitches({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(5),
//       width: double.infinity,
//       child: DataTable(
//         columns: const <DataColumn>[
//           DataColumn(
//             label: Expanded(
//               child: Text(
//                 'Nombre',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           DataColumn(
//             label: Expanded(
//               child: Text(
//                 'Categoría',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           DataColumn(
//             label: Expanded(
//               child: Text(
//                 'Tamaño',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           DataColumn(
//             label: Expanded(
//               child: Text(
//                 'Superficie',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           DataColumn(
//             label: Expanded(
//               child: Text(
//                 'Precio',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//         rows: _getPitches(context),
//       ),
//     );
//   }

//   List<DataRow> _getPitches(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);
//     final pitches = authService.userLogin!.adminCourts[0].pitches;
//     return pitches.map((e) {
//       return DataRow(cells: [
//         DataCell(Text(e.name)),
//         DataCell(Text(e.category!)),
//         DataCell(Text(e.surface!)),
//         DataCell(Text(e.size!)),
//         DataCell(Text(e.priceFormated)),
//       ]);
//     }).toList();
//   }
// }
