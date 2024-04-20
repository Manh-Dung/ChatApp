import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/models/base/widget_state.dart';

import '../../utils/utilities.dart';

class BaseCubit<State> extends Cubit<State> with Utilities, ScreenState {
  final dynamic repository;

  BaseCubit(super.initialState, this.repository) {
    scrollController.addListener(_scrollListener);
  }

  bool isLoadMore = false;
  bool withScrollController = false;
  ScrollController scrollController = ScrollController();

  set setEnableScrollController(bool value) => withScrollController = value;

  void onRefresh() {}

  void onLoadMore() {}

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!isLoadMore) {
        isLoadMore = true;
        onLoadMore();
        isLoadMore = false;
      }
    }

    _innerBoxScrolled();
  }

  void _innerBoxScrolled() {
    if (scrollController.offset <= 60 && scrollController.offset > 40) {
      // if(!innerBoxIsScrolled) {
      //   innerBoxIsScrolled = true;
      //   update();
      // }
    }
    if (scrollController.offset >= 0 && scrollController.offset <= 40) {
      // if(innerBoxIsScrolled) {
      //   innerBoxIsScrolled = false;
      //   update();
      // }
    }
  }
}
