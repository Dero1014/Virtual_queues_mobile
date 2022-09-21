import 'dart:convert';
import 'custom.dart';

class Company {
  late int cId;
  late String cName;
  late String xcName;
  late String cDesc;
  List<Service> services = [];

  Company(this.cId, this.cName, this.xcName, this.cDesc);

  void fetchServices(String response) {
    var cf = CustomFunctions();
    print(response);
    String json = cf.resolveJson(response, 0);
    Map map = jsonDecode(json);

    for (var i = 0; i < map["size"]; i++) {
      String json = cf.resolveJson(response, i + 1);
      Map map = jsonDecode(json);
      Service service = Service(map["sId"], map["sName"], map["numberOfUsers"],
          map["avgTime"], map["timeSum"]);
      addService(service);
    }
  }

  bool addService(Service service) {
    for (var i = 0; i < services.length; i++) {
      if (services[i].getServiceId() == service.getServiceId()) {
        return false;
      }
    }

    services.add(service);
    return true;
  }

  int getCompanyId() {
    return cId;
  }

  String getCompanyName() {
    return cName;
  }

  String getCompanySpacelessName() {
    return xcName;
  }

  String getCompanyDescription() {
    return cDesc;
  }

  List<Service> getServices() {
    return services;
  }

  Service getService(int index) {
    return services[index];
  }
}

class Service {
  int sId;
  String sName;
  int numOfUsers;
  int avgTime;
  int timeSum;

  Service(this.sId, this.sName, this.numOfUsers, this.avgTime, this.timeSum);

  void setAverageTime(int avgTime) {
    this.avgTime = avgTime;
  }

  int getServiceId() {
    return sId;
  }

  int getServiceAverageTime() {
    return avgTime;
  }

  String getServiceName() {
    return sName;
  }
}

class QueueListData {
  static final QueueListData instance = QueueListData._internal();

  factory QueueListData() {
    return instance;
  }

  QueueListData._internal();

  static List<Company> companies = [];

  void fetchCompanies(String response) {
    var cf = CustomFunctions();
    print(response);
    String json = cf.resolveJson(response, 0);
    Map map = jsonDecode(json);

    for (var i = 0; i < map["size"]; i++) {
      String json = cf.resolveJson(response, i + 1);
      Map map = jsonDecode(json);
      Company company =
          Company(map["cId"], map["cName"], map["xcName"], map["cDesc"]);
      addCompany(company);
    }
  }

  bool addCompany(Company company) {
    for (var i = 0; i < companies.length; i++) {
      if (companies[i].getCompanyId() == company.getCompanyId()) {
        return false;
      }
    }

    companies.add(company);
    return true;
  }

  List<Company> getCompaniesList() {
    return companies;
  }

  Company getCompany(int index) {
    return companies[index];
  }
}
