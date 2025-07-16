import 'package:ahmed_shop/screens/ownerScreen/profileScreen/profileHome/model/profile_model.dart';
import 'package:ahmed_shop/services/repository/owner_profile_repository/owner_profle_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';

class OwnerProfileController extends GetxController {
  var profileData = Rxn<OwnerProfileModel>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void fetchProfile() async {
    try {
      isLoading(true);
      errorMessage('');

      final profiledata = await OwnerProfleRepository.fetchProfile();

      if (profiledata != null) {
        profileData.value = profiledata;
        appLog("Profile data fetched successfully");
        appLog(profileData.value?.toRawJson());
      } else {
        errorMessage('No profile data found');
        appLog("No data found");
      }
    } catch (e) {
      errorMessage('Failed to fetch profile: ${e.toString()}');
      appLog("Error fetching profile: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  void refreshProfile() {
    fetchProfile();
  }

}