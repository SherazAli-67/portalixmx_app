import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_app/core/validators/validators.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import '../../core/common_ui.dart';
import '../../core/res/app_colors.dart';
import '../../core/res/app_icons.dart';
import '../../core/res/app_textstyles.dart';
import '../widgets/app_textfield_widget.dart';
import '../widgets/primary_btn.dart';

class AddComplaintBottomSheet extends StatefulWidget{
  const AddComplaintBottomSheet({super.key});

  @override
  State<AddComplaintBottomSheet> createState() => _AddComplaintBottomSheetState();
}

class _AddComplaintBottomSheetState extends State<AddComplaintBottomSheet> {
  static const int _maxPhotos = 6;
  static const int _maxPhotoBytes = 5 * 1024 * 1024;
  final TextEditingController _complaintTextEditingController = TextEditingController();
  final List<XFile> _pickedImages =  [];
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _complaintTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Material(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 15,
                    children: [
                      Text(localization.complaint, style: AppTextStyles.bottomSheetHeadingTextStyle,),
                      const SizedBox(height: 10,),
                      AppTextField(
                        controller: _complaintTextEditingController,
                        hintText: localization.complaint,
                        fillColor: AppColors.fillColorGrey,
                        maxLines: 5,
                        validator: Validators.validateComplaint(localization),
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Expanded(child: _buildUploadPicturesWidget(title: localization.uploadPhotos, icon: AppIcons.icUploadPhotos, onTap: _onUploadPhotosTap)),
                          Expanded(child: _buildUploadPicturesWidget(title: localization.openCamera, icon: AppIcons.icCamera, onTap: _onOpenCameraTap)),
                        ],
                      ),
                      if (_pickedImages.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(_pickedImages.length, (index) {
                            final image = _pickedImages[index];
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(image.path),
                                    width: 72,
                                    height: 72,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() => _pickedImages.removeAt(index));
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      child: const Icon(Icons.close, size: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: PrimaryBtn(
                    onTap: _onAddComplaintTap,
                    btnText: localization.submit,
                    isLoading: _isSubmitting,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadPicturesWidget({required String title, required VoidCallback onTap, required String icon}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.fillColorGrey,
            elevation: 0,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
        onPressed: onTap, child: Column(
      spacing: 12,
      children: [
        SvgPicture.asset(icon),
        Text(title, style: AppTextStyles.hintTextStyle.copyWith(
            fontWeight: FontWeight.w400, color: const Color(0xff777777)),)
      ],
    ));
  }

  Future<void> _addImages(List<XFile> files) async {
    final localization = AppLocalizations.of(context)!;
    final remaining = _maxPhotos - _pickedImages.length;
    if (remaining <= 0) {
      CommonUI.showSnackBarMessage(context, isError: true, message: localization.maxPhotosReached(_maxPhotos));
      return;
    }
    final accepted = <XFile>[];
    var oversized = false;
    for (final file in files) {
      if (accepted.length >= remaining) break;
      final length = await File(file.path).length();
      if (length > _maxPhotoBytes) {
        oversized = true;
        continue;
      }
      accepted.add(file);
    }
    if (oversized) {
      CommonUI.showSnackBarMessage(context, isError: true, message: localization.photoTooLarge(5));
    }
    if (files.length > remaining && accepted.length >= remaining) {
      CommonUI.showSnackBarMessage(context, isError: true, message: localization.maxPhotosReached(_maxPhotos));
    }
    if (accepted.isEmpty) return;
    _pickedImages.addAll(accepted);
    setState(() {});
  }

  void _onUploadPhotosTap()async{
    final imagePicker = ImagePicker();
    List<XFile> pickedFiles = await imagePicker.pickMultiImage();
    if(pickedFiles.isNotEmpty){
      await _addImages(pickedFiles);
    }
  }

  void _onOpenCameraTap()async{
    final imagePicker = ImagePicker();
    XFile? pickedFiles = await imagePicker.pickImage(source: ImageSource.camera);
    if(pickedFiles != null){
      await _addImages([pickedFiles]);
    }
  }

  void _onAddComplaintTap()async{
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isSubmitting = true);
    String complaint = _complaintTextEditingController.text.trim();
    if (!mounted) return;
    Navigator.pop(context, {'complaint' : complaint, 'files' : List<XFile>.from(_pickedImages)});
  }
}
