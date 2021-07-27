import 'package:estaciona_mais/app/features/home/data/models/dashboard_model.dart';

abstract class DashboardDataSource {
  Future<DashBoardModel> getDashboard();
}
