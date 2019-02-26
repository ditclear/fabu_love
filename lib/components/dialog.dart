import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showLoading(BuildContext c, LoadingDialog loading) => showDialog(
    context: c,
    barrierDismissible: false,
    builder: (BuildContext c) => loading);


class LoadingDialog extends CupertinoAlertDialog {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("返回了");
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Container(
              width: 120,
              height: 120,
              child: CupertinoPopupSurface(
                child: Semantics(
                  namesRoute: true,
                  scopesRoute: true,
                  explicitChildNodes: true,
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
