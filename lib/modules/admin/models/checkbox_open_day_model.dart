import 'package:court_finder/modules/admin/models/checkbox_value_model.dart';

class CheckboxOpenDayModel extends CheckboxValueModel {
  CheckboxOpenDayModel(super.name,
      {this.from = '', this.to = '', required super.id});

  String from;
  String to;
}
