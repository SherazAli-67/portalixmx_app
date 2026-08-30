import 'package:flutter/material.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import '../../core/res/app_colors.dart';
import '../../core/res/app_textstyles.dart';
import '../../providers/datetime_format_helpers.dart';

class DateRangeFilterBar extends StatelessWidget {
  const DateRangeFilterBar({
    super.key,
    DateTime? dateFrom,
    DateTime? dateTo,
    required ValueChanged<DateTime> onDateFromChanged,
    required ValueChanged<DateTime> onDateToChanged,
    required VoidCallback onClear,
  }): _dateFrom = dateFrom, _dateTo = dateTo, _onDateFromChanged = onDateFromChanged, _onDateToChanged = onDateToChanged, _onClear = onClear;

  final DateTime? _dateFrom;
  final DateTime? _dateTo;
  final ValueChanged<DateTime> _onDateFromChanged;
  final ValueChanged<DateTime> _onDateToChanged;
  final VoidCallback _onClear;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final hasRange = _dateFrom != null || _dateTo != null;
    return Row(
      spacing: 10,
      children: [
        Expanded(child: _buildDateField(
          context: context,
          placeholder: localization.dateFrom,
          selectedDate: _dateFrom,
          onTap: ()=> _onFromDateTap(context),
        )),
        Expanded(child: _buildDateField(
          context: context,
          placeholder: localization.dateTo,
          selectedDate: _dateTo,
          onTap: ()=> _onToDateTap(context),
        )),
        if(hasRange)
          IconButton(
            onPressed: _onClear,
            icon: Icon(Icons.close_rounded, color: Colors.white,),
          )
      ],
    );
  }

  Widget _buildDateField({required BuildContext context, required String placeholder, DateTime? selectedDate, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: .only(left: 15, top: 2, bottom: 2),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              color: AppColors.fillColorGrey,
              borderRadius: .circular(8)
          ),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Expanded(child: Text(selectedDate != null ? DateTimeFormatHelpers.formatDateTime(selectedDate) : placeholder, style: AppTextStyles.tileTitleTextStyle.copyWith(color: AppColors.greyColor2),)),
              IconButton(onPressed: onTap, icon: Icon(Icons.calendar_month_outlined, color: AppColors.darkGreyColor2,))
            ],
          )
      ),
    );
  }

  Future<void> _onFromDateTap(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(2000);
    final lastDate = _dateTo ?? now;
    final initialDate = _clampDate(_dateFrom ?? now, firstDate, lastDate);
    final picked = await showDatePicker(context: context, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
    if(picked != null){
      _onDateFromChanged(picked);
    }
  }

  Future<void> _onToDateTap(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = _dateFrom ?? DateTime(2000);
    final lastDate = now;
    final initialDate = _clampDate(_dateTo ?? now, firstDate, lastDate);
    final picked = await showDatePicker(context: context, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
    if(picked != null){
      _onDateToChanged(picked);
    }
  }

  DateTime _clampDate(DateTime date, DateTime firstDate, DateTime lastDate) {
    if(date.isBefore(firstDate)) return firstDate;
    if(date.isAfter(lastDate)) return lastDate;
    return date;
  }
}
