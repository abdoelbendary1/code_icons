// ignore_for_file: constant_identifier_names

enum SearchCases {
  Empty,
  Name,
  TradeRegistry,
}

extension SearchCasesExtension on SearchCases {
  String get name {
    switch (this) {
      case SearchCases.Empty:
        return 'Empty';
      case SearchCases.Name:
        return 'Name';
      case SearchCases.TradeRegistry:
        return 'TradeRegistry';
    }
  }
}
