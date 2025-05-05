import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_icons.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:portalixmx_app/widgets/app_textfield_widget.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';

class AddComplaintPage extends StatefulWidget{
  const AddComplaintPage({super.key});

  @override
  State<AddComplaintPage> createState() => _AddComplaintPageState();
}

class _AddComplaintPageState extends State<AddComplaintPage> {
  final TextEditingController _complaintTextEditingController = TextEditingController();

  @override
  void dispose() {
    _complaintTextEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
      child: Column(
        spacing: 15,
        children: [
          Text("Complaint", style: AppTextStyles.bottomSheetHeadingTextStyle,),
          const SizedBox(height: 10,),
          AppTextField(textController: _complaintTextEditingController, hintText: "Complaint", fillColor: AppColors.fillColorGrey, maxLines: 5,),
          Row(
            spacing: 20,
            children: [
              Expanded(child: _buildUploadPicturesWidget(title: "Upload Photos", icon: AppIcons.icUploadPhotos, onTap: _onOpenCameraTap)),
              Expanded(child: _buildUploadPicturesWidget(title: "Open Camera", icon: AppIcons.icCamera, onTap: _onUploadPhotosTap)),

            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(onTap: (){}, btnText: "Submit"),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUploadPicturesWidget({required String title, required VoidCallback onTap, required String icon}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.fillColorGrey,
            elevation: 0,
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
        onPressed: onTap, child: Column(
      spacing: 12,
      children: [
        SvgPicture.asset(icon),
        Text(title, style: AppTextStyles.hintTextStyle.copyWith(
            fontWeight: FontWeight.w400, color: Color(0xff777777)),)
      ],
    ));
  }

  void _onUploadPhotosTap(){}

  void _onOpenCameraTap(){}
}