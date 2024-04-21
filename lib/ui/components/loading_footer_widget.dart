import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;
import '../../generated/l10n.dart';

refresh.CustomFooter CustomFooterWidget({double? horizontal, double? vertical}) {
  return refresh.CustomFooter(
    builder: (BuildContext context, refresh.LoadStatus? mode) {
      Widget body;
      if (mode == refresh.LoadStatus.idle) {
        body = Container() /*Text("pull up load")*/;
      } else if (mode == refresh.LoadStatus.loading) {
        body = Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: horizontal ?? 0, vertical: vertical ?? 0),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "${S.of(context).loading}..",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ));
      } else if (mode == refresh.LoadStatus.failed) {
        body = Container();
        /*Text("Load Failed! Click retry!")*/;
      } else if (mode == refresh.LoadStatus.canLoading) {
        body = Container() /*Text("release to load more")*/;
      } else {
        body = Container() /*Text("No more Data")*/;
      }
      return Container(
        child: Center(child: body),
      );
    },
  );
}
