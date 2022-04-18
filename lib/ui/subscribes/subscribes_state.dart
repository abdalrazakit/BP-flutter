class SubscribesState {
  bool loading = false;
  String? error;
  bool success;

  SubscribesState({required this.loading, this.error, this.success = false});
}
