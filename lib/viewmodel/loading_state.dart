import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingState {
  final bool isLoading;
  final bool init;

  LoadingState({this.isLoading = true, this.init = false});

  LoadingState copyWith({bool? isLoading, bool? init}) {
    return LoadingState(
      isLoading: isLoading ?? this.isLoading,
      init: init ?? this.init,
    );
  }
}

class LoadingNotifier extends StateNotifier<LoadingState> {
  LoadingNotifier() : super(LoadingState());

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setInit(bool init) {
    state = state.copyWith(init: init);
  }
}

final loadingStateProvider = StateNotifierProvider<LoadingNotifier, LoadingState>((ref) {
  return LoadingNotifier();
});