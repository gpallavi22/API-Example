class ApiModel {
  List<Data>? data;
  Meta? meta;

  ApiModel({this.data, this.meta});

  ApiModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  int? heightFeet;
  int? heightInches;
  String? lastName;
  String? position;
  Team? team;
  int? weightPounds;

  Data(
      {this.id,
        this.firstName,
        this.heightFeet,
        this.heightInches,
        this.lastName,
        this.position,
        this.team,
        this.weightPounds});
  // This is modal class

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    heightFeet = json['height_feet'];
    heightInches = json['height_inches'];
    lastName = json['last_name'];
    position = json['position'];
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
    weightPounds = json['weight_pounds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['height_feet'] = this.heightFeet;
    data['height_inches'] = this.heightInches;
    data['last_name'] = this.lastName;
    data['position'] = this.position;
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    data['weight_pounds'] = this.weightPounds;
    return data;
  }
}

class Team {
  int? id;
  String? abbreviation;
  String? city;
  String? conference;
  String? division;
  String? fullName;
  String? name;

  Team(
      {this.id,
        this.abbreviation,
        this.city,
        this.conference,
        this.division,
        this.fullName,
        this.name});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abbreviation = json['abbreviation'];
    city = json['city'];
    conference = json['conference'];
    division = json['division'];
    fullName = json['full_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['abbreviation'] = this.abbreviation;
    data['city'] = this.city;
    data['conference'] = this.conference;
    data['division'] = this.division;
    data['full_name'] = this.fullName;
    data['name'] = this.name;
    return data;
  }
}

class Meta {
  int? totalPages;
  int? currentPage;
  int? nextPage;
  int? perPage;
  int? totalCount;

  Meta(
      {this.totalPages,
        this.currentPage,
        this.nextPage,
        this.perPage,
        this.totalCount});

  Meta.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    nextPage = json['next_page'];
    perPage = json['per_page'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    data['next_page'] = this.nextPage;
    data['per_page'] = this.perPage;
    data['total_count'] = this.totalCount;
    return data;
  }
}
