class ApiConstants {
  static const String baseUrl =
      'https://social-media-backend-2nw5.onrender.com/';
}

class ApiEndpoints {
  ///Authentication Endpoints
  static const String register = "api/v1/auth/register";
  static const String login = "api/v1/auth/login";
  static const String profile = "api/v1/auth/profile";
  static const String refreshToken = "api/v1/auth/refresh-token";
  static const String forgotPassword = "api/v1/auth/forgot-password";
  static const String resetPassword = "api/v1/auth/reset-password";

  ///Post Endpoints
  static const String createPost = "api/v1/post/create";
  static const String postFeeds = "api/v1/post/feeds";
  static const String editPost = "api/v1/post/edit";
  static const String allPost = "api/v1/post/all";
}

///Username:sudipkoirala@gmail.com
///password:SudipKoirala000@#