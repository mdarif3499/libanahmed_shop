import 'package:ahmed_shop/screens/ownerScreen/profileScreen/profileHome/model/profile_setting_model.dart';
import 'package:ahmed_shop/services/repository/owner_profile_repository/owner_profle_repository.dart';
import 'package:get/get.dart';

class OwnerProfileSettingsController  extends GetxController{
  // Reactive variables
  var settings = Rxn<OwnerProfileSettingsModel>(); 
  var isLoading = false.obs; 
  var errorMessage = ''.obs; 

  @override

  void onInit() {
    super.onInit();
    fetchSettings(); 
  }

  // Method to fetch settings using the repository
  Future<void> fetchSettings() async {
    try {
      isLoading(true);
      errorMessage('');
      final profileSettings = await OwnerProfleRepository.fetchSettings();

      if (profileSettings != null && profileSettings.success == true) {
        settings.value = profileSettings;
      } else {
        errorMessage('Failed to load settings: No data received');
      }
    } catch (e) {
      errorMessage('Error fetching settings: $e');
    } finally {
      isLoading(false);
    }
  }

  // Method to refresh settings
  Future<void> refreshSettings() async {
    await fetchSettings();
  }
}