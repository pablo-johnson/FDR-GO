import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

class CustomLoadMoreDelegate extends LoadMoreDelegate {
  double _loadMoreIndicatorSize = 33.0;

  @override
  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.chinese}) {
    String text = builder(status);
    if (status == LoadMoreStatus.fail) {
      return Container(
        child: Text(text),
      );
    }
    if (status == LoadMoreStatus.idle) {
      return Text(text);
    }
    if (status == LoadMoreStatus.loading) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: _loadMoreIndicatorSize,
              height: _loadMoreIndicatorSize,
              child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text),
            ),
          ],
        ),
      );
    }
    if (status == LoadMoreStatus.nomore) {
      return Container(
        height: 0.0,
      );
    }

    return Text(text);
  }
}
