import 'package:ahmed_shop/screens/userScreen/profileScreen/profileHome/models/user_profile_model.dart';
import 'package:ahmed_shop/services/repository/profile_repository/profile_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  // Reactive variables to store profile data
  var isLoading = true.obs;
  var profileData = Rxn<ProfileGetModel>(); // Rxn for nullable ProfileGetModel
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // Method to fetch user profile
  Future<void> fetchProfile() async {
    try {
      isLoading(true);
      errorMessage('');
      
      final response = await ProfileRepository.fetchUserProfile();
      
      if (response != null && response.success == true) {
        profileData.value = response;
      } else {
        errorMessage.value = response?.message ?? 'Failed to load profile data';
        appLog('Profile fetch failed: ${errorMessage.value}');
      }
    } catch (e) {
      errorMessage.value = 'Error loading profile: $e';
      appLog('Profile fetch error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Getter methods for easy access to profile data
  String get fullName => profileData.value?.data?.fullName ?? 'N/A';
  String get email => profileData.value?.data?.email ?? 'N/A';
  String get phone => profileData.value?.data?.phone ?? 'N/A';
  String get address => profileData.value?.data?.address ?? 'N/A';
  String get image => profileData.value?.data?.image ?? '';
  String get role => profileData.value?.data?.role ?? 'N/A';
  bool get isActive => profileData.value?.data?.isActive ?? false;
}