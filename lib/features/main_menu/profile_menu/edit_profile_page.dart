import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_app/helpers/formating_helper.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/profile_provider.dart';
import 'package:portalixmx_app/providers/user_info_provider.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:portalixmx_app/widgets/app_textfield_widget.dart';
import 'package:portalixmx_app/widgets/bg_gradient_screen.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';
import 'package:provider/provider.dart';

import '../../../helpers/image_url_helper.dart';
import '../../../models/user_api_response_model.dart';
import '../../../res/app_icons.dart';

class EditProfilePage extends StatefulWidget{
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  String _userName = '';
  String _emailAddress = '';

  String _userPhone = '';
  String _vehicleName = '';
  String _vehicleColor = '';
  String _vehicleLicensePlate = '';
  String _vehicleRegistrationNum = '';

   List<String> _emergencyContacts = [];

  XFile? _imagePicked;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<ProfileProvider>(context, listen: false);
      _userName = provider.user!.name;
      _emailAddress = provider.user!.email;
      _userPhone = provider.user!.mobile;
      _emergencyContacts = provider.user!.emergencyContacts;
      _vehicleName = provider.user!.additionalDetails.vehicleName;
      _vehicleColor = provider.user!.additionalDetails.color;
      _vehicleLicensePlate = provider.user!.additionalDetails.licensePlate;
      _vehicleRegistrationNum = provider.user!.additionalDetails.registrationNumber;
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<ProfileProvider>(context);
    return BgGradientScreen(child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 65.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(color: Colors.white,),
              Text(AppLocalizations.of(context)!.profile, style: AppTextStyles.regularTextStyle,),
              const SizedBox(width: 40,)
            ],
          ),
        ),

        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 65,
                    right: 0,
                    left: 0,
                    child: Card(
                      color: Colors.white,
                      elevation: 1,
                      margin: EdgeInsets.zero,
                      child: Padding(padding: EdgeInsets.only(top: 100, right: 15, left: 15,),
                        child: SizedBox(
                          height: size.height*0.7,
                          child: ListView(
                            children: [
                              EditProfileItemWidget(
                                title: AppLocalizations.of(context)!.name,
                                value: _userName,
                                onTap: (){
                                  _onEditTap(title: AppLocalizations.of(context)!.name, value: _userName, onUpdated: (val) {
                                    if(val.isNotEmpty){
                                      _userName = val;
                                      setState(() {});
                                    }
                                  });
                                },),
                            /*  EditProfileItemWidget(
                                title: AppLocalizations.of(context)!.email,
                                value: _emailAddress,
                                onTap: (){},),*/
                              EditProfileItemWidget(
                                title: AppLocalizations.of(context)!.phone,
                                value: _userPhone,
                                isPhone: true,
                                onTap: (){
                                  _onEditTap(title: AppLocalizations.of(context)!.phone, isNumber: true,  value: _userPhone, onUpdated: (val) {
                                    if(val.isNotEmpty){
                                      _userPhone = val;
                                      setState(() {});
                                    }
                                  });
                                },),
                              EditProfileItemWidget(
                                title: AppLocalizations.of(context)!.password, value: "*********", onTap: () {},),
                              EditProfileItemWidget(title: AppLocalizations.of(context)!.emergencyContacts,
                                value: "",
                                onTap: () {},
                                emergencyContacts: _emergencyContacts),
                              const SizedBox(height: 30,),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(color: Colors.black26)
                                  ),
                                  onPressed: () {}, child: Text(AppLocalizations.of(context)!.add)),
                              const SizedBox(height: 30,),
                              Text(AppLocalizations.of(context)!.vehicleInformation, style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor),),

                              EditProfileItemWidget(
                                title: AppLocalizations.of(context)!.vehicleName,
                                value: _vehicleName,
                                onTap: (){
                                  _onEditTap(
                                      title: AppLocalizations.of(context)!.vehicleName,
                                      value: _vehicleName,
                                      onUpdated: (val) {
                                        if(val.isNotEmpty){
                                          _vehicleName = val;
                                          setState(() {});
                                        }
                                  });
                                },),
                              EditProfileItemWidget(
                                title: AppLocalizations.of(context)!.color,
                                value: _vehicleColor,
                                onTap: (){
                                  _onEditTap(title: AppLocalizations.of(context)!.color,
                                      value: _vehicleColor,
                                      onUpdated: (val) {
                                    if(val.isNotEmpty){
                                      _vehicleColor = val;
                                      setState(() {});
                                    }
                                  });
                                },),
                              EditProfileItemWidget(
                                title: AppLocalizations.of(context)!.licensePlateNumber,
                                value: _vehicleLicensePlate,
                                onTap: (){
                                  _onEditTap(title: AppLocalizations.of(context)!.licensePlateNumber,
                                      value:_vehicleLicensePlate,
                                      onUpdated: (val) {
                                    if(val.isNotEmpty){
                                      _vehicleLicensePlate = val;
                                      setState(() {});
                                    }
                                  });
                                },),
                             /* EditProfileItemWidget(
                                title: AppLocalizations.of(context)!.registrationNumber,
                                value: _vehicleRegistrationNum,
                                onTap: (){
                                  _onEditTap(title: AppLocalizations.of(context)!.registrationNumber,
                                      value: _vehicleRegistrationNum,
                                      onUpdated: (val) {
                                    if(val.isNotEmpty){
                                      _vehicleRegistrationNum = val;
                                      setState(() {});
                                    }
                                  });
                                },),*/
                              Padding(
                                padding: EdgeInsets.only(top: 40,bottom: size.height*0.07),
                                child: Consumer<ProfileProvider>(
                                  builder: (context, provider,  _) {
                                    return SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: PrimaryBtn(onTap: _onUpdateTap, btnText: AppLocalizations.of(context)!.update, isLoading: provider.updatingProfile,),
                                    );
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    )),
                Column(
                  spacing: 5,
                  children: [

                    GestureDetector(
                      onTap: _onPickImageTap,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _imagePicked != null
                            ? FileImage(File(_imagePicked!.path))
                            : CachedNetworkImageProvider(ImageUrlHelper.getImageUrl(provider.user!.image)),
                      ),
                      ),
                    ),
                    Text(_userName, style: AppTextStyles.bottomSheetHeadingTextStyle.copyWith(color: Colors.black),),
                  /*  InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> EditProfilePage()));
                        },
                        child: Text("View Profile", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),))*/
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }

  void _onEditTap({required String title, required String value, bool isNumber = false,  required Function(String updatedVal) onUpdated}){
    TextEditingController editingController = TextEditingController(text: value);
    String updatedValue = value;
    
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        isScrollControlled: true,
        builder: (ctx){
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.editProfile, style: AppTextStyles.tileTitleTextStyle,),
                  IconButton(onPressed: (){
                    // Store the current value before closing
                    updatedValue = editingController.text.trim();
                    // Unfocus before closing to prevent TextEditingController disposal issues
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.close_rounded))
                ],
              ),
              Text(AppLocalizations.of(context)!.updateYour(title), style: AppTextStyles.btnTextStyle.copyWith(color: Colors.black),),
              AppTextField(controller: editingController, hintText: title, textInputType: isNumber ? .number : .none,)
            ],
          ),
        ),
      );
    }).then((_){
      // Call the callback with the updated value
      onUpdated(updatedValue);
      // Dispose the controller after the callback is complete
     /* WidgetsBinding.instance.addPostFrameCallback((_) {
        editingController.dispose();
      });*/
    });
  }

  Future<void> _onUpdateTap() async {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    final map = {
      'name' : _userName,
      'img' : _imagePicked != null ? _imagePicked!.path : "",
      'mobile' : _userPhone,
      "additionalDetails": {
        "vehicleName": _vehicleName,
        "color":  _vehicleColor,
        "licensePlate": _vehicleLicensePlate,
        "registrationNumber": _vehicleRegistrationNum
      },
      "emergencyContacts": provider.user!.emergencyContacts
    };

    bool result = await provider.updateUserProfile(data: map, onProfileUpdated: _onProfileUpdated);
    if(result){
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.profileInfoUpdated);
      Navigator.of(context).pop();
    }
  }

  void _onProfileUpdated(UserModel user){
    final homeProvider = Provider.of<UserInfoProvider>(context, listen: false);
    homeProvider.setUserName(user.name);
  }

  void _onPickImageTap()async{
    ImagePicker imagePicker = ImagePicker();
    XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if(selectedImage != null){
      _imagePicked = selectedImage;
      setState(() {});
    }
  }
}

class EditProfileItemWidget extends StatelessWidget {
  const EditProfileItemWidget({
    super.key,
    required String title, required String value, required VoidCallback onTap, List<String>? emergencyContacts, bool isPhone = false
  }): _title = title, _value = value, _onTap = onTap, _emergencyContacts = emergencyContacts, _isPhoneNum = isPhone;
  final String _title;
  final String _value;
  final VoidCallback _onTap;
  final List<String>? _emergencyContacts;
  final bool _isPhoneNum;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_title, style: AppTextStyles.editProfileHeadingTextStyle,),
              InkWell(onTap: _onTap, child: SvgPicture.asset(AppIcons.icProfileEdit))
            ],
          ),
          _emergencyContacts == null ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_isPhoneNum ? FormatingHelper.formatPhoneNumber(_value) : _value, style: AppTextStyles.editProfileSubHeadingTextStyle,),
              Divider()
            ],
          ) : Column(
            spacing: 10,
            children: _emergencyContacts!.map((contact){
              debugPrint("Contact: $contact");
              final decoded = jsonDecode(contact);
              if(decoded != null && decoded is List<dynamic>){
                debugPrint("Decoded: $decoded");
                List<dynamic> contactList = decoded;
                return Column(
                  children: contactList.map((contact){
                    final decodedContact = jsonDecode(contact);
                    String contactName = decodedContact['name'];
                    String contactNumber = decodedContact['mobile'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(contactName, style: AppTextStyles.emergencyContactTitleTextStyle,),
                        Text(FormatingHelper.formatPhoneNumber(contactNumber), style: AppTextStyles.editProfileSubHeadingTextStyle,),

                      ],
                    );
                  }).toList(),
                );
              }
              return Text(contact, style: AppTextStyles.editProfileSubHeadingTextStyle,);
              /*return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.name, style: AppTextStyles.emergencyContactTitleTextStyle,),
                  Text(contact.phoneNumber, style: AppTextStyles.editProfileSubHeadingTextStyle,)
                ],
              );*/
            }).toList(),
          )


        ],
      ),
    );
  }
}