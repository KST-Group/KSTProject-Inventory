class DeviceModel {
  String? deviceId;
  String? localId;
  String? deviceName;
  String? computername;
  String? comments;
  String? joinDomain;
  String? model;
  String? servicetagSn;
  String? provider;
  String? cpus;
  String? ram;
  String? hardisk;
  String? price;
  String? warranty;
  String? remark;
  String? statuss;
  String? typeId;
  String? brandId;

  DeviceModel({
    this.deviceId,
    this.localId,
    this.deviceName,
    this.computername,
    this.comments,
    this.joinDomain,
    this.model,
    this.servicetagSn,
    this.provider,
    this.cpus,
    this.ram,
    this.hardisk,
    this.price,
    this.warranty,
    this.remark,
    this.statuss,
    this.typeId,
    this.brandId,
  });

  Map<String, dynamic> toMap() => {
        "deviceId": deviceId,
        "localId": localId,
        "device_name": deviceName,
        "computername": computername??'',
        "comments": comments??'',
        "joinDomain": joinDomain??'',
        "model": model??'',
        "servicetag_sn": servicetagSn??'',
        "provider": provider??'',
        "cpus": cpus??'',
        "ram": ram??'',
        "hardisk": hardisk??'',
        "price": price??'',
        "warranty": warranty??'',
        "remark": remark??'',
        "statuss": statuss??'Empty',
        "typeId": typeId??1,
        "brandId": brandId??1,
      };
}
