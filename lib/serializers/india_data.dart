class IndiaData {
  String id;
  String state;
  int active;
  int confirmed;
  int recovered;
  int deaths;
  int cChanges;
  int rChanges;
  int dChanges;
  List<DistrictData> districtData;
  int dchanges;
  int rchanges;
  int cchanges;

  IndiaData(
      {this.id,
      this.state,
      this.active,
      this.confirmed,
      this.recovered,
      this.deaths,
      this.cChanges,
      this.rChanges,
      this.dChanges,
      this.districtData,
      this.dchanges,
      this.rchanges,
      this.cchanges});

  IndiaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    active = json['active'];
    confirmed = json['confirmed'];
    recovered = json['recovered'];
    deaths = json['deaths'];
    cChanges = json['cChanges'];
    rChanges = json['rChanges'];
    dChanges = json['dChanges'];
    if (json['districtData'] != null) {
      districtData = new List<DistrictData>();
      json['districtData'].forEach((v) {
        districtData.add(new DistrictData.fromJson(v));
      });
    }
    dchanges = json['dchanges'];
    rchanges = json['rchanges'];
    cchanges = json['cchanges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['active'] = this.active;
    data['confirmed'] = this.confirmed;
    data['recovered'] = this.recovered;
    data['deaths'] = this.deaths;
    data['cChanges'] = this.cChanges;
    data['rChanges'] = this.rChanges;
    data['dChanges'] = this.dChanges;
    if (this.districtData != null) {
      data['districtData'] = this.districtData.map((v) => v.toJson()).toList();
    }
    data['dchanges'] = this.dchanges;
    data['rchanges'] = this.rchanges;
    data['cchanges'] = this.cchanges;
    return data;
  }
}

class DistrictData {
  String id;
  String state;
  String name;
  int confirmed;
  int recovered;
  int deaths;
  int oldConfirmed;
  int oldRecovered;
  int oldDeaths;
  String zone;

  DistrictData(
      {this.id,
      this.state,
      this.name,
      this.confirmed,
      this.recovered,
      this.deaths,
      this.oldConfirmed,
      this.oldRecovered,
      this.oldDeaths,
      this.zone});

  DistrictData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    name = json['name'];
    confirmed = json['confirmed'];
    recovered = json['recovered'];
    deaths = json['deaths'];
    oldConfirmed = json['oldConfirmed'];
    oldRecovered = json['oldRecovered'];
    oldDeaths = json['oldDeaths'];
    zone = json['zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['name'] = this.name;
    data['confirmed'] = this.confirmed;
    data['recovered'] = this.recovered;
    data['deaths'] = this.deaths;
    data['oldConfirmed'] = this.oldConfirmed;
    data['oldRecovered'] = this.oldRecovered;
    data['oldDeaths'] = this.oldDeaths;
    data['zone'] = this.zone;
    return data;
  }
}
