import 'package:court_finder/modules/admin/providers/providers.dart';
import 'package:court_finder/modules/admin/widgets/widgets.dart';
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
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ChangeNotifierProvider(
                  create: (_) => PitchesFormProvider(),
                  child: const PitchForm());
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
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Canchas',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SizedBox(height: 10),
          _ListPitches()
        ],
      ),
    );
  }
}

class _ListPitches extends StatelessWidget {
  const _ListPitches({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: double.infinity,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'Nombre',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Categoría',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Tamaño',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Precio',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Cancha 1')),
              DataCell(Text('Futbol')),
              DataCell(Text('6v6')),
              DataCell(Text(r'$ 4.500')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Cancha 2')),
              DataCell(Text('Futbol')),
              DataCell(Text('11v11')),
              DataCell(Text(r'$ 35.500')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Cancha Tenis')),
              DataCell(Text('Tenis')),
              DataCell(Text('2v2')),
              DataCell(Text(r'$ 10.500')),
            ],
          ),
        ],
      ),
    );
  }
}
