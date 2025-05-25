import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portalixmx_app/app_data/app_data.dart';
import 'package:portalixmx_app/models/day_time_model.dart';
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
  const AddGuestPage({super.key, required this.token});
  final String token;
  @override
  State<AddGuestPage> createState() => _AddGuestPageState();
}

class _AddGuestPageState extends State<AddGuestPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _carPlatNumberController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  final List<String> _guestTypes = [
    'Regular Visitor', 'Guest'
  ];
  String selectedGuestType = 'Guest';
  DateTime? _selectedFromDateTime;
  DateTime? _selectedToDateTime;

  TimeOfDay? _selectedFromTime;
  TimeOfDay? _selectedToTime;

  List<DayTimeModel> _regularVisitorTIme = [];
  @override
  void initState() {
    _regularVisitorTIme = List.generate(7, (index)=> DayTimeModel(dayID: index));

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
              child: Text("Add Guest", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primaryColor),)),
          AppTextField(textController: _nameController, hintText: "Name", fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor,),
          DropdownTextfieldWidget(isEmpty: selectedGuestType.isEmpty, selectedValue: selectedGuestType, onChanged: (val)=> setState(()=> selectedGuestType = val!), guestTypes: _guestTypes, width: double.infinity, hintText: 'Guest'),
          AppTextField(textController: _contactNumberController, hintText: "Contact Number",fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor, textInputType: TextInputType.numberWithOptions(),),
          
          selectedGuestType == 'Guest' ? _buildGuestWidget() : _buildRegularVisitorWidget(),
          
         
          Consumer<HomeProvider>(builder: (ctx,provider,_){
            return SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(onTap: _onSubmitTap, btnText: "Submit", isLoading: provider.addingGuestVisitor,),
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
        AppTextField(textController: _carPlatNumberController, hintText: "Car Plate Number", fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor,borderColor: AppColors.borderColor,),
        AppTextField(textController: _vehicleModelController, hintText: "Vehicle Model", fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor,borderColor: AppColors.borderColor,),
        AppTextField(textController: _colorController, hintText: "Color", fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor,borderColor: AppColors.borderColor,),
        FromDateAndTimeWidget(title: 'From',onDateTap: _onFromDateTap, onTimeTap: _onFromTimeTap, selectedDate: _selectedFromDateTime, selectedTime: _selectedFromTime),
        FromDateAndTimeWidget(title: 'To',onDateTap: _onToDateTap, onTimeTap: _onToTimeTap, selectedDate: _selectedToDateTime, selectedTime: _selectedToTime),
      ],
    );
  }

  Widget _buildRegularVisitorWidget() {
    return Column(
      spacing: 15,
      children: List.generate(_regularVisitorTIme.length, (index){
        int dayID = _regularVisitorTIme[index].dayID;
        TimeOfDay? time = _regularVisitorTIme[index].time;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            Text(AppData.getDayByID(dayID), style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.btnColor),),
            Container(
                padding: EdgeInsets.only(left: 15, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    color: AppColors.fillColorGrey,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(time != null ? DateTimeFormatHelpers.formatTime(time) :"Time", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor2),),
                    IconButton(onPressed: ()=> onTimeTap(index), icon: Icon(Icons.access_time, color: AppColors.darkGreyColor2,))
                  ],
                )
            )
          ],
        );
      }),
    );
  }
  
  void onTimeTap(int index)async{
    TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if(pickedTime != null){
      _regularVisitorTIme[index].time = pickedTime;
      setState(() {});
    }
  }

  Future<void> _onSubmitTap() async {
    debugPrint("Submit tap");
    if(selectedGuestType.isEmpty){
      //return
    }
    debugPrint("Below Submit tap");
    String name = _nameController.text.trim();
    String contactNum = _contactNumberController.text.trim();



    if(selectedGuestType == _guestTypes[0]){
     /* final map = {
        'name': name,
        'contactNumber' : contactNum,
        'type' : 'Regular Visitor',
        'moTime' : ''
      };*/
    }else {
      String carPlateNum = _carPlatNumberController.text.trim();
      String vehicleModel = _vehicleModelController.text.trim();
      String color = _colorController.text.trim();

      debugPrint("Inside else");
      //guest
      String fromDate = DateFormat('yyyy-MM-dd').format(_selectedFromDateTime!);
      String fromTime = DateTimeFormatHelpers.formatTime(_selectedFromTime!);

      String toDate = DateFormat('yyyy-MM-dd').format(_selectedToDateTime!);
      String toTime = DateTimeFormatHelpers.formatTime(_selectedToTime!);

      final map = {
        'name' : name,
        'type' : 'guest',
        'contactNumber' : contactNum,
        'carPlateNumber' : carPlateNum,
        'vehicleModel' : vehicleModel,
        'color' : color,
        'fromDate' : fromDate,
        'fromTime' : fromTime,
        'toDate' : toDate,
        'toTime' : toTime,

      };

      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      bool result = await homeProvider.addGuest(token: widget.token, data: map);
      if(result){
        await homeProvider.getAllGuests(token: widget.token);
        Navigator.of(context).pop();
      }
    }
  }
}

