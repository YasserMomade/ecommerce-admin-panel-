import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/category.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';


class SubCategoryProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addSubCategoryFormKey = GlobalKey<FormState>();
  TextEditingController subCategoryNameCtrl = TextEditingController();
  Category? selectedCategory;
  SubCategory? subCategoryForUpdate;




  SubCategoryProvider(this._dataProvider);


  //TODO: should complete addSubCategory


  addSubcategory() async{

    try {

      Map<String, dynamic> subCategories = {
        'name': subCategoryNameCtrl.text,
        'categoryId': selectedCategory?.sId,
      };

      final response = await service.addItem(endpointUrl: 'subCategories', itemData: subCategories);

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if(apiResponse.success == true){
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllSubcategory();
          log('Sub Ccategory added');
        }else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add Sub Category: ${apiResponse.message}');
        }
      }else{
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e){
      print(e);
      SnackBarHelper.showErrorSnackBar('An error ocurred: $e');
      rethrow;
    }

  }


  //TODO: should complete updateSubCategory

  updateSubCategory() async {
    try{

      if(subCategoryForUpdate != null){
      Map<String, dynamic> subCategory = {
        'name': subCategoryNameCtrl,
        'categoryId': selectedCategory?.sId,

      };

      final response = await service.updateItem(endpointUrl: 'subCategories', itemData: subCategory, itemId: subCategoryForUpdate?.sId ?? '');

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if(apiResponse.success == true){
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllcategory();
          log('Sub Category Updated Sucessfully');
        }else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to update Sub category: ${apiResponse.message}');
        }
      }else{
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusText}');
      }
      }
    } catch (e){
      print(e);
      SnackBarHelper.showErrorSnackBar('An error ocurred: $e');
      rethrow;
    }

  }


  submitcategory() {
    if(subCategoryForUpdate != null){
      updateSubCategory();
    }else{
      addSubcategory();
    }
  }


  //TODO: should complete deleteSubCategory


  setDataForUpdateSubCategory(SubCategory? subCategory) {
    if (subCategory != null) {
      subCategoryForUpdate = subCategory;
      subCategoryNameCtrl.text = subCategory.name ?? '';
      selectedCategory = _dataProvider.categories.firstWhereOrNull((element) => element.sId == subCategory.categoryId?.sId);
    } else {
      clearFields();
    }
  }

  clearFields() {
    subCategoryNameCtrl.clear();
    selectedCategory = null;
    subCategoryForUpdate = null;
  }

  updateUi(){
    notifyListeners();
  }
}
