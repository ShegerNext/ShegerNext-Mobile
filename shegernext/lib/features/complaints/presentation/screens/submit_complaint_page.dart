import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shegernext/core/component/bottom_nav_bar.dart';
import 'package:shegernext/features/complaints/presentation/bloc/complaints_bloc.dart';
import 'package:shegernext/features/complaints/presentation/screens/%20cloud_helper.dart';

class SubmitComplaintPage extends StatefulWidget {
  const SubmitComplaintPage({super.key, this.initialCategory});

  final String? initialCategory;

  @override
  State<SubmitComplaintPage> createState() => _SubmitComplaintPageState();
}

class _SubmitComplaintPageState extends State<SubmitComplaintPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String? _imageUrl; // set after Supabase upload
  String? _localImagePath; // local path captured via camera
  double? _latitude;
  double? _longitude;

  @override
  void dispose() {
    _descriptionController.dispose();
    _categoryController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      _categoryController.text = widget.initialCategory!;
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    String? imageUrl;
    if (_localImagePath != null) {
      imageUrl = await CloudinaryHelper.uploadImage(File(_localImagePath!));
      if (imageUrl == null) {
        // Handle upload error (show a message, etc.)
        return;
      }
    }

    context.read<ComplaintsBloc>().add(
      SubmitComplaintEvent(
        text: _descriptionController.text.trim(),
        category: _categoryController.text.trim(),
        latitude: _latitude,
        longitude: _longitude,
        imageUrl: imageUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Complaint'), centerTitle: true),
      body: BlocConsumer<ComplaintsBloc, ComplaintsState>(
        listener: (BuildContext context, ComplaintsState state) {
          if (state is ComplaintSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Complaint submitted')),
            );
            Navigator.of(context).pop();
          }
          if (state is ComplaintSubmitError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (BuildContext context, ComplaintsState state) {
          final bool loading = state is ComplaintSubmitting;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _SectionCard(
                    title: 'Describe the problem',
                    child: TextFormField(
                      controller: _descriptionController,
                      minLines: 4,
                      maxLines: 8,
                      validator: (String? v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                      decoration: _filledDecoration(
                        context,
                        hint: 'Describe the issue in detail...',
                        icon: Icons.edit_outlined,
                      ),
                    ),
                  ),
                  _SectionCard(
                    title: 'Category (optional)',
                    child: TextFormField(
                      controller: _categoryController,
                      decoration: _filledDecoration(
                        context,
                        hint: 'e.g. Road, Water, Electricity',
                        icon: Icons.category_outlined,
                      ),
                    ),
                  ),
                  _SectionCard(
                    title: 'Photo (optional)',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        if (_localImagePath != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(_localImagePath!),
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? photo = await picker.pickImage(
                              source: ImageSource.camera,
                              preferredCameraDevice: CameraDevice.rear,
                              imageQuality: 85,
                              maxWidth: 1600,
                            );
                            if (photo != null) {
                              setState(() => _localImagePath = photo.path);
                              // TODO: upload to Supabase and set _imageUrl
                            }
                          },
                          icon: const Icon(Icons.photo_camera_outlined),
                          label: const Text('Take Photo'),
                        ),
                      ],
                    ),
                  ),
                  _SectionCard(
                    title: 'Location',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          controller: _locationController,
                          readOnly: true,
                          decoration: _filledDecoration(
                            context,
                            hint: 'Use the button to set your location',
                            icon: Icons.place_outlined,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: loading
                              ? null
                              : () async {
                                  final bool serviceEnabled =
                                      await Geolocator.isLocationServiceEnabled();
                                  if (!serviceEnabled) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Location services are disabled.',
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  LocationPermission permission =
                                      await Geolocator.checkPermission();
                                  if (permission == LocationPermission.denied) {
                                    permission =
                                        await Geolocator.requestPermission();
                                  }
                                  if (permission == LocationPermission.denied ||
                                      permission ==
                                          LocationPermission.deniedForever) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Location permission denied',
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  final Position pos =
                                      await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high,
                                      );
                                  setState(() {
                                    _latitude = pos.latitude;
                                    _longitude = pos.longitude;
                                    _locationController.text =
                                        '${pos.latitude.toStringAsFixed(5)}, ${pos.longitude.toStringAsFixed(5)}';
                                  });
                                },
                          icon: const Icon(Icons.my_location),
                          label: const Text('Use Current Location'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: loading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF661AFF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      loading ? 'Submitting...' : 'Submit Complaint',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

InputDecoration _filledDecoration(
  BuildContext context, {
  required String hint,
  IconData? icon,
}) {
  return InputDecoration(
    prefixIcon: icon != null ? Icon(icon) : null,
    hintText: hint,
    filled: true,
    fillColor: Theme.of(
      context,
    ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
  );
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final TextStyle? caption = Theme.of(
      context,
    ).textTheme.labelLarge?.copyWith(color: Colors.black54);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(title, style: caption),
          ),
          child,
        ],
      ),
    );
  }
}
