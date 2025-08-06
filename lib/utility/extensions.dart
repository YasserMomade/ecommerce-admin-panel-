
import 'package:provider/provider.dart';

import '../core/data/data_provider.dart';
import '../screens/category/provider/category_provider.dart';
import '../screens/main/provider/main_screen_provider.dart';
import 'package:flutter/cupertino.dart';



extension Providers on BuildContext {
  DataProvider get dataProvider => Provider.of<DataProvider>(this, listen: false);
  MainScreenProvider get mainScreenProvider => Provider.of<MainScreenProvider>(this, listen: false);

}