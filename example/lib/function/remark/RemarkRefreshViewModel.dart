import 'dart:convert' as Convert; //数据转化库

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:habit/flutter/constant_config.dart';
import 'package:habit/flutter/local/local_storage.dart';
import 'package:habit/flutter/utils/sp_utils/sp_constant.dart';
import 'package:habit/flutter/widget/base_model.dart';
import 'package:habit/flutter/widget/base_view_model.dart';
import 'package:habit_example/function/remark/entity/remark_resp_list_entity.dart';
import 'package:habit_example/global/global_user.dart';
import 'package:provider/provider.dart';
import 'package:habit/flutter/utils/sp_utils/sp_constant.dart';
import 'package:habit/flutter/utils/sp_utils/sp_utils.dart';

class RemarkRefreshViewModel extends BaseViewModel {
  EasyRefreshController controller;
  int count = 0;
  List<RemarkRespListEntity> data = [];

  RemarkRefreshViewModel(BaseModel model) : super(model);

  initialise(BuildContext _context) {
    controller = EasyRefreshController();
    getUserInfo(_context); //初始化项目，获取本地缓存的用户数据
  }

  getUserInfo(BuildContext _context) async {
    var authorization = SpUtils.getString(SpConstants.authorization);
    var mapUserInfo =
        Convert.jsonDecode(authorization); //转化成Map<String Dynamic>类型
    Provider.of<UserInfo>(_context, listen: true).setInfo(mapUserInfo);
  }

  var asStream;

  Future<void> onRefresh(BuildContext context) async {
    asStream =
        CancelableOperation.fromFuture(Future.delayed(Duration(seconds: 1), () {
      print('onRefresh');
      data.clear();
      data.add(RemarkRespListEntity(
          'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1473836766,4030812874&fm=26&gp=0.jpg',
          '1'));
      data.add(RemarkRespListEntity(
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604773951186&di=deab5fb24440500ba47ef31c2fdf1e23&imgtype=0&src=http%3A%2F%2Fa0.att.hudong.com%2F30%2F29%2F01300000201438121627296084016.jpg',
          '2'));
      data.add(RemarkRespListEntity(
          'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1473836766,4030812874&fm=26&gp=0.jpg',
          '3'));
      data.add(RemarkRespListEntity(
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604773951186&di=527c0ee73f3b2968df470294ae8b0179&imgtype=0&src=http%3A%2F%2Fa4.att.hudong.com%2F52%2F52%2F01200000169026136208529565374.jpg',
          '4'));
      data.add(RemarkRespListEntity(
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604773951186&di=527c0ee73f3b2968df470294ae8b0179&imgtype=0&src=http%3A%2F%2Fa4.att.hudong.com%2F52%2F52%2F01200000169026136208529565374.jpg',
          '5'));
      data.add(RemarkRespListEntity(
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604773951186&di=54517e5cecee5c5c6f6a9a71ede9316f&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F55%2F22%2F20300000929429130630222900050.jpg',
          '6'));
      data.add(RemarkRespListEntity(
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604773951186&di=e5a56288cb6f6c103967e538f05cc422&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F13%2F41%2F01300000201800122190411861466.jpg',
          '7'));
      data.add(RemarkRespListEntity(
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604773951186&di=e5a56288cb6f6c103967e538f05cc422&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F13%2F41%2F01300000201800122190411861466.jpg',
          '8'));
      data.add(RemarkRespListEntity(
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604773951186&di=e5a56288cb6f6c103967e538f05cc422&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F13%2F41%2F01300000201800122190411861466.jpg',
          '9'));
      data.add(RemarkRespListEntity(
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604773951186&di=e5a56288cb6f6c103967e538f05cc422&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F13%2F41%2F01300000201800122190411861466.jpg',
          '10'));
      count = data.length;
      controller.resetLoadState();
      notifyListeners();
    }));
    // var loginForgetReq = LoginReqForgetPwdEntity()
    //   ..loginName = 'text'
    //   ..organizeType = '3';
    // var result = await apiService.request<LoginRespEntity>(
    //     context, ForgetPassWordApiService.FORGETURL,
    //     queryParameters: loginForgetReq.toJson(),
    //     showLoadingIndicator: true,
    //     ignoreToast: false);
  }

  void onLoad(BuildContext context) {
    // await Future.delayed(Duration(seconds: 2), () {
    //   print('onLoad');
    //   data.add(RemarkRespListEntity(
    //       'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604773951185&di=60e76de5765b56bdb97d6628746e7274&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201507%2F23%2F20150723232238_3Ydci.jpeg',
    //       (count++).toString()));
    //
    //   count = data.length;
    //   controller.finishLoad(noMore: count >= 40);
    //   notifyListeners();
    // });
  }

  @override
  void dispose() {
    super.dispose();
    asStream.cancel();
  }
}
