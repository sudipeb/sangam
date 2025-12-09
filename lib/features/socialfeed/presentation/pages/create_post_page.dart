import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sangam/core/di/service_locator.dart';
import 'package:sangam/features/socialfeed/presentation/blocs/create_post_bloc.dart';
import 'package:sangam/features/socialfeed/presentation/blocs/create_post_event.dart';
import 'package:sangam/features/socialfeed/presentation/blocs/create_post_state.dart';

class CreatePostPageClean extends StatefulWidget {
  const CreatePostPageClean({super.key});

  @override
  State<CreatePostPageClean> createState() => _CreatePostPageCleanState();
}

class _CreatePostPageCleanState extends State<CreatePostPageClean> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _imageController = TextEditingController();
  // Notifier to hold picked image
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final path = pickedFile.path;
        _imageNotifier.value = File(path);
        _imageController.text = path;
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CreatePostBloc>().add(
        CreatePostRequested(
          title: _title.text.trim(),
          description: _description.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreatePostBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Post')),
        body: BlocListener<CreatePostBloc, CreatePostState>(
          listener: (context, state) {
            if (state is CreatePostSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post created successfully!')),
              );
              Navigator.of(context).pop();
            } else if (state is CreatePostFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Please enter a title'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Please enter a description'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo, color: Colors.deepOrange),
                    label: const Text(
                      'Pick Image',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color.fromARGB(255, 109, 47, 224),
                    ),
                  ),
                  BlocBuilder<CreatePostBloc, CreatePostState>(
                    builder: (context, state) {
                      if (state is CreatePostLoading) {
                        return const CircularProgressIndicator();
                      }

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _submit(context),
                          child: const Text('Create Post'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
