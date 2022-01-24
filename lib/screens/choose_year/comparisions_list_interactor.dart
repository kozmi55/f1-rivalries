import 'package:f1_stats_app/db/comparisions_cache.dart';
import 'package:f1_stats_app/screens/choose_year/comparisions_list_view_state.dart';
import 'package:f1_stats_app/utils/service_locator.dart';

class ComparisionsListInteractor {
  final ComparisionsCache _comparisionsCache = locator<ComparisionsCache>();

  Future<ComparisionsListViewState> getRecentComparisions() async {
    final recentComparisionList = await _comparisionsCache.getRecentComparisions();
    final favoritesList = await _comparisionsCache.getFavoriteComparisions();


    final List<ComparisionListItem> comparisionList = [
      if (recentComparisionList.isNotEmpty) HeaderItem("Recent Searches"),
      ...recentComparisionList,
      if (favoritesList.isNotEmpty) HeaderItem("Favorite Searches"),
      ...favoritesList
    ];

    return ComparisionsListViewState(comparisionList);
  }
}
