import 'package:f1_stats_app/screens/choose_year/comparisions_list_view_state.dart';
import 'package:f1_stats_app/screens/choose_year/comparisions_list_interactor.dart';
import 'package:f1_stats_app/screens/choose_year/saved_comparision_row.dart';
import 'package:f1_stats_app/utils/loading_indicator.dart';
import 'package:f1_stats_app/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ComparisionsListView extends StatefulWidget {
  ComparisionsListView({Key key, this.shouldRefreshList = false}) : super(key: key);

  final bool shouldRefreshList;

  @override
  _ComparisionsListViewState createState() => _ComparisionsListViewState();
}

class _ComparisionsListViewState extends State<ComparisionsListView> {
  Future<ComparisionsListViewState> _recentComparisionsViewStateFuture;

  ComparisionsListInteractor get _interactor => locator<ComparisionsListInteractor>();

  @override
  Widget build(BuildContext context) {
    if (_recentComparisionsViewStateFuture == null || widget.shouldRefreshList) {
      _recentComparisionsViewStateFuture = _interactor.getRecentComparisions();
    }

    return FutureBuilder(
      future: _recentComparisionsViewStateFuture,
      builder: (context, AsyncSnapshot<ComparisionsListViewState> snapshot) {
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

  Widget _recentComparisionsBody(ComparisionsListViewState data) {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.recentComparisions.length,
            itemBuilder: (context, index) {
              final item = data.recentComparisions[index];
              if (item is HeaderItem) {
                return _recentComparisionsHeader(item.title);
              } else {
                return SavedComparisionRow(driverComparision: item as DriverComparision, onPop: (value) => _updateState());
              }
            }),
      ],
    );
  }

  Widget _recentComparisionsHeader(String title) {
    return Column(children: [
      Container(
        alignment: Alignment.bottomLeft,
        child: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0), textAlign: TextAlign.start),
        margin: EdgeInsets.only(top: 16.0, bottom: 4.0, left: 4.0),
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
