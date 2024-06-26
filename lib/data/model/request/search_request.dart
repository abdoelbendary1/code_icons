class SearchRequest {
  String? searchText;

  SearchRequest({this.searchText});

  SearchRequest.fromJson(Map<String, dynamic> json) {
    if (json["text"] is String) {
      searchText = json["text"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["text"] = searchText;

    return data;
  }
}
