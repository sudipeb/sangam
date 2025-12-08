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
  //shows all the posts of the different users
  static const String postFeeds = "api/v1/post/feeds";
  static const String editPost = "api/v1/post/edit/";
  static const String allPost = "api/v1/post/all";
  static const String likePost = "api/v1/post/like/post_id";
  static const String unlikePost = "api/v1/post/unlike/post_id";
  static const String commentPost = "api/v1/post/comment/post_id";
  static const String deletePost = "api/v1/post/delete/post_id";
}

///Username:sudipkoirala@gmail.com
///password:SudipKoirala000@#
///bearer token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5MzI1MDllMDUwOTk4Yjc1MjIzNmU4NCIsImp0aSI6IjRhOTBkODdiLTNiNGYtNDhmMS05YzRlLTc3NTQwMzU5OWEyNSIsImVtYWlsIjoic3VkaXBrb2lyYWxhQGdtYWlsLmNvbSIsImlhdCI6MTc2NTE2NDc5NywiZXhwIjoxNzY1MjUxMTk3fQ.AfZcmjCvU0pMEV59v2b07rRiMXLh-j67WvGIJzFTGpg

///username:sushantkhadka@gmail.com
///password:SushantKhadka@1234
///