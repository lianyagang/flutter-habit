import 'package:flutter/material.dart';
import 'package:habit/habit.dart';
import 'package:habit/flutter/base/property/empty_state_model.dart';
import 'package:habit/flutter/constants/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'app_match_btn.dart';
import 'base/base_appbar_widget.dart';
import 'base_view_model.dart';

class BaseEmptyStateWidget<VM extends BaseViewModel> extends StatelessWidget {

  /// 设置ToolBar
  final Widget toolBar;

  BaseEmptyStateWidget({this.toolBar});


  @override
  Widget build(BuildContext context) {
    var baseModel = Provider.of<VM>(context, listen: false);
    if (baseModel.mState == EmptyState.PROGRESS) {
      return Container(
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: color99000000,
                  ),
                  child: SizedBox(
                      width: 110.px,
                      height: 110.px,
                      child: Lottie.asset(
                        baseModel.loadingAsset ??
                            "assets/json/lottie_loading.json",
                        fit: BoxFit.contain,
                        package: baseModel.resPackage,
                      )),
                )
              ], //.where((element) => element != null).toList(),
            ),
          ),
        ),
      );
    } else if (baseModel.mState == EmptyState.EMPTY ||
        baseModel.mState == EmptyState.NET_ERROR) {
      return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: toolBar??!baseModel.hideStateToolBar
              ? _providerEmptyToolBar(baseModel)
              : null,
          body: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: (baseModel.marginTop.value).px,
                  ),
                  child: Image(
                    image: AssetImage(baseModel.emptyIconRes,
                        package: baseModel.resPackage),
                    width: 160.px,
                    height: 160.px,
                  ),
                ),
                baseModel.currentStateLabel != null
                    ? Container(
                        margin: EdgeInsets.only(
                          top: 10.px,
                        ),
                        child: Text(
                          baseModel.currentStateLabel,
                          style: TextStyle(
                            color: color333333,
                            fontSize: 18.px,
                          ),
                        ),
                      )
                    : Container(
                        width: 0,
                        height: 0,
                      ),
                baseModel.currentNotifyStateLabel != null
                    ? Container(
                        margin: EdgeInsets.only(
                          top: 10.px,
                        ),
                        child: Text(
                          baseModel.currentNotifyStateLabel ?? '',
                          style: TextStyle(
                            color: color999999,
                            fontSize: 14.px,
                          ),
                        ),
                      )
                    : Container(
                        width: 0,
                        height: 0,
                      ),
                baseModel.showReload
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: 20.px,
                          top: 31.px,
                          right: 20.px,
                        ),
                        child: buildMatchParentButton(
                          btnTitle: baseModel.reloadStr,
                          btnHeight: 34.0.px,
                          btnRadius: 4.px,
                          btnTitleSp: 14.0.px,
                          onPressed: () {
                            baseModel.onReloadData();
                          },
                          color: color_FFA22D,
                        ))
                    : Container(
                        width: 0,
                        height: 0,
                      )
              ],
            ),
          ));
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }

  Widget _providerEmptyToolBar(VM baseModel){
    baseModel.setAppBarBgColor(Colors.white);
    baseModel.setAppBarBackIconColor(Colors.black);
    return AppBarWidget(baseModel);
  }


}
