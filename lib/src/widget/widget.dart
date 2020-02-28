import 'package:bank_account_kata_flutter/src/listener/onClickListener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomCardItemList extends StatelessWidget {
  CustomCardItemList(
      {@required this.child,
        this.marginTop,
        this.marginRight,
        this.marginLeft,
        this.marginBottom,
        this.height,
        this.width,
        this.onClickListener,
        this.modelId,
        this.modelData,
        this.enableClick,
        this.index})
      : assert(child != null);

  double marginTop;
  double marginRight;
  double marginBottom;
  double marginLeft;
  double height;
  double width;
  Widget child;

  //Handle click event
  OnClickListener onClickListener;
  String modelId;
  var modelData;
  bool enableClick;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(
          top: marginTop != null ? marginTop : 0.0,
          right: marginRight != null ? marginRight : 0.0,
          bottom: marginBottom != null ? marginBottom : 0.0,
          left: marginLeft != null ? marginLeft : 0.0),
      child: GestureDetector(
          child: Card(child: child),
          onTap: () {
            if (onClickListener != null && enableClick) {
              onClickListener.onClick(modelId, modelData, index);
            } else {
              onClickListener.onClick("connotClick", null, null);
            }
          }),
    );
  }
}





class CustomItemList extends StatelessWidget {
  CustomItemList(
      {@required this.child,
        this.marginTop,
        this.marginRight,
        this.marginLeft,
        this.marginBottom,
        this.height,
        this.onClickListener,
        this.modelId,
        this.modelData,
        this.enableClick})
      : assert(child != null);

  double marginTop;
  double marginRight;
  double marginBottom;
  double marginLeft;
  double height;
  Widget child;

  //Handle click event
  OnClickListener onClickListener;
  String modelId;
  var modelData;
  bool enableClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.only(
          top: marginTop != null ? marginTop : 0.0,
          right: marginRight != null ? marginRight : 0.0,
          bottom: marginBottom != null ? marginBottom : 0.0,
          left: marginLeft != null ? marginLeft : 0.0),
      child: GestureDetector(
          child: child,
          onTap: () {
            if (onClickListener != null && enableClick) {
              onClickListener.onClick(modelId, modelData, null);
            } else {
              onClickListener.onClick("connotClick", null, null);
            }
          }),
    );
  }
}

