class NewReportState {
  bool loading = false;
  String? error;
  bool success;

  NewReportState({required this.loading, this.error, this.success = false});
}
