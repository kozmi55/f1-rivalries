import 'package:f1_stats_app/screens/choose_year/comparisions_list_view_state.dart';

class ComparisionsListInteractor {
  Future<ComparisionsListViewState> getRecentComparisions() async {

    final List<ComparisionListItem> comparisionList = [

    ];

    return ComparisionsListViewState(comparisionList);
  }
}
