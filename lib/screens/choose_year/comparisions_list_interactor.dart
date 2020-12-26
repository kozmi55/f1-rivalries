import 'package:f1_stats_app/db/comparisions_table.dart';
import 'package:f1_stats_app/screens/choose_year/comparisions_list_view_state.dart';
import 'package:f1_stats_app/utils/service_locator.dart';

class ComparisionsListInteractor {
  final ComparisionsTable _comparisionsTable = locator<ComparisionsTable>();

  Future<ComparisionsListViewState> getRecentComparisions() async {
    final recentComparisionList = await _comparisionsTable.getRecentComparisions();
    final favoritesList = await _comparisionsTable.getFavoriteComparisions();


    final List<ComparisionListItem> comparisionList = [
      if (recentComparisionList.isNotEmpty) HeaderItem("Recent Searches"),
      ...recentComparisionList,
      if (favoritesList.isNotEmpty) HeaderItem("Favorite Searches"),
      ...favoritesList
    ];

    return ComparisionsListViewState(comparisionList);
  }
}
