class App {

  /**
   * success : true
   * data : [{"createAt":"2019-01-11T08:20:41.844Z","autoPublish":false,"installWithPwd":0,"updateMode":"silent","totalDownloadCount":7,"todayDownloadCount":{"date":"2019-02-13T07:06:06.744Z","count":7},"grayStrategy":{"ipType":"black","ipList":[],"updateMode":"silent"},"_id":"5c3851d998e05136910dae8d","appName":"PaoNet","bundleId":"com.ditclear.paonet","platform":"android","creator":"ditclear","creatorId":"5c3851c398e05136910dae88","icon":"upload/5c3851c398e05136910dae88/icon/com.ditclear.paonet_1.0_1_a.png","shortUrl":"paonet","ownerId":"5c3851c398e05136910dae88","currentVersion":"1","__v":0,"releaseVersionCode":"1","releaseVersionId":"5c3851d998e05136910dae8e"},{"createAt":"2019-01-12T08:03:01.563Z","autoPublish":false,"updateMode":"silent","totalDownloadCount":3,"todayDownloadCount":{"date":"2019-02-14T02:50:34.830Z","count":3},"grayStrategy":{"ipType":"black","ipList":[],"updateMode":"silent"},"_id":"5c399f3598e05136910daea4","appName":"BindingListAdapter","bundleId":"io.ditclear.app","platform":"android","creator":"ditclear","creatorId":"5c3851c398e05136910dae88","icon":"upload/5c3851c398e05136910dae88/icon/io.ditclear.app_1.0_1_a.png","shortUrl":"7me2fm","ownerId":"5c3851c398e05136910dae88","currentVersion":"1","__v":0,"releaseVersionCode":"1","releaseVersionId":"5c399f3598e05136910daea5"}]
   */

  bool success;
  List<AppListBean> data;

  static App fromMap(Map<String, dynamic> map) {
    App app = new App();
    app.success = map['success'];
    app.data = AppListBean.fromMapList(map['data']);
    return app;
  }

  static List<App> fromMapList(dynamic mapList) {
    List<App> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class AppListBean {

  /**
   * createAt : "2019-01-11T08:20:41.844Z"
   * updateMode : "silent"
   * _id : "5c3851d998e05136910dae8d"
   * appName : "PaoNet"
   * bundleId : "com.ditclear.paonet"
   * platform : "android"
   * creator : "ditclear"
   * creatorId : "5c3851c398e05136910dae88"
   * icon : "upload/5c3851c398e05136910dae88/icon/com.ditclear.paonet_1.0_1_a.png"
   * shortUrl : "paonet"
   * ownerId : "5c3851c398e05136910dae88"
   * currentVersion : "1"
   * releaseVersionCode : "1"
   * releaseVersionId : "5c3851d998e05136910dae8e"
   * autoPublish : false
   * installWithPwd : 0
   * totalDownloadCount : 7
   * __v : 0
   * grayStrategy : {"ipType":"black","ipList":[],"updateMode":"silent"}
   * todayDownloadCount : {"date":"2019-02-13T07:06:06.744Z","count":7}
   */

  String createAt;
  String updateMode;
  String id;
  String appName;
  String bundleId;
  String platform;
  String creator;
  String creatorId;
  String icon;
  String shortUrl;
  String ownerId;
  String currentVersion;
  String releaseVersionCode;
  String releaseVersionId;
  bool autoPublish;
  int installWithPwd;
  int totalDownloadCount;
  int __v;
  GrayStrategyBean grayStrategy;
  TodayDownloadCountBean todayDownloadCount;

  static AppListBean fromMap(Map<String, dynamic> map) {
    AppListBean dataListBean = new AppListBean();
    dataListBean.createAt = map['createAt'];
    dataListBean.updateMode = map['updateMode'];
    dataListBean.id = map['_id'];
    dataListBean.appName = map['appName'];
    dataListBean.bundleId = map['bundleId'];
    dataListBean.platform = map['platform'];
    dataListBean.creator = map['creator'];
    dataListBean.creatorId = map['creatorId'];
    dataListBean.icon = map['icon'];
    dataListBean.shortUrl = map['shortUrl'];
    dataListBean.ownerId = map['ownerId'];
    dataListBean.currentVersion = map['currentVersion'];
    dataListBean.releaseVersionCode = map['releaseVersionCode'];
    dataListBean.releaseVersionId = map['releaseVersionId'];
    dataListBean.autoPublish = map['autoPublish'];
    dataListBean.installWithPwd = map['installWithPwd'];
    dataListBean.totalDownloadCount = map['totalDownloadCount'];
    dataListBean.__v = map['__v'];
    dataListBean.grayStrategy = GrayStrategyBean.fromMap(map['grayStrategy']);
    dataListBean.todayDownloadCount = TodayDownloadCountBean.fromMap(map['todayDownloadCount']);
    return dataListBean;
  }

  static List<AppListBean> fromMapList(dynamic mapList) {
    List<AppListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class GrayStrategyBean {

  /**
   * ipType : "black"
   * updateMode : "silent"
   * ipList : []
   */

  String ipType;
  String updateMode;
  List<dynamic> ipList;

  static GrayStrategyBean fromMap(Map<String, dynamic> map) {
    GrayStrategyBean grayStrategyBean = new GrayStrategyBean();
    grayStrategyBean.ipType = map['ipType'];
    grayStrategyBean.updateMode = map['updateMode'];
    grayStrategyBean.ipList = map['ipList'];
    return grayStrategyBean;
  }

  static List<GrayStrategyBean> fromMapList(dynamic mapList) {
    List<GrayStrategyBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class TodayDownloadCountBean {

  /**
   * date : "2019-02-13T07:06:06.744Z"
   * count : 7
   */

  String date;
  int count;

  static TodayDownloadCountBean fromMap(Map<String, dynamic> map) {
    TodayDownloadCountBean todayDownloadCountBean = new TodayDownloadCountBean();
    todayDownloadCountBean.date = map['date'];
    todayDownloadCountBean.count = map['count'];
    return todayDownloadCountBean;
  }

  static List<TodayDownloadCountBean> fromMapList(dynamic mapList) {
    List<TodayDownloadCountBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
