import 'package:f1_stats_app/db/comparisions_table.dart';
import 'package:f1_stats_app/screens/choose_year/recent_comparision_view_state.dart';
import 'package:f1_stats_app/utils/service_locator.dart';

class RecentComparisionsInteractor {
  final ComparisionsTable _comparisionsTable = locator<ComparisionsTable>();

  Future<RecentComparisionsViewState> getRecentComparisions() async {
    final comparisionList = await _comparisionsTable.getRecentComparisions();
    return RecentComparisionsViewState(comparisionList);
  }
}
