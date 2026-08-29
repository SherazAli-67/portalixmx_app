import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portalixmx_app/core/res/app_colors.dart';
import 'package:portalixmx_app/core/res/app_textstyles.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ZkbioQrWidget extends StatefulWidget {
  const ZkbioQrWidget({
    super.key,
    required this.qrPayload,
    this.onRefresh,
    this.size = 200,
    this.showActions = true,
    this.shareLabel,
  });

  final String qrPayload;
  final Future<String> Function()? onRefresh;
  final double size;
  final bool showActions;
  final String? shareLabel;

  @override
  State<ZkbioQrWidget> createState() => _ZkbioQrWidgetState();
}

class _ZkbioQrWidgetState extends State<ZkbioQrWidget> {
  Timer? _refreshTimer;
  bool _refreshing = false;
  late String _qrPayload;

  @override
  void initState() {
    super.initState();
    _qrPayload = widget.qrPayload;
    _startAutoRefresh();
  }

  @override
  void didUpdateWidget(covariant ZkbioQrWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.qrPayload != widget.qrPayload) {
      _qrPayload = widget.qrPayload;
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    if (widget.onRefresh == null) return;
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 60), (_) => _handleRefresh());
  }

  Future<void> _handleRefresh() async {
    if (widget.onRefresh == null || _refreshing) return;
    setState(() => _refreshing = true);
    try {
      final newPayload = await widget.onRefresh!();
      if (mounted) setState(() => _qrPayload = newPayload);
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  Future<void> _shareQr() async {
    final controller = ScreenshotController();
    final bytes = await controller.captureFromWidget(
      _buildQrCard(forScreenshot: true),
      delay: const Duration(milliseconds: 300),
    );
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/zkbio_qr.png';
    await File(imagePath).writeAsBytes(bytes);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(imagePath)],
        text: widget.shareLabel ?? 'Portalix access QR',
      ),
    );
  }

  Widget _buildQrCard({bool forScreenshot = false}) {
    final size = forScreenshot ? widget.size : widget.size * 0.75;
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: QrImageView(
          data: _qrPayload,
          size: size,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        _buildQrCard(),
        if (widget.showActions) ...[
          if (_refreshing)
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              if (widget.onRefresh != null)
                TextButton(
                  onPressed: _refreshing ? null : _handleRefresh,
                  child: Text(
                    l10n.refreshQr,
                    style: AppTextStyles.btnTextStyle.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              TextButton(
                onPressed: _shareQr,
                child: Text(
                  l10n.shareQrCode,
                  style: AppTextStyles.btnTextStyle.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
