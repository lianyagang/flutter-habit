import 'dart:convert' as Convert; //数据转化库

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:habit/flutter/base/base_model_widget.dart';
import 'package:habit/flutter/base/base_widget.dart';
import 'package:habit/flutter/widget/base_model.dart';
import 'package:habit_example/global/global_user.dart';
import 'package:provider/provider.dart';

import 'RemarkRefreshViewModel.dart';

class RemarkRefreshPage extends StatelessWidget {
  static final String sName = "RemarkRefreshPage";
  final String userName;

  RemarkRefreshPage(this.userName, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RemarkRefreshViewModel>(
      viewModel: RemarkRefreshViewModel(BaseModel()),
      onModelReady: (model) => model.initialise(context),
      child: _RemarkRefreshView(userName),
    );
  }
}

class _RemarkRefreshView extends BaseModelWidget<RemarkRefreshViewModel> {
  final String userName;

  _RemarkRefreshView(this.userName);

  @override
  Widget build(BuildContext context, RemarkRefreshViewModel model) {
    return Container(
      child: EasyRefresh.custom(
        firstRefresh: true,
        enableControlFinishRefresh: false,
        enableControlFinishLoad: true,
        controller: model.controller,
        header: ClassicalHeader(),
        footer: ClassicalFooter(),
        onRefresh: () async {
          model.onRefresh(context);
        },
        onLoad: () async {
          String data =
              '{"name":"$userName","accessToken":"123","mobile":"456"}';
          Map<String, dynamic> userInfo = Convert.jsonDecode(
              data); //转化数据，我自己写的用户数据是标准的JSON，但是还是需要toString之后在jsonDecode
          Provider.of<UserInfo>(context, listen: true).setInfo(userInfo);
          model.onLoad(context);
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Row(
                  children: <Widget>[
                    Image.network(
                      model.data[index].img,
                      width: 80,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      child: Text(model.data[index].title),
                    )
                  ],
                );
              },
              childCount: model.count,
            ),
          ),
        ],
      ),
    );
  }
}
