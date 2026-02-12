import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import 'package:portalixmx_app/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/models/day_time_model.dart';
import '../../../../core/app_data/app_data.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_icons.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/primary_btn.dart';
import '../../../bottomsheets/add_update_guest_bottomsheet.dart';
import 'widgets/vistor_info_item_widget.dart';

class GuestDetailPage extends StatefulWidget{
  const GuestDetailPage({super.key, required BaseVisitor visitor}): _visitor = visitor;
  final BaseVisitor _visitor;

  @override
  State<GuestDetailPage> createState() => _GuestDetailPageState();
}

class _GuestDetailPageState extends State<GuestDetailPage> {

  bool _loadingSave = false;

  @override
  Widget build(BuildContext context) {
    final isGuest = widget._visitor is GuestVisitor;
    final localization = AppLocalizations.of(context)!;
    
    return BgGradientScreen(
        paddingFromTop: 50,
        child: Stack(
          children: [
            Column(
              spacing: 11,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,)),
                    Column(
                      children: [
                        Text(widget._visitor.name, style: AppTextStyles.regularTextStyle,),
                        Text(isGuest ? localization.guest : localization.regularVisitor, style: AppTextStyles.tileSubtitleTextStyle,)
                      ],
                    ),
                    IconButton(onPressed: () => _showEditBottomSheet(context), icon: Icon(Icons.more_vert_rounded, color: Colors.white,))
                  ],
                ),
                Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
                      child: Column(
                        children: [
                          Row(
                            spacing: 20,
                            children: [
                              Expanded(
                                child: VisitorInfoItemWidget(
                                    title: localization.requestedTime,
                                    subTitle: DateTimeFormatHelpers.formatDateTime(widget._visitor.createdAt),
                                    showDivider: true),
                              ),
                              Expanded(child: VisitorInfoItemWidget(title: localization.accessFor, subTitle: '',  showDivider: true)
                              ),
                            ],
                          ),

                          Row(
                            spacing: 20,
                            children: [
                              Expanded(
                                child: VisitorInfoItemWidget(
                                  title: localization.accessApprovedDate, 
                                  subTitle: DateTimeFormatHelpers.formatDateTime(widget._visitor.updatedAt), 
                                ),
                              ),
                              Expanded(
                                  child: VisitorInfoItemWidget(
                                    title: localization.contactNum, 
                                    subTitle: widget._visitor.contact,
                                  )
                              ),
                            ],
                          ),
                          Divider(),
                          isGuest ? _buildGuestDetailPage(context) : _buildVisitorDetailPage(context)

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            if(_loadingSave)
              Container(
                color: Colors.black45,
                width: double.infinity,
                height: double.infinity,
                child: LoadingWidget(color: AppColors.primaryColor,),
              )


          ],
        ));
  }

  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              _buildEditDeleteItem(
                icon: AppIcons.icEdit,
                text: AppLocalizations.of(context)!.edit,
                onTap: () {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.82,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: AddUpdateGuestBottomSheet(
                            visitor: widget._visitor,
                            isEdit: true,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              _buildEditDeleteItem(
                icon: AppIcons.icDelete,
                text: AppLocalizations.of(context)!.delete,
                onTap: () async {
                  debugPrint("on Delete tap");
                  final provider = context.read<HomeProvider>();
                  bool result = await provider.deleteVisitor(widget._visitor.id);

                  if (!context.mounted) return;

                  if (result) {
                    Fluttertoast.showToast(msg: "Visitor deleted successfully");
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else {
                    Fluttertoast.showToast(
                        msg: "Failed to delete visitor, Try again");
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEditDeleteItem(
      {required String icon, required String text, required VoidCallback onTap}) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        spacing: 20,
        children: [
          SvgPicture.asset(icon),
          Text(
            text,
            style: AppTextStyles.visitorDetailSubtitleTextStyle,
          )
        ],
      ),
    );
  }

  Widget _buildGuestDetailPage(BuildContext context) {
    final guest = widget._visitor as GuestVisitor;
    final localization = AppLocalizations.of(context)!;
    
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.from,
                    style: AppTextStyles.visitorDetailTitleTextStyle,
                  ),
                  Text(
                    '${DateFormat('EEEE').format(guest.fromDateTime)} - ${DateFormat('HH:mm').format(guest.fromDateTime)}',
                    style: AppTextStyles.visitorDetailSubtitleTextStyle,
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColors.dividerColor,
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.to,
                    style: AppTextStyles.visitorDetailTitleTextStyle,
                  ),
                  Text(
                    '${DateFormat('EEEE').format(guest.toDateTime)} - ${DateFormat('HH:mm').format(guest.toDateTime)}',
                    style: AppTextStyles.visitorDetailSubtitleTextStyle,
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColors.dividerColor,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        _buildQRImage(),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: PrimaryBtn(
            onTap: () => _shareQrCode(widget._visitor.id),
            btnText: localization.shareKey,
            color: AppColors.primaryColor,
          ),
        )
      ],
    );
  }

  Widget _buildVisitorDetailPage(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        Column(
            children: List.generate(7, (index) {
          final time = getVisitorTimeByIndex(index);
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppData.getDays(context)[index],
                      style: AppTextStyles.visitorDetailTitleTextStyle,
                    ),
                    Text(
                      time != null && time.time != null && time.endTime != null
                          ? '${time.time!.hour.toString().padLeft(2, '0')}:${time.time!.minute.toString().padLeft(2, '0')} - ${time.endTime!.hour.toString().padLeft(2, '0')}:${time.endTime!.minute.toString().padLeft(2, '0')}'
                          : '',
                      style: AppTextStyles.visitorDetailSubtitleTextStyle,
                    )
                  ],
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: AppColors.dividerColor,
                ),
              ],
            ),
          );
        })),
        Text(
          localization.qrCode,
          style: AppTextStyles.visitorDetailTitleTextStyle,
        ),
        Image.asset(AppIcons.icQRCode),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: PrimaryBtn(
            onTap: () => _shareQrCode(widget._visitor.id),
            btnText: localization.shareKey,
            color: AppColors.primaryColor,
          ),
        )
      ],
    );
  }

  DayTimeModel? getVisitorTimeByIndex(int index) {
    if (widget._visitor is! RegularVisitor) return null;
    final visitor = widget._visitor as RegularVisitor;
    final days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
    final key = days[index];
    final schedule = visitor.schedule[key];
    
    if (schedule != null) {
      return DayTimeModel(
        dayID: index,
        time: schedule.startTime,
        endTime: schedule.endTime,
      );
    }
    return null;
  }

  void _shareQrCode(String? content) async {
    String userName = widget._visitor.name;
    if (content != null && content.isNotEmpty) {
      try {
        setState(() => _loadingSave = true);
        Uint8List? capturedImage = await _takeScreenshot();
        final directory = await getTemporaryDirectory();
        final imagePath = '${directory.path}/$userName.png';
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(capturedImage!);

        // Share the image
        await SharePlus.instance.share(ShareParams(
          files: [XFile(imagePath)],
          text: content,
        ));
      } catch (e) {
        debugPrint("Failed to share QR Code: ${e.toString()}");
      }
      setState(() => _loadingSave = false);
    }
  }

  Future<Uint8List?> _takeScreenshot() async {
    Uint8List? uint8List;
    ScreenshotController screenshotController = ScreenshotController();

    try {
      uint8List = await screenshotController.captureFromWidget(
        InheritedTheme.captureAll(context, _buildQRImage()),
        delay: const Duration(seconds: 1), // Optional delay to ensure rendering
      );
    } catch (e) {
      debugPrint('Error while taking screenshot: ${e.toString()}');
    }
    return uint8List;
  }

  Widget _buildQRImage() {
    final map = {
      'isGuest': widget._visitor is GuestVisitor,
      'userID': widget._visitor.id,
      'name': widget._visitor.name,
      'type': widget._visitor.visitorType,
    };
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          height: 200,
          child: QrImageView(data: jsonEncode(map)),
        ),
      ),
    );
  }
}