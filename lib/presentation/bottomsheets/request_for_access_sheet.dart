import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/presentation/widgets/loading_widget.dart';
import 'package:portalixmx_app/services/access_requests_service/access_request_service.dart';
import '../../core/models/access_model.dart';
import '../../core/res/app_colors.dart';
import '../../core/res/app_textstyles.dart';
import '../widgets/from_date_and_time_widget.dart';
import '../widgets/primary_btn.dart';

class RequestForAccessSheet extends StatefulWidget{
  const RequestForAccessSheet({super.key, required this.scrollController, required this.scrollPhysics});
  final ScrollController scrollController;
  final ScrollPhysics scrollPhysics;
  @override
  State<RequestForAccessSheet> createState() => _RequestForAccessSheetState();
}

class _RequestForAccessSheetState extends State<RequestForAccessSheet> {

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  AccessModel? _selectedAccess;
  bool _loading = false;
  List<AccessModel> _accessList = [];

  @override
  void initState() {
    _initAccessList();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const .symmetric(horizontal: 16.0, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(AppLocalizations.of(context)!.requestAccess, style: AppTextStyles.bottomSheetHeadingTextStyle,)),
            const SizedBox(height: 10,),
            FromDateAndTimeWidget(title: AppLocalizations.of(context)!.from, onDateTap: _onDateTap, onTimeTap: _onTimeTap, selectedDate: _selectedDate, selectedTime: _selectedTime, showTitle: false,),
            Text(AppLocalizations.of(context)!.accessFor, style: AppTextStyles.tileSubtitleTextStyle.copyWith(color: Color(0xff666666)),),
            if(_loading)
              LoadingWidget()
            else
              Expanded(
                child: GridView.builder(
                  controller: widget.scrollController,
                  physics: widget.scrollPhysics,
                  // padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: _accessList.length,
                  itemBuilder: (context, index) {
                    final access = _accessList[index];
                    bool isSelected = _selectedAccess == access;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: ()=>  setState(()=> _selectedAccess = access),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:isSelected ? AppColors.primaryColor :  Colors.white,
                                border: Border.all(color: AppColors.borderColor),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset.zero,
                                    blurRadius: 30,
                                    spreadRadius: 0,
                                    color: Colors.black.withValues(alpha: 0.09),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(15),
                              child: access.image.isNotEmpty
                                  ? CachedNetworkImage(
                                imageUrl: access.image,
                                height: 78,
                                width: 78,
                              )
                                  : const Icon(Icons.lock_outline, size: 48),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              access.name,
                              textAlign: .center,
                              style: AppTextStyles.tileSubtitleTextStyle,
                              maxLines: 2,
                              overflow: .ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(
                onTap: _onSubmitTap,
                btnText: AppLocalizations.of(context)!.submit,
              ),
            )

          ],
        ),
      ),
    );
  }

  void _onDateTap()async{
    DateTime? datePicked = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
    if(datePicked != null){
      _selectedDate = datePicked;
      setState(() {});
    }
  }

  void _onTimeTap()async{
    TimeOfDay? timePicked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if(timePicked != null){
      _selectedTime = timePicked;
      setState(() {});
    }
  }

  void _initAccessList() async{
    setState(()=> _loading = true);
    try{
      _accessList = await AccessRequestService.instance.fetchAllAccess();
    }catch(e){
      debugPrint("Failed to fetch accessList: ${e.toString()}");
    }
    setState(()=> _loading = false);

  }
  void _onSubmitTap() {
    if(_selectedDate == null){
      Fluttertoast.showToast(msg: 'Select date for the access request');
      return;
    }

    if(_selectedTime == null){
      Fluttertoast.showToast(msg: 'Select time for the access request');
      return;
    }

    if(_selectedAccess == null){
      Fluttertoast.showToast(msg: 'Select access for the request');
      return;
    }

    Navigator.pop(context,  {
      'selectedDate' : _selectedDate,
      'selectedTime' : _selectedTime,
      'requestedAccess' : _selectedAccess
    });
  }

}