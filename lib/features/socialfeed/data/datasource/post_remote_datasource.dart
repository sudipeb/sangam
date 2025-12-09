import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sangam/core/constants/api_constants.dart';
import 'package:sangam/core/network/api_client.dart';
import 'package:sangam/features/socialfeed/data/models/post_model.dart';
import 'package:sangam/features/socialfeed/data/models/post_model_response.dart';

class PostRemoteDataSource {
  /// Instance of [ApiClient] to make network requests
  final ApiClient apiClient = ApiClient();

  /// Create a new post. Returns CreatePostResponseModel on success.
  Future<CreatePostResponseModel> createPost({
    required String title,
    required String description,
    String? image,
  }) async {
    try {
      final Response response;

      if (image != null && image.isNotEmpty) {
        // Use multipart form data when image is provided
        debugPrint('Creating post with image: $image');

        final formData = FormData.fromMap({
          'title': title,
          'description': description,
          'image': await MultipartFile.fromFile(
            image,
            filename: image.split('/').last,
          ),
        });

        debugPrint('Creating post with multipart data');

        response = await apiClient.postMultipart(
          ApiEndpoints.createPost,
          data: formData,
        );
      } else {
        // Use regular JSON data when no image
        final data = {'title': title, 'description': description};

        // debugPrint('Creating post with data: $data');

        response = await apiClient.post(ApiEndpoints.createPost, data: data);
      }

      // debugPrint('Create post response: ${response.data}');

      if (response.data == null) {
        throw Exception('Empty response from server');
      }

      // Transform the post data in the response before creating the model
      final responseData = Map<String, dynamic>.from(response.data);
      if (responseData['post'] != null) {
        final postData = responseData['post'] as Map<String, dynamic>;
        final transformedPost = _transformPostData(postData);
        responseData['post'] = transformedPost.toJson();
      }

      return CreatePostResponseModel.fromJson(responseData);
    } catch (e) {
      debugPrint('Error creating post: $e');
      throw Exception('Failed to create post: $e');
    }
  }

  /// Fetch posts for feed. Returns list of PostModel objects.
  Future<List<PostModel>> fetchFeeds({int page = 1, int limit = 20}) async {
    try {
      debugPrint('Fetching feeds with page: $page, limit: $limit');

      final response = await apiClient.get(
        ApiEndpoints.postFeeds,
        queryParameters: {'page': page, 'limit': limit},
      );

      debugPrint('Feeds response: ${response.data}');

      if (response.data == null) {
        throw Exception('Empty response from server');
      }

      // Handle different possible response structures
      if (response.data['postFeedsWithComments'] != null) {
        // Structure: {message: "...", postFeedsWithComments: [...], paginationInfo: {...}}
        final postsRaw =
            response.data['postFeedsWithComments'] as List<dynamic>;
        return postsRaw
            .map((e) => _transformPostData(e as Map<String, dynamic>))
            .toList();
      } else if (response.data['posts'] != null) {
        // Structure: {posts: [...]}
        final postsRaw = response.data['posts'] as List<dynamic>;
        return postsRaw
            .map((e) => _transformPostData(e as Map<String, dynamic>))
            .toList();
      } else if (response.data['post'] != null) {
        // Single post: {message: "...", post: {...}}
        final post = _transformPostData(
          response.data['post'] as Map<String, dynamic>,
        );
        return [post];
      } else {
        debugPrint('No posts found in response structure');
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching feeds: $e');
      if (e.toString().contains('timeout')) {
        throw Exception(
          'Server is taking too long to respond. Please try again later.',
        );
      } else if (e.toString().contains('connection')) {
        throw Exception(
          'Unable to connect to server. Please check your internet connection.',
        );
      } else {
        throw Exception('Failed to fetch feeds: $e');
      }
    }
  }

  /// Fetch all posts. Returns list of PostModel objects.
  Future<List<PostModel>> fetchAllPosts({int page = 1, int limit = 20}) async {
    try {
      debugPrint('Fetching all posts with page: $page, limit: $limit');

      final response = await apiClient.get(
        ApiEndpoints.allPost,
        queryParameters: {'page': page, 'limit': limit},
      );

      debugPrint('All posts response: ${response.data}');

      if (response.data == null) {
        throw Exception('Empty response from server');
      }

      // Handle different possible response structures
      if (response.data['posts'] != null) {
        final postsData = response.data['posts'];

        // Check if posts is an object containing postsWithComments
        if (postsData is Map<String, dynamic> &&
            postsData['postsWithComments'] != null) {
          final postsRaw = postsData['postsWithComments'] as List<dynamic>;
          return postsRaw
              .map((e) => _transformPostData(e as Map<String, dynamic>))
              .toList();
        }
        // Check if posts is a direct array
        else if (postsData is List<dynamic>) {
          return postsData
              .map((e) => _transformPostData(e as Map<String, dynamic>))
              .toList();
        }
      } else if (response.data['postFeedsWithComments'] != null) {
        // Handle case where allPosts returns same structure as feeds
        final postsRaw =
            response.data['postFeedsWithComments'] as List<dynamic>;
        return postsRaw
            .map((e) => _transformPostData(e as Map<String, dynamic>))
            .toList();
      } else if (response.data['post'] != null) {
        // Single post: {message: "...", post: {...}}
        final post = _transformPostData(
          response.data['post'] as Map<String, dynamic>,
        );
        return [post];
      }

      debugPrint('No posts found in all posts response');
      return [];
    } catch (e) {
      debugPrint('Error fetching all posts: $e');
      throw Exception('Failed to fetch all posts: $e');
    }
  }

  /// Fetch ALL posts from all pages. Returns complete list of PostModel objects.
  Future<List<PostModel>> fetchAllPostsPaginated() async {
    final List<PostModel> allPosts = [];
    int currentPage = 1;
    const int limit = 20; // Adjust based on your backend's pagination limit
    bool hasMorePages = true;

    try {
      while (hasMorePages) {
        debugPrint('Fetching page $currentPage of all posts');

        final response = await apiClient.get(
          ApiEndpoints.allPost,
          queryParameters: {'page': currentPage, 'limit': limit},
        );

        debugPrint('All posts page $currentPage response: ${response.data}');

        if (response.data == null) {
          break;
        }

        List<PostModel> pagePosts = [];

        // Handle different possible response structures
        if (response.data['posts'] != null) {
          final postsData = response.data['posts'];

          // Check if posts is an object containing postsWithComments
          if (postsData is Map<String, dynamic> &&
              postsData['postsWithComments'] != null) {
            final postsRaw = postsData['postsWithComments'] as List<dynamic>;
            pagePosts = postsRaw
                .map((e) => _transformPostData(e as Map<String, dynamic>))
                .toList();
          }
          // Check if posts is a direct array
          else if (postsData is List<dynamic>) {
            pagePosts = postsData
                .map((e) => _transformPostData(e as Map<String, dynamic>))
                .toList();
          }
        } else if (response.data['postFeedsWithComments'] != null) {
          // Handle case where allPosts returns same structure as feeds
          final postsRaw =
              response.data['postFeedsWithComments'] as List<dynamic>;
          pagePosts = postsRaw
              .map((e) => _transformPostData(e as Map<String, dynamic>))
              .toList();
        }

        // Check pagination info to determine if there are more pages
        if (response.data['paginationInfo'] != null) {
          final paginationInfo =
              response.data['paginationInfo'] as Map<String, dynamic>;
          hasMorePages = paginationInfo['hasNextPage'] == true;
          debugPrint(
            'Pagination info: hasNextPage = ${paginationInfo['hasNextPage']}, currentPage = ${paginationInfo['currentPage']}, totalPages = ${paginationInfo['totalPages']}',
          );
        } else {
          // If no pagination info, check if we got fewer posts than the limit
          hasMorePages = pagePosts.length == limit;
        }

        allPosts.addAll(pagePosts);
        currentPage++;

        // Safety check to prevent infinite loops
        if (currentPage > 100) {
          debugPrint(
            'Warning: Reached maximum page limit (100), stopping pagination',
          );
          break;
        }

        // If no posts were returned, stop pagination
        if (pagePosts.isEmpty) {
          hasMorePages = false;
        }
      }

      debugPrint(
        'Fetched total ${allPosts.length} posts from $currentPage pages',
      );
      return allPosts;
    } catch (e) {
      debugPrint('Error fetching all posts paginated: $e');
      throw Exception('Failed to fetch all posts: $e');
    }
  }

  /// Like a post by post ID
  Future<bool> likePost(String postId) async {
    try {
      debugPrint('Liking post: $postId');

      final endpoint = ApiEndpoints.likePost.replaceAll('post_id', postId);
      final response = await apiClient.post(endpoint);

      debugPrint('Like post response: ${response.data}');

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('Error liking post: $e');
      throw Exception('Failed to like post: $e');
    }
  }

  /// Unlike a post by post ID
  Future<bool> unlikePost(String postId) async {
    try {
      debugPrint('Unliking post: $postId');

      final endpoint = ApiEndpoints.unlikePost.replaceAll('post_id', postId);
      final response = await apiClient.post(endpoint);

      debugPrint('Unlike post response: ${response.data}');

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('Error unliking post: $e');
      throw Exception('Failed to unlike post: $e');
    }
  }

  /// Add a comment to a post
  Future<bool> commentOnPost(String postId, String comment) async {
    try {
      debugPrint('Commenting on post: $postId with comment: $comment');

      final endpoint = ApiEndpoints.commentPost.replaceAll('post_id', postId);
      final data = {'comment': comment};

      final response = await apiClient.post(endpoint, data: data);

      debugPrint('Comment post response: ${response.data}');

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('Error commenting on post: $e');
      throw Exception('Failed to comment on post: $e');
    }
  }

  /// Edit an existing post
  Future<PostModel> editPost({
    required String postId,
    required String title,
    required String description,
    String? image,
  }) async {
    try {
      final endpoint = '${ApiEndpoints.editPost}$postId';
      final Response response;

      if (image != null && image.isNotEmpty) {
        // Use multipart form data when image is provided
        debugPrint('Editing post $postId with image: $image');

        final formData = FormData.fromMap({
          'title': title,
          'description': description,
          'image': await MultipartFile.fromFile(
            image,
            filename: image.split('/').last,
          ),
        });

        debugPrint('Editing post with multipart data');

        response = await apiClient.putMultipart(endpoint, data: formData);
      } else {
        // Use regular JSON data when no image
        final data = {'title': title, 'description': description};

        debugPrint('Editing post $postId with data: $data');

        response = await apiClient.put(endpoint, data: data);
      }

      debugPrint('Edit post response: ${response.data}');

      if (response.data == null || response.data['post'] == null) {
        throw Exception('Invalid edit post response');
      }

      return _transformPostData(response.data['post'] as Map<String, dynamic>);
    } catch (e) {
      debugPrint('Error editing post: $e');
      throw Exception('Failed to edit post: $e');
    }
  }

  /// Delete a post by post ID
  Future<bool> deletePost(String postId) async {
    try {
      debugPrint('Deleting post: $postId');

      final endpoint = ApiEndpoints.deletePost.replaceAll('post_id', postId);
      final response = await apiClient.delete(endpoint);

      debugPrint('Delete post response: ${response.data}');

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      debugPrint('Error deleting post: $e');
      throw Exception('Failed to delete post: $e');
    }
  }

  /// Transform post data to handle different API response structures
  PostModel _transformPostData(Map<String, dynamic> postData) {
    try {
      // Create a copy of the post data to modify
      final transformedData = Map<String, dynamic>.from(postData);

      // Map _id to id for PostModel.fromJson() compatibility
      if (transformedData['_id'] != null) {
        transformedData['id'] = transformedData['_id'];
      }

      // Handle userInfo field first (priority over userId object)
      if (transformedData['userInfo'] is Map<String, dynamic>) {
        final userInfoObj = transformedData['userInfo'] as Map<String, dynamic>;
        transformedData['userinfo'] = {
          'id': userInfoObj['_id'] ?? '',
          'name': userInfoObj['name'] ?? 'Unknown User',
        };
      }
      // Handle userId field - extract the _id if it's an object and create userinfo
      else if (transformedData['userId'] is Map<String, dynamic>) {
        final userIdObj = transformedData['userId'] as Map<String, dynamic>;
        // Create userinfo object from the userId object
        transformedData['userinfo'] = {
          'id': userIdObj['_id'] ?? '',
          'name': userIdObj['name'] ?? 'Unknown User',
        };
        // Set userId to just the _id for compatibility
        transformedData['userId'] = userIdObj['_id'] ?? '';
      } else {
        // If userId is just a string, create a minimal userinfo
        // This handles cases like create post response where userId is not expanded
        if (transformedData['userId'] != null &&
            transformedData['userinfo'] == null) {
          transformedData['userinfo'] = {
            'id': transformedData['userId'],
            'name': 'Unknown User',
          };
        }
      }

      // Ensure userId is a string (extract from userInfo if needed)
      if (transformedData['userInfo'] is Map<String, dynamic> &&
          transformedData['userId'] == null) {
        final userInfoObj = transformedData['userInfo'] as Map<String, dynamic>;
        transformedData['userId'] = userInfoObj['_id'] ?? '';
      }

      // Ensure required fields have safe default values
      transformedData['id'] = transformedData['id'] ?? '';
      transformedData['title'] = transformedData['title'] ?? '';
      transformedData['description'] = transformedData['description'] ?? '';
      transformedData['userId'] = transformedData['userId'] ?? '';
      transformedData['image'] = transformedData['image']; // Can be null
      transformedData['likesCount'] = transformedData['likesCount'] ?? 0;
      transformedData['commentsCount'] = transformedData['commentsCount'] ?? 0;
      transformedData['createdAt'] =
          transformedData['createdAt'] ?? DateTime.now().toIso8601String();
      transformedData['updatedAt'] =
          transformedData['updatedAt'] ?? DateTime.now().toIso8601String();

      debugPrint('Transformed post data: $transformedData');

      return PostModel.fromJson(transformedData);
    } catch (e) {
      debugPrint('Error transforming post data: $e');
      debugPrint('Original post data: $postData');
      rethrow;
    }
  }
}
