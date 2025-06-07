class FileModel {
  int? id;
  String? fileTitle;
  String? filePath;
  String? devicePath;

  FileModel({this.id, this.filePath, this.fileTitle, this.devicePath});

  FileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filePath = json['belge'];
    fileTitle = json['belge_adi'];
  }

  static List<FileModel> fromJsonList(List data) {
    if (data.isEmpty) return [];
    List<FileModel> items = [];
    for (var i in data) {
      items.add(FileModel.fromJson(i));
    }
    return items;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['belge'] = filePath;
    data['belge_adi'] = fileTitle;
    return data;
  }
}
