import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portalixmx_app/app_data/app_data.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/models/day_time_model.dart';
import 'package:portalixmx_app/models/guest_api_response.dart';
import 'package:portalixmx_app/models/visitor_api_response.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import 'package:portalixmx_app/providers/home_provider.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:portalixmx_app/widgets/app_textfield_widget.dart';
import 'package:portalixmx_app/widgets/drop_down_textfield_widget.dart';
import 'package:portalixmx_app/widgets/from_date_and_time_widget.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';
import 'package:provider/provider.dart';

class AddGuestPage extends StatefulWidget{
  const AddGuestPage({super.key, this.guest, this.visitor});
  final Guest? guest;
  final Visitor? visitor;

  @override
  State<AddGuestPage> createState() => _AddGuestPageState();
}

class _AddGuestPageState extends State<AddGuestPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _carPlatNumberController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  List<String> _guestTypes = [];
  int selectedGuestTypeIndex = 1;
  DateTime? _selectedFromDateTime;
  DateTime? _selectedToDateTime;

  TimeOfDay? _selectedFromTime;
  TimeOfDay? _selectedToTime;

  List<DayTimeModel> _regularVisitorTime = [];
  bool comingForEdit = false;
  @override
  void initState() {
    _regularVisitorTime = List.generate(7, (index)=> DayTimeModel(dayID: index));

    comingForEdit = widget.visitor != null || widget.guest != null;
    if(comingForEdit){
      selectedGuestTypeIndex = widget.visitor != null ? 0 : 1;
      if(selectedGuestTypeIndex == 1){
        _nameController.text = widget.guest!.name;
        _contactNumberController.text = widget.guest!.contactNumber;
        _carPlatNumberController.text = widget.guest!.carPlateNumber;
        _vehicleModelController.text = widget.guest!.vehicleModel;
        _colorController.text = widget.guest!.color;

      }else{
        _nameController.text = widget.visitor!.name;
        _contactNumberController.text = widget.visitor!.contactNumber;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_){
      _guestTypes =  [
        AppLocalizations.of(context)!.regularVisitor, AppLocalizations.of(context)!.guest
      ];
      setState(() {});
    });
    super.initState();
  }
  @override
  void dispose() {
    _nameController.dispose();
    _contactNumberController.dispose();
    _carPlatNumberController.dispose();
    _vehicleModelController.dispose();
    _colorController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(comingForEdit ?  AppLocalizations.of(context)!.editGuest : AppLocalizations.of(context)!.addGuest, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primaryColor),)),
          AppTextField(textController: _nameController, hintText: AppLocalizations.of(context)!.name, fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor,),
          if(_guestTypes.isNotEmpty)
            DropdownTextfieldWidget(isEmpty: selectedGuestTypeIndex == -1, selectedValue: _guestTypes[selectedGuestTypeIndex], onChanged: (val)=> setState(()=> selectedGuestTypeIndex = _guestTypes.indexOf(val!)), guestTypes: _guestTypes, width: double.infinity, hintText: AppLocalizations.of(context)!.guest),
          AppTextField(textController: _contactNumberController, hintText: AppLocalizations.of(context)!.contactNum,fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor, textInputType: TextInputType.numberWithOptions(),),
          
          selectedGuestTypeIndex == 0 ? _buildRegularVisitorWidget() : _buildGuestWidget() ,
          
         
          Consumer<HomeProvider>(builder: (ctx,provider,_){
            return SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(onTap: _onSubmitTap, btnText: AppLocalizations.of(context)!.submit, isLoading: provider.addingGuestVisitor,),
            );
          })
        ],
      ),
    );
  }



  void _onFromDateTap() async {
    _selectedFromDateTime = await showDatePicker(context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (_selectedFromDateTime != null) {
      setState(() {});
    }
  }
  void _onFromTimeTap()async{
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if(pickedTime != null){
      setState(() =>  _selectedFromTime = pickedTime);
    }
  }

  void _onToDateTap()async{
    _selectedToDateTime = await showDatePicker(context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (_selectedToDateTime != null) {
      setState(() {});
    }
  }
  void _onToTimeTap()async{
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if(pickedTime != null){
      setState(() =>  _selectedToTime = pickedTime);
    }
  }

  Widget _buildGuestWidget() {
    return Column(
      spacing: 15,
      children: [
        AppTextField(textController: _carPlatNumberController, hintText: AppLocalizations.of(context)!.carPlateNumber, fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor,borderColor: AppColors.borderColor,),
        AppTextField(textController: _vehicleModelController, hintText: AppLocalizations.of(context)!.vehicleModel, fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor,borderColor: AppColors.borderColor,),
        AppTextField(textController: _colorController, hintText: AppLocalizations.of(context)!.color, fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor,borderColor: AppColors.borderColor,),
        FromDateAndTimeWidget(title: AppLocalizations.of(context)!.from,onDateTap: _onFromDateTap, onTimeTap: _onFromTimeTap, selectedDate: _selectedFromDateTime, selectedTime: _selectedFromTime),
        FromDateAndTimeWidget(title: AppLocalizations.of(context)!.to,onDateTap: _onToDateTap, onTimeTap: _onToTimeTap, selectedDate: _selectedToDateTime, selectedTime: _selectedToTime),
      ],
    );
  }

  Widget _buildRegularVisitorWidget() {
    return Column(
      spacing: 15,
      children: List.generate(_regularVisitorTime.length, (index){
        int dayID = _regularVisitorTime[index].dayID;
        TimeOfDay? time = _regularVisitorTime[index].time;
        TimeOfDay? endTime = _regularVisitorTime[index].endTime;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            Text(AppData.getDayByID(context, dayID), style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.btnColor),),
            Row(
              spacing: 20,
              children: [
                Expanded(child: Container(
                    padding: EdgeInsets.only(left: 15, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        color: AppColors.fillColorGrey,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(time != null ? DateTimeFormatHelpers.formatTime(time) : AppLocalizations.of(context)!.time, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor2),),
                        IconButton(onPressed: ()=> onTimeTap(index), icon: Icon(Icons.access_time, color: AppColors.darkGreyColor2,))
                      ],
                    )
                )),
                Expanded(child: Container(
                    padding: EdgeInsets.only(left: 15, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        color: AppColors.fillColorGrey,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(endTime != null ? DateTimeFormatHelpers.formatTime(endTime) : AppLocalizations.of(context)!.time, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor2),),
                        IconButton(onPressed: ()=> onEndTimeTap(index), icon: Icon(Icons.access_time, color: AppColors.darkGreyColor2,))
                      ],
                    )
                ))
              ],
            )
          ],
        );
      }),
    );
  }
  
  void onTimeTap(int index)async{
    TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if(pickedTime != null){
      _regularVisitorTime[index].time = pickedTime;
      setState(() {});
    }
  }

  void onEndTimeTap(int index)async{
    TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if(pickedTime != null){
      _regularVisitorTime[index].endTime = pickedTime;
      setState(() {});
    }
  }

  Future<void> _onSubmitTap() async {
    if(selectedGuestTypeIndex == -1){
      //return
    }
    String name = _nameController.text.trim();
    String contactNum = _contactNumberController.text.trim();
    Map<String,dynamic> map = {};
    if(selectedGuestTypeIndex == 0){
       map = {
        "name": name,
        "type": "Regular Visitor",
        "contactNumber": contactNum,
        "moTime": _regularVisitorTime[0].time != null &&  _regularVisitorTime[0].endTime != null ? getFormattedTime(_regularVisitorTime[0]) : "",
        "tueTime":  _regularVisitorTime[1].time != null &&  _regularVisitorTime[1].endTime != null ? getFormattedTime(_regularVisitorTime[1]) : "",
        "wedTime":  _regularVisitorTime[2].time != null &&  _regularVisitorTime[2].endTime != null ? getFormattedTime(_regularVisitorTime[2]) : "",
        "thuTime": _regularVisitorTime[3].time != null &&  _regularVisitorTime[3].endTime != null ? getFormattedTime(_regularVisitorTime[3]) : "",
        "friTime": _regularVisitorTime[4].time != null &&  _regularVisitorTime[4].endTime != null ? getFormattedTime(_regularVisitorTime[4]) : "",
        "satTime":_regularVisitorTime[5].time != null &&  _regularVisitorTime[5].endTime != null ? getFormattedTime(_regularVisitorTime[5]) : "",
        "sunTime": _regularVisitorTime[6].time != null &&  _regularVisitorTime[6].endTime != null ? getFormattedTime(_regularVisitorTime[6]) : "",
      };
    }else {
      String carPlateNum = _carPlatNumberController.text.trim();
      String vehicleModel = _vehicleModelController.text.trim();
      String color = _colorController.text.trim();

       map = {
        'name' : name,
        'type' : 'guest',
        'contactNumber' : contactNum,
        'carPlateNumber' : carPlateNum,
        'vehicleModel' : vehicleModel,
        'color' : color,
         'fromDate' : _selectedFromDateTime!.toIso8601String(),
         'fromTime' : DateTimeFormatHelpers.timeOfDayToString(_selectedFromTime!),
         'toDate' : _selectedToDateTime!.toIso8601String(),
         'toTime' : DateTimeFormatHelpers.timeOfDayToString(_selectedToTime!)

      };
    }


    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    bool result = false;
    if(comingForEdit){
      map['id'] = widget.visitor != null ? widget.visitor!.id : widget.guest!.id;
    }
    if(selectedGuestTypeIndex == 0){
      result =  await homeProvider.addVisitor(data: map, comingForUpdate: comingForEdit);
    }else{
      result = await homeProvider.addGuest( data: map, comingForUpdate: comingForEdit);

    }
    if(result){
      if(selectedGuestTypeIndex == 0){
        await homeProvider.getAllVisitors();
      }else{
        await homeProvider.getAllGuests();
      }
      Fluttertoast.showToast(msg: comingForEdit ? AppLocalizations.of(context)!.hasBeenEditedMessage(name) : AppLocalizations.of(context)!.hasBeenAddedMessage(_guestTypes[selectedGuestTypeIndex], name));
      Navigator.of(context).pop();
    }
  }

  String getFormattedTime(DayTimeModel time){
    return jsonEncode(time.toJson());
    // return '${time.time!.hour}:${time.time!.minute} - ${time.endTime!.hour}:${time.endTime!.minute}';
  }
}

