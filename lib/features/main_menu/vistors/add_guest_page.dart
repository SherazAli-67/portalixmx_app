import 'package:flutter/material.dart';
import 'package:portalixmx_app/app_data/app_data.dart';
import 'package:portalixmx_app/features/main_menu/vistors/visitor_added_summary_page.dart';
import 'package:portalixmx_app/models/day_time_model.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:portalixmx_app/widgets/app_textfield_widget.dart';
import 'package:portalixmx_app/widgets/drop_down_textfield_widget.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';

class AddGuestPage extends StatefulWidget{
  const AddGuestPage({super.key});

  @override
  State<AddGuestPage> createState() => _AddGuestPageState();
}

class _AddGuestPageState extends State<AddGuestPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _carPlatNumberController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  final List<String> _guestType = [
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
          DropdownTextfieldWidget(isEmpty: selectedGuestType.isEmpty, selectedValue: selectedGuestType, onChanged: (val)=> setState(()=> selectedGuestType = val!), guestTypes: _guestType, width: double.infinity, hintText: 'Guest'),
          AppTextField(textController: _contactNumberController, hintText: "Contact Number",fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor,),
          
          selectedGuestType == 'Guest' ? _buildGuestWidget() : _buildRegularVisitorWidget(),
          
         
          SizedBox(
            height: 50,
            width: double.infinity,
            child: PrimaryBtn(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> VisitorAddedSummaryPage()));
            }, btnText: "Submit"),
          )
        ],
      ),
    );
  }


  Widget _buildToFromWidget({required String title, required VoidCallback onDateTap, required VoidCallback onTimeTap, DateTime? dateTime, TimeOfDay? time}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text(title, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.btnColor),),
        Row(
          spacing: 20,
          children: [
            Expanded(child: Container(
                padding: EdgeInsets.only(left: 15,  top: 2, bottom: 2),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    color: AppColors.fillColorGrey,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dateTime != null ? DateTimeFormatHelpers.formatDateTime(dateTime) : "Date", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor2),),
                    IconButton(onPressed: onDateTap, icon: Icon(Icons.calendar_month_outlined, color: AppColors.darkGreyColor2,))
                  ],
                )
            ),),
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
                    Text(time != null ? DateTimeFormatHelpers.formatTime(time) :"Time", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor2),),
                    IconButton(onPressed: onTimeTap, icon: Icon(Icons.access_time, color: AppColors.darkGreyColor2,))
                  ],
                )
            ),)
          ],
        )
      ],
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
        _buildToFromWidget(title: 'From',onDateTap: _onFromDateTap, onTimeTap: _onFromTimeTap, dateTime: _selectedFromDateTime, time: _selectedFromTime),
        _buildToFromWidget(title: 'To',onDateTap: _onToDateTap, onTimeTap: _onToTimeTap, dateTime: _selectedToDateTime, time: _selectedToTime),
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
}