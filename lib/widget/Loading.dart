import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingModal extends StatelessWidget {

  Widget child;

  LoadingModal({this.child});


  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: true);
    return  ModalProgressHUD(
      child: child,
      inAsyncCall: gs.isHttpLoading,
      progressIndicator: CircularProgressIndicator(),
      opacity: 0.2,
    );
  }
}

Widget CustomLoading() {
  return Container(
    margin: EdgeInsets.all(15),
    child: SpinKitThreeBounce(
      color: Colors.white,
      size: 35.0,
    ),
  );
}