
const String kBaseUrl = "student.valuxapps.com";
const String kBaseVersion = 'api/';

// end points
const String kLogin = 'login';
const String kRegister = 'register';
const String kLogOut = 'logout';
const String kProfile = 'profile';
const String kUpdateProfile = 'update-profile';
const String kChangePassword = 'change-password';

//Static Headers
 Map<String, String> apiHeaders = {
  "Content-Type": "application/json",
  "Accept": "application/json, text/plain, */*",
  "X-Requested-With": "XMLHttpRequest",
};