import 'package:ahmed_shop/screens/userScreen/profileScreen/profileHome/models/user_profile_settings_model.dart';
import 'package:ahmed_shop/services/repository/profile_repository/profile_repository.dart';
import 'package:get/get.dart';

class UserProfileSettingsController  extends GetxController{
  // Reactive variables
  var settings = Rxn<UserProfileSettingsModel>(); 
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
      final profileSettings = await ProfileRepository.fetchSettings();

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