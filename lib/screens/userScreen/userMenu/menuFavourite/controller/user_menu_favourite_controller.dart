import 'package:ahmed_shop/screens/userScreen/userMenu/menuFavourite/models/user_menu_favourite_model.dart';
import 'package:ahmed_shop/services/repository/product_repository/product_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:get/get.dart';

class UserMenuFavouriteController extends GetxController {
  RxBool isFavourite = false.obs;
  var favouriteItem = Rxn<UserMenuFavouriteModel>();

  @override
  void onInit() {
    super.onInit();
  }

  void fetchAllFavourite() async {
    try {
      isFavourite(true);
      final result = await ProductRepository.fetchAllFavouriteProducts();
      if (result != null) {
        favouriteItem.value = result;
        AppSnackBar.success("Data Fetch Successfully");
      } else {
        favouriteItem.value = null;
        appLog("There is nothing to be added here");
      }
    } catch (e) {
      appLog("Error is showing in : $e");
    } finally {
      isFavourite(false);
    }
  }
}
