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
      final data = {
        'title': title,
        'description': description,
        if (image != null && image.isNotEmpty) 'image': image,
      };

      debugPrint('Creating post with data: $data');

      final response = await apiClient.post(
        ApiEndpoints.createPost,
        data: data,
      );

      debugPrint('Create post response: ${response.data}');

      if (response.data == null) {
        throw Exception('Empty response from server');
      }

      return CreatePostResponseModel.fromJson(response.data);
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
      throw Exception('Failed to fetch feeds: $e');
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

      // Handle response structure
      if (response.data['posts'] != null) {
        final postsRaw = response.data['posts'] as List<dynamic>;
        return postsRaw
            .map((e) => _transformPostData(e as Map<String, dynamic>))
            .toList();
      } else {
        debugPrint('No posts found in all posts response');
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching all posts: $e');
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
      final data = {
        'title': title,
        'description': description,
        if (image != null && image.isNotEmpty) 'image': image,
      };

      debugPrint('Editing post $postId with data: $data');

      final endpoint = '${ApiEndpoints.editPost}$postId';
      final response = await apiClient.put(endpoint, data: data);

      debugPrint('Edit post response: ${response.data}');

      if (response.data == null || response.data['post'] == null) {
        throw Exception('Invalid edit post response');
      }

      return PostModel.fromJson(response.data['post']);
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

      // Handle userId field - extract the _id if it's an object
      if (transformedData['userId'] is Map<String, dynamic>) {
        final userIdObj = transformedData['userId'] as Map<String, dynamic>;
        transformedData['userId'] = userIdObj['_id'] ?? '';
      }

      // Ensure required fields have safe default values
      transformedData['_id'] = transformedData['_id'] ?? '';
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
