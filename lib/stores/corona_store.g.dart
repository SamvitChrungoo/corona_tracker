// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corona_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CoronaStore on _CoronaStore, Store {
  final _$isLoadingAtom = Atom(name: '_CoronaStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$isNewsLoadingAtom = Atom(name: '_CoronaStore.isNewsLoading');

  @override
  bool get isNewsLoading {
    _$isNewsLoadingAtom.context.enforceReadPolicy(_$isNewsLoadingAtom);
    _$isNewsLoadingAtom.reportObserved();
    return super.isNewsLoading;
  }

  @override
  set isNewsLoading(bool value) {
    _$isNewsLoadingAtom.context.conditionallyRunInAction(() {
      super.isNewsLoading = value;
      _$isNewsLoadingAtom.reportChanged();
    }, _$isNewsLoadingAtom, name: '${_$isNewsLoadingAtom.name}_set');
  }

  final _$dataFetchedAtom = Atom(name: '_CoronaStore.dataFetched');

  @override
  bool get dataFetched {
    _$dataFetchedAtom.context.enforceReadPolicy(_$dataFetchedAtom);
    _$dataFetchedAtom.reportObserved();
    return super.dataFetched;
  }

  @override
  set dataFetched(bool value) {
    _$dataFetchedAtom.context.conditionallyRunInAction(() {
      super.dataFetched = value;
      _$dataFetchedAtom.reportChanged();
    }, _$dataFetchedAtom, name: '${_$dataFetchedAtom.name}_set');
  }

  final _$countryDataAtom = Atom(name: '_CoronaStore.countryData');

  @override
  List<CountryData> get countryData {
    _$countryDataAtom.context.enforceReadPolicy(_$countryDataAtom);
    _$countryDataAtom.reportObserved();
    return super.countryData;
  }

  @override
  set countryData(List<CountryData> value) {
    _$countryDataAtom.context.conditionallyRunInAction(() {
      super.countryData = value;
      _$countryDataAtom.reportChanged();
    }, _$countryDataAtom, name: '${_$countryDataAtom.name}_set');
  }

  final _$newsDataAtom = Atom(name: '_CoronaStore.newsData');

  @override
  List<NewsData> get newsData {
    _$newsDataAtom.context.enforceReadPolicy(_$newsDataAtom);
    _$newsDataAtom.reportObserved();
    return super.newsData;
  }

  @override
  set newsData(List<NewsData> value) {
    _$newsDataAtom.context.conditionallyRunInAction(() {
      super.newsData = value;
      _$newsDataAtom.reportChanged();
    }, _$newsDataAtom, name: '${_$newsDataAtom.name}_set');
  }

  final _$indiaDataAtom = Atom(name: '_CoronaStore.indiaData');

  @override
  List<IndiaData> get indiaData {
    _$indiaDataAtom.context.enforceReadPolicy(_$indiaDataAtom);
    _$indiaDataAtom.reportObserved();
    return super.indiaData;
  }

  @override
  set indiaData(List<IndiaData> value) {
    _$indiaDataAtom.context.conditionallyRunInAction(() {
      super.indiaData = value;
      _$indiaDataAtom.reportChanged();
    }, _$indiaDataAtom, name: '${_$indiaDataAtom.name}_set');
  }

  final _$globalDataAtom = Atom(name: '_CoronaStore.globalData');

  @override
  GlobalData get globalData {
    _$globalDataAtom.context.enforceReadPolicy(_$globalDataAtom);
    _$globalDataAtom.reportObserved();
    return super.globalData;
  }

  @override
  set globalData(GlobalData value) {
    _$globalDataAtom.context.conditionallyRunInAction(() {
      super.globalData = value;
      _$globalDataAtom.reportChanged();
    }, _$globalDataAtom, name: '${_$globalDataAtom.name}_set');
  }

  final _$getNewsAsyncAction = AsyncAction('getNews');

  @override
  Future getNews() {
    return _$getNewsAsyncAction.run(() => super.getNews());
  }

  final _$getIndiaDataAsyncAction = AsyncAction('getIndiaData');

  @override
  Future getIndiaData() {
    return _$getIndiaDataAsyncAction.run(() => super.getIndiaData());
  }

  final _$getDataAsyncAction = AsyncAction('getData');

  @override
  Future getData() {
    return _$getDataAsyncAction.run(() => super.getData());
  }

  final _$_CoronaStoreActionController = ActionController(name: '_CoronaStore');

  @override
  dynamic setIsLoading(bool val) {
    final _$actionInfo = _$_CoronaStoreActionController.startAction();
    try {
      return super.setIsLoading(val);
    } finally {
      _$_CoronaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNewsLoading(bool val) {
    final _$actionInfo = _$_CoronaStoreActionController.startAction();
    try {
      return super.setNewsLoading(val);
    } finally {
      _$_CoronaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},isNewsLoading: ${isNewsLoading.toString()},dataFetched: ${dataFetched.toString()},countryData: ${countryData.toString()},newsData: ${newsData.toString()},indiaData: ${indiaData.toString()},globalData: ${globalData.toString()}';
    return '{$string}';
  }
}
