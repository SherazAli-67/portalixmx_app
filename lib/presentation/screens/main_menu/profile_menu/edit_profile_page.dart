import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/common_ui.dart';
import 'package:portalixmx_app/core/helpers/auth_error_localizer.dart';
import 'package:portalixmx_app/core/validators/validators.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/presentation/widgets/profile_image_widget.dart';
import 'package:portalixmx_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/app_textfield_widget.dart';
import '../../../widgets/bg_gradient_screen.dart';
import '../../../widgets/primary_btn.dart';

class EditProfilePage extends StatefulWidget{
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _vehicleNameController = TextEditingController();
  final TextEditingController _vehicleColorController = TextEditingController();
  final TextEditingController _licensePlateNumController = TextEditingController();
  final TextEditingController _registrationNumController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _personalEmergencyPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late ProfileProvider provider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<ProfileProvider>(context, listen: false);
      if(provider.user != null){
        _nameController.text = provider.user!.userName;
        _phoneNumController.text = provider.user!.phoneNum ?? '';
        _vehicleNameController.text = provider.user!.vehicleInformation?.name ?? '';
        _vehicleColorController.text = provider.user!.vehicleInformation?.color ?? '';
        _licensePlateNumController.text = provider.user!.vehicleInformation?.licensePlateNumber ?? '';
        _registrationNumController.text = provider.user!.vehicleInformation?.registrationNumber ?? '';
        _houseNumberController.text = provider.user!.houseNumber ?? '';
        _addressController.text = provider.user!.address ?? '';
        _personalEmergencyPhoneController.text = provider.user!.personalEmergencyPhone ?? '';
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumController.dispose();
    _vehicleNameController.dispose();
    _vehicleColorController.dispose();
    _licensePlateNumController.dispose();
    _registrationNumController.dispose();
    _houseNumberController.dispose();
    _addressController.dispose();
    _personalEmergencyPhoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    provider = Provider.of<ProfileProvider>(context);
    final localization = AppLocalizations.of(context)!;
    return BgGradientScreen(child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 65.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(color: Colors.white,),
              Text(localization.profile, style: AppTextStyles.regularTextStyle,),
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
                      child: SizedBox(
                          height: size.height*0.8,
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(top: 100, right: 15, left: 15,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 20,
                                children: [
                                  Column(
                                    spacing: 10,
                                    children: [
                                      AppTextField(title: localization.name, hintText: localization.name, controller: _nameController,titleTextStyle: AppTextStyles.editProfileHeadingTextStyle, isDense: true, borderColor: AppColors.lightGreyBackgroundColor, validator: Validators.validateFullName(localization),),
                                      AppTextField(title: localization.phone, hintText: localization.phoneNumber, controller: _phoneNumController,titleTextStyle: AppTextStyles.editProfileHeadingTextStyle, textInputType: TextInputType.number, isDense: true, borderColor: AppColors.lightGreyBackgroundColor, validator: Validators.validatePhone(localization),),
                                      AppTextField(title: localization.houseNumber, hintText: localization.houseNumber, controller: _houseNumberController,titleTextStyle: AppTextStyles.editProfileHeadingTextStyle, isDense: true, borderColor: AppColors.lightGreyBackgroundColor, validator: Validators.validateHouseNumber(localization),),
                                      AppTextField(title: localization.address, hintText: localization.address, controller: _addressController,titleTextStyle: AppTextStyles.editProfileHeadingTextStyle, isDense: true, borderColor: AppColors.lightGreyBackgroundColor, validator: Validators.validateAddress(localization), maxLines: 2,),
                                      AppTextField(title: localization.personalEmergencyPhone, hintText: localization.contactNum, controller: _personalEmergencyPhoneController,titleTextStyle: AppTextStyles.editProfileHeadingTextStyle, textInputType: TextInputType.number, isDense: true, borderColor: AppColors.lightGreyBackgroundColor, validator: Validators.validatePhone(localization),),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Text(localization.vehicleInformation, style:AppTextStyles.btnTextStyle.copyWith(color: AppColors.primaryColor)),
                                      AppTextField(title: localization.vehicleName, hintText: localization.vehicleNameHint, controller: _vehicleNameController,titleTextStyle: AppTextStyles.editProfileHeadingTextStyle,isDense: true,  borderColor: AppColors.lightGreyBackgroundColor, validator: Validators.validateMinLength(localization, emptyMessage: localization.pleaseEnterVehicleName, minLengthMessage: localization.vehicleNameMinLength),),
                                      AppTextField(title: localization.color,hintText: localization.colorHint, controller: _vehicleColorController,titleTextStyle: AppTextStyles.editProfileHeadingTextStyle,isDense: true, borderColor: AppColors.lightGreyBackgroundColor, validator: Validators.validateMinLength(localization, emptyMessage: localization.pleaseEnterVehicleColor, minLengthMessage: localization.colorMinLength),),
                                      AppTextField(title: localization.licensePlateNumber, hintText: localization.licenseNumberHint, controller: _licensePlateNumController,titleTextStyle: AppTextStyles.editProfileHeadingTextStyle,isDense: true,borderColor: AppColors.lightGreyBackgroundColor, validator: Validators.validateLicensePlate(localization),),
                                      AppTextField(title: localization.registrationNumber,hintText: localization.registrationNumber, controller: _registrationNumController,titleTextStyle: AppTextStyles.editProfileHeadingTextStyle, isDense: true, borderColor: AppColors.lightGreyBackgroundColor, validator: Validators.validateRequired(localization, localization.pleaseEnterRegistrationNumber),),
                                    ],
                                  ),
                                Padding(
                                  padding: EdgeInsets.only(top: 40,bottom: size.height*0.07),
                                  child: Consumer<ProfileProvider>(
                                      builder: (context, provider,  _) {
                                        return SizedBox(
                                          height: 50,
                                          width: double.infinity,
                                          child: PrimaryBtn(onTap: _onUpdateTap, btnText: localization.update, isLoading: provider.updatingProfile,),
                                        );
                                      }
                                  ),)
                                ],
                              ),
                            ),
                          )
                        ),
                    )),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: provider.onPickImageTap,
                    child: ProfileImageWidget(imageUrl: provider.pickedImage != null ? provider.pickedImage!.path : provider.user!.profileImg, isLocalFile: provider.pickedImage != null,)
                ),)
              ],
            ),
          ),
        )
      ],
    ));
  }

  Future<void> _onUpdateTap() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    String name = _nameController.text.trim();
    String phone = _phoneNumController.text.trim();
    String vehicleName = _vehicleNameController.text.trim();
    String color = _vehicleColorController.text.trim();
    String licensePlateNum = _licensePlateNumController.text.trim();
    String registrationNum = _registrationNumController.text.trim();
    String houseNumber = _houseNumberController.text.trim();
    String address = _addressController.text.trim();
    String personalEmergencyPhone = _personalEmergencyPhoneController.text.trim();

    final localization = AppLocalizations.of(context)!;

    String? isError = await provider.onUpdateTap(
      name: name,
      phoneNum: phone,
      vehicleName: vehicleName,
      color: color,
      licensePlateNum: licensePlateNum,
      registrationNum: registrationNum,
      houseNumber: houseNumber,
      address: address,
      personalEmergencyPhone: personalEmergencyPhone,
    );
    if (!mounted) return;
    if(isError != null){
      CommonUI.showSnackBarMessage(context, isError: true, message: AuthErrorLocalizer.localize(localization, isError));
      return;
    }

    Navigator.pop(context);
  }
}
