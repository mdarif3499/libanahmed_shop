import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/profileHome/model/profile_setting_model.dart';
import 'package:ahmed_shop/services/api/api_services.dart';

class OwnerProfleRepository {
  static Future<OwnerProfileSettingsModel?> fetchSettings() async {
    try {
      var response = await ApiServices.instance
          .apiGetServices(ApiUrls.instance.ownerProfileSettings);
      if (response != null) {
        return OwnerProfileSettingsModel.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
