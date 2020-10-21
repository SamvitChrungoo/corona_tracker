import 'package:corona_tracker/serializers/country_data.dart';
import 'package:corona_tracker/serializers/global_data.dart';
import 'package:corona_tracker/serializers/india_data.dart';
import 'package:corona_tracker/serializers/news.dart';
import 'package:corona_tracker/utils/http_service.dart';
import 'package:mobx/mobx.dart';

part 'corona_store.g.dart';

class CoronaStore = _CoronaStore with _$CoronaStore;

abstract class _CoronaStore with Store {
  @observable
  bool isLoading = false;

  @observable
  bool isError = false;

  @observable
  bool isNewsLoading = false;

  @observable
  bool dataFetched = false;

  @observable
  List<CountryData> countryData = [];

  @observable
  List<NewsData> newsData = [];

  @observable
  List<IndiaData> indiaData = [];

  @observable
  GlobalData globalData;

  @action
  setIsLoading(bool val) {
    isLoading = val;
  }

  @action
  setNewsLoading(bool val) {
    isNewsLoading = val;
  }

  @action
  getNews() async {
    var now = DateTime.now();
    var month = now.month;
    var year = now.year;
    var day = now.day;
    var response;
    try {
      response = await ApiService().getRequest(
          "http://newsapi.org/v2/everything?q=covid coronavirus covid-india&from=$year-$month-$day&sortBy=publishedAt&apiKey=add29b93d70e41b78aac1c1de15f924c");
      dataFetched = true;
    } catch (e) {
      print("Error => $e");
    }
    var data = response['articles'];
    data.forEach((f) {
      newsData.add(NewsData.fromJson(f));
    });
    setNewsLoading(false);
  }

  @action
  getIndiaData() async {
    var response;
    try {
      response = await ApiService()
          .getRequest("https://api.covidindiatracker.com/state_data.json");
      dataFetched = true;
    } catch (e) {
      print("Error => $e");
    }

    response.forEach((f) {
      indiaData.add(IndiaData.fromJson(f));
    });
    indiaData.sort((a, b) => a.state.compareTo(b.state));
  }

  @action
  getData() async {
    isLoading = true;
    var response;
    try {
      response =
          await ApiService().getRequest("https://api.covid19api.com/summary");
      dataFetched = true;
    } catch (e) {
      print("Error => $e");
    }
    var global = response['Global'];
    var country = response['Countries'];
    globalData = GlobalData.fromJson(global);
    country.forEach((f) {
      countryData.add(CountryData.fromJson(f));
    });
    isLoading = false;
  }

  setError() {
    isError = true;
  }
}
