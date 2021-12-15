import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/home_request.dart';
import 'package:flutter_bilibili/model/home_mo.dart';

class HomeDao {
  static get(String categoryName, {int pageIndex = 1, int pageSize = 1}) async {
    HomeRequest request = HomeRequest();
    request.pathParams = categoryName;
    request.add("pageIndex", pageIndex);
    request.add("pageSize", pageSize);
    var result = await HiNet().fire(request);
    print('HomeDao get responese:$result');
    return HomeMo.fromJson(result['data']);
  }
}
