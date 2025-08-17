import 'package:admin/utility/snack_bar_helper.dart';

import '../../models/api_response.dart';
import '../../models/coupon.dart';
import '../../models/my_notification.dart';
import '../../models/order.dart';
import '../../models/poster.dart';
import '../../models/product.dart';
import '../../models/variant_type.dart';
import '../../services/http_services.dart';
//import '../../utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import '../../../models/category.dart';
import '../../models/brand.dart';
import '../../models/sub_category.dart';
import '../../models/variant.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];

  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;

  List<VariantType> _allVariantTypes = [];
  List<VariantType> _filteredVariantTypes = [];
  List<VariantType> get variantTypes => _filteredVariantTypes;

  List<Variant> _allVariants = [];
  List<Variant> _filteredVariants = [];
  List<Variant> get variants => _filteredVariants;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;

  List<Coupon> _allCoupons = [];
  List<Coupon> _filteredCoupons = [];
  List<Coupon> get coupons => _filteredCoupons;

  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;

  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;

  List<MyNotification> _allNotifications = [];
  List<MyNotification> _filteredNotifications = [];
  List<MyNotification> get notifications => _filteredNotifications;

  DataProvider() {
    getAllProduct();
    getAllcategory();
    getAllSubcategory();
    getAllBrands();
    getAllVariantType();
    getAllvariant();
    getAllPosters();
  }


  //getAllCategory

  Future<List<Category>> getAllcategory({bool showSnack = false}) async{

    try{
      Response response = await service.getItems(endpointUrl: 'categories');

      if(response.isOk){
        ApiResponse<List<Category>> apiResponse = ApiResponse<List<Category>>.fromJson(
          response.body,
            (json) => (json as List).map((item) => Category.fromJson(item)).toList(),
        );
        _allCategories = apiResponse.data ?? [];
        _filteredCategories = List.from(_allCategories);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }

    } catch(e){
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }

    return _filteredCategories;

  }

  //filterCategories

  void filterCategories(String keyword) {

    if(keyword.isEmpty){
      _filteredCategories = List.from(_allCategories);
    }else{
      final loweKeyword = keyword.toLowerCase();
      _filteredCategories = _allCategories.where((category){
        return (category.name ?? '').toLowerCase().contains(loweKeyword);
      }).toList();
    }
    notifyListeners();
  }

  // getAllSubCategory

  Future<List<SubCategory>> getAllSubcategory({bool showSnack = false}) async{

    try{
      Response response = await service.getItems(endpointUrl: 'subCategories');

      if(response.isOk){
        ApiResponse<List<SubCategory>> apiResponse = ApiResponse<List<SubCategory>>.fromJson(
          response.body,
              (json) => (json as List).map((item) => SubCategory.fromJson(item)).toList(),
        );
        _allSubCategories = apiResponse.data ?? [];
        _filteredSubCategories = List.from(_allSubCategories);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }

    } catch(e){
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredSubCategories;
  }

  //filterSubCategories

  void filterSubCategories(String keyword) {

    if(keyword.isEmpty){
      _filteredCategories = List.from(_allSubCategories);
    }else{
      final loweKeyword = keyword.toLowerCase();
      _filteredSubCategories = _allSubCategories.where((subcategory){
        return (subcategory.name ?? '').toLowerCase().contains(loweKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //getAllBrands

  Future<List<Brand>> getAllBrands({bool showSnack = false}) async{

    try{
      Response response = await service.getItems(endpointUrl: 'brands');

      if(response.isOk){
        ApiResponse<List<Brand>> apiResponse = ApiResponse<List<Brand>>.fromJson(
          response.body,
              (json) => (json as List).map((item) => Brand.fromJson(item)).toList(),
        );
        _allBrands = apiResponse.data ?? [];
        _filteredBrands = List.from(_allBrands);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch(e){
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }

    return _filteredBrands;

  }

  //filterBrands
  void filterBrands(String keyword) {

    if(keyword.isEmpty){
      _filteredBrands = List.from(_allBrands);
    }else{
      final loweKeyword = keyword.toLowerCase();
      _filteredBrands = _allBrands.where((brand){
        return (brand.name ?? '').toLowerCase().contains(loweKeyword);
      }).toList();
    }
    notifyListeners();
  }

  // getAllVariantType

  Future<List<VariantType>> getAllVariantType({bool showSnack = false}) async{

    try{
      Response response = await service.getItems(endpointUrl: 'variantTypes');

      if(response.isOk){
        ApiResponse<List<VariantType>> apiResponse = ApiResponse<List<VariantType>>.fromJson(
          response.body,
              (json) => (json as List).map((item) => VariantType.fromJson(item)).toList(),
        );
        _allVariantTypes = apiResponse.data ?? [];
        _filteredVariantTypes = List.from(_allVariantTypes);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch(e){
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredVariantTypes;
  }

  //filterVariantTypes

  void filterVariantTypes(String keyword) {

    if(keyword.isEmpty){
      _filteredVariantTypes = List.from(_allVariantTypes);
    }else{
      final loweKeyword = keyword.toLowerCase();
      _filteredVariantTypes = _allVariantTypes.where((variantType){
        return (variantType.name ?? '').toLowerCase().contains(loweKeyword);
      }).toList();
    }
    notifyListeners();
  }

  Future<List<Variant>>  getAllvariant({bool showSnack = false}) async{

    try{
      Response response = await service.getItems(endpointUrl: 'variants');

      if(response.isOk){
        ApiResponse<List<Variant>> apiResponse = ApiResponse<List<Variant>>.fromJson(
          response.body,
              (json) => (json as List).map((item) => Variant.fromJson(item)).toList(),
        );
        _allVariants = apiResponse.data ?? [];
        _filteredVariants = List.from(_allVariants);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch(e){
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredVariants;
  }

  //filterVariants
  void filterVariants(String keyword) {

    if(keyword.isEmpty){
      _filteredVariants = List.from(_allVariants);
    }else{
      final loweKeyword = keyword.toLowerCase();
      _filteredVariants = _allVariants.where((variant){
        return (variant.name ?? '').toLowerCase().contains(loweKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //getAllProduct

  Future<List<Product>>  getAllProduct({bool showSnack = false}) async{

    try{
      Response response = await service.getItems(endpointUrl: 'products');

      if(response.isOk){
        ApiResponse<List<Product>> apiResponse = ApiResponse<List<Product>>.fromJson(
          response.body,
              (json) => (json as List).map((item) => Product.fromJson(item)).toList(),
        );
        _allProducts= apiResponse.data ?? [];
        _filteredProducts = List.from(_allProducts);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch(e){
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredProducts;
  }

  //filterProducts
  void filterProducts(String keyword) {

    if(keyword.isEmpty){
      _filteredProducts = List.from(_allProducts);
    }else{
      final loweKeyword = keyword.toLowerCase();


      _filteredProducts = _allProducts.where((product){

        final productNameContainsKeyword =
        (product.name ?? '').toLowerCase().contains(loweKeyword);
        final categoryNameContainsKeyword =
            product.proCategoryId?.name?.toLowerCase().contains(loweKeyword) ?? false;
        final subCategoryNameContainsKeyword =
            product.proSubCategoryId?.name?.toLowerCase().contains(loweKeyword) ?? false;

        return productNameContainsKeyword || categoryNameContainsKeyword || subCategoryNameContainsKeyword;
      }).toList();
    }
    notifyListeners();
  }


  //TODO: should complete getAllCoupons


  //TODO: should complete filterCoupons

 //getAllPosters

  Future<List<Poster>> getAllPosters({bool showSnack = false}) async{

    try{
      Response response = await service.getItems(endpointUrl: 'posters');

      if(response.isOk){
        ApiResponse<List<Poster>> apiResponse = ApiResponse<List<Poster>>.fromJson(
          response.body,
              (json) => (json as List).map((item) => Poster.fromJson(item)).toList(),
        );
        _allPosters = apiResponse.data ?? [];
        _filteredPosters = List.from(_allPosters);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }

    } catch(e){
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }

    return _filteredPosters;

  }
  //filterPosters

  void filterPosters(String keyword) {

    if(keyword.isEmpty){
      _filteredPosters = List.from(_allPosters);
    }else{
      final loweKeyword = keyword.toLowerCase();
      _filteredPosters = _allPosters.where((poster){
        return (poster.posterName ?? '').toLowerCase().contains(loweKeyword);
      }).toList();
    }
    notifyListeners();
  }


  //TODO: should complete getAllNotifications


  //TODO: should complete filterNotifications


  //TODO: should complete getAllOrders


  //TODO: should complete filterOrders

  //TODO: should complete calculateOrdersWithStatus


  // filterProductsByQuantity

  void  filterProductsByQuantity(String productQntType) {

    if(productQntType == 'All product'){
      _filteredProducts = List.from(_allProducts);
    }
    else if (productQntType == 'Out of Stock'){
      _filteredProducts = _allProducts.where((product) {
        return product.quantity != null && product.quantity == 0;
      }).toList();
    }
    else if (productQntType == 'Limited Stock') {
      _filteredProducts = _allProducts.where((product) {
        return product.quantity != null && product.quantity == 1;
      }).toList();
    }
    else if (productQntType == 'Other Stock'){
      _filteredProducts = _allProducts.where((product) {
        return product.quantity != null && product.quantity != 0 && product.quantity != 1;
      }).toList();
    }else{
      _filteredProducts = List.from(_allProducts);
    }
    notifyListeners();
  }

  //calculateProductWithQuantity

int calculateProductWithQuantity({int? quantity }) {
  int totalProduct = 0;

  if (quantity == null) {
    totalProduct = _allProducts.length;
  }else{
    for(Product product in _allProducts) {
      if(product.quantity != null && product.quantity == quantity){
        totalProduct += 1;
      }
    }
  }
  return totalProduct;
}

}
