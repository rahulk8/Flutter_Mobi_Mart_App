import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://bmdublog.com/my_mobi_mart/api/customer/";

  // Sign Up API
  static Future<http.Response> signUp(String name, String phone, String password) {
    return http.post(
      Uri.parse("${baseUrl}sign-up"),
      body: {
        'name': name,
        'phone': phone,
        'password': password,
      },
    );
  }

  // Login API
  static Future<http.Response> login(String phone, String password) {
    return http.post(
      Uri.parse("${baseUrl}login"),
      body: {
        'phone': phone,
        'password': password,
      },
    );
  }

  // Logout API
  
    static Future<http.Response> logout() {
    return http.post(
    Uri.parse("${baseUrl}logout"),
    
  );

  }
}
