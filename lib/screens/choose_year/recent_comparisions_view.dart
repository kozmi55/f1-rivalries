import 'package:f1_stats_app/screens/choose_year/recent_comparision_view_state.dart';
import 'package:f1_stats_app/screens/choose_year/recent_comparisions_interactor.dart';
import 'package:f1_stats_app/screens/choose_year/saved_comparision_row.dart';
import 'package:f1_stats_app/utils/loading_indicator.dart';
import 'package:f1_stats_app/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecentComparisionsView extends StatefulWidget {
  RecentComparisionsView({Key key, this.shouldRefreshList = false}) : super(key: key);

  final bool shouldRefreshList;

  @override
  _RecentComparisionsViewState createState() => _RecentComparisionsViewState();
}

class _RecentComparisionsViewState extends State<RecentComparisionsView> {
  Future<RecentComparisionsViewState> _recentComparisionsViewStateFuture;

  RecentComparisionsInteractor get _interactor => locator<RecentComparisionsInteractor>();

  @override
  Widget build(BuildContext context) {
    if (_recentComparisionsViewStateFuture == null || widget.shouldRefreshList) {
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
    return Column(
      children: [
        if (data.recentComparisions.isNotEmpty) _recentComparisionsHeader(),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.recentComparisions.length,
            itemBuilder: (context, index) {
              final item = data.recentComparisions[index];
              return SavedComparisionRow(driverComparision: item, onPop: (value) => _updateState());
            }),
      ],
    );
  }

  Widget _recentComparisionsHeader() {
    return Column(children: [
      Container(
        alignment: Alignment.bottomLeft,
        child: Text('Recent Searches',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0), textAlign: TextAlign.start),
        margin: EdgeInsets.only(bottom: 4.0, left: 4.0),
      ),
      Container(
        height: 1.0,
        color: Colors.black26,
        margin: EdgeInsets.only(bottom: 16.0, left: 4.0, right: 4.0),
      )
    ]);
  }

  void _updateState() {
    setState(() => _recentComparisionsViewStateFuture = null);
  }
}
