import 'package:f1_stats_app/screens/choose_year/recent_comparision_view_state.dart';
import 'package:f1_stats_app/screens/choose_year/recent_comparisions_interactor.dart';
import 'package:f1_stats_app/screens/choose_year/saved_comparision_row.dart';
import 'package:f1_stats_app/utils/loading_indicator.dart';
import 'package:f1_stats_app/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecentComparisionsView extends StatefulWidget {
  RecentComparisionsView({Key key}) : super(key: key);

  @override
  _RecentComparisionsViewState createState() => _RecentComparisionsViewState();
}

class _RecentComparisionsViewState extends State<RecentComparisionsView> {
  Future<RecentComparisionsViewState> _recentComparisionsViewStateFuture;

  RecentComparisionsInteractor get _interactor => locator<RecentComparisionsInteractor>();

  @override
  Widget build(BuildContext context) {
    if (_recentComparisionsViewStateFuture == null) {
      _recentComparisionsViewStateFuture = _interactor.getRecentComparisions();
    }

    return FutureBuilder(
      future: _recentComparisionsViewStateFuture,
      builder: (context, AsyncSnapshot<RecentComparisionsViewState> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(color: Theme.of(context).scaffoldBackgroundColor, child: LoadingIndicator());
        }

        if (snapshot.hasError || snapshot.data == null) {
          return SizedBox.shrink();
        } else {
          return _recentComparisionsBody(snapshot.data);
        }
      },
    );
  }

  Widget _recentComparisionsBody(RecentComparisionsViewState data) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: data.recentComparisions.length,
        itemBuilder: (context, index) {
          final item = data.recentComparisions[index];
          return SavedComparisionRow(driverComparision: item);
        });
  }
}
