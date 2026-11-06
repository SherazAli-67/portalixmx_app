import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_app/core/helpers/status_display_helper.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../../providers/datetime_format_helpers.dart';
import '../../../core/helpers/bottom_sheet_helper.dart';
import '../../../core/helpers/image_url_helper.dart';
import '../../../core/models/payment_model.dart';
import '../../../core/models/payment_submitted_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../router/app_router.dart';
import '../../../services/payments_service/payments_service.dart';
import '../../bottomsheets/submit_payment_to_admin_bottomsheet.dart';
import '../../widgets/bg_gradient_screen.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/primary_btn.dart';
import '../main_menu/homepage/widgets/vistor_info_item_widget.dart';
import '../main_menu/main_menu.dart';

class PaymentDetailPage extends StatelessWidget{
  const PaymentDetailPage({super.key, required this.payment});
  final PaymentModel payment;

  PaymentStatus _statusFromSubmission(PaymentSubmittedModel? submission) {
    if (submission == null) return PaymentStatus.pending;
    if (submission.isReceived) return PaymentStatus.received;
    if (submission.isRejected) return PaymentStatus.rejected;
    return PaymentStatus.submitted;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BgGradientScreen(child: Column(
      spacing: 20,
      children: [
        Padding(padding: const EdgeInsets.only(top: 65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(color: Colors.white,),
              Text(localizations.paymentDetail, style: AppTextStyles.regularTextStyle,),
              const SizedBox(width: 40,)
            ],
          ),
        ),

        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(localizations.paymentDetail, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.btnColor),),
                    Expanded(
                      child: FutureBuilder<PaymentSubmittedModel?>(
                        future: PaymentsService.instance.getMySubmission(paymentID: payment.paymentID),
                        builder: (ctx, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const LoadingWidget(color: AppColors.primaryColor,);
                          }
                          final submission = snapshot.data;
                          final status = _statusFromSubmission(submission);
                          final canSubmit = status == PaymentStatus.pending || status == PaymentStatus.rejected;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: 20,
                                  children: [
                                    Expanded(
                                      child:VisitorInfoItemWidget(title: localizations.paymentFor, subTitle: payment.paymentForTitle,),
                                    ),
                                    Expanded(
                                        child: VisitorInfoItemWidget(
                                          title: localizations.status, subTitle: StatusDisplayHelper.label(status, localizations),)
                                    ),
                                  ],
                                ),
                                VisitorInfoItemWidget(title: localizations.date, subTitle: DateTimeFormatHelpers.formatDateTime(payment.dateTime), showDivider: true ),
                                if (status == PaymentStatus.rejected)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Text(
                                      localizations.paymentRejectedResubmitHint,
                                      style: AppTextStyles.tileSubtitleTextStyle.copyWith(color: AppColors.statusError),
                                    ),
                                  ),
                                Expanded(
                                  child: canSubmit
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (submission?.receipt != null && submission!.receipt!.isNotEmpty)
                                              Expanded(child: _buildReceiptImage(context, localizations, title: payment.paymentForTitle, receipt: submission.receipt))
                                            else
                                              const Spacer(),
                                            _buildSubmitPaymentBtn(
                                              localizations,
                                              context,
                                              isResubmit: status == PaymentStatus.rejected,
                                            ),
                                          ],
                                        )
                                      : _buildReceiptImage(context, localizations, title: payment.paymentForTitle, receipt: submission?.receipt),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
            ),
          ),
        )
      ],
    ),);
  }

  Widget _buildSubmitPaymentBtn(AppLocalizations localization, BuildContext context, {required bool isResubmit}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 12),
      child: SizedBox(
        width: double.infinity,
        child: PrimaryBtn(onTap: ()async{
          final result = await BottomSheetHelper.showDraggableBottomSheet(
              scaffoldKey: scaffoldKey,
              initialHeight: 0.6,
              child: SubmitPaymentToAdminBottomSheet(payment: payment));
          if(result != null && context.mounted){
            _updatePaymentStatus(context, result['receipt']);
          }
        }, btnText: isResubmit ? localization.resubmitReceipt : localization.submit),
      ),
    );
  }

  Widget _buildReceiptImage(BuildContext context,  AppLocalizations localizations,{String? receipt, String? title}) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizations.receipt, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.btnColor)),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: receipt == null || receipt.isEmpty
              ? Center(child: Text(localizations.receiptUnavailable, style: AppTextStyles.tileSubtitleTextStyle))
              : GestureDetector(
            onTap: ()=> context.push(NamedRoutes.previewImage.routeName, extra: {
              'title' : title ?? 'Payment',
              'imageUrl': ImageUrlHelper.getImageUrl(receipt)
            }),
                child: CachedNetworkImage(
                            imageUrl: receipt,
                            fit: BoxFit.contain,
                            height: 200,
                            width: double.infinity,
                            progressIndicatorBuilder: (context, url, downloadProgress) => CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
              ),
        )
      ],
    );
  }

  void _updatePaymentStatus(BuildContext context, XFile receiptImage) {
    final updatedPayment = payment.copyWith(receipt: receiptImage.path, paymentStatus: PaymentStatus.submitted);
    Navigator.pop(context, updatedPayment);
  }
}
