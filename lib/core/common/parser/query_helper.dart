class Params {
  int? from;
  int? size;
  List<Filter> andFilters;
  List<Filter> orFilters;
  List<RangeFilter> rangeFilters;
  List<Sort> sortFields;
  String? queryString;

  Params({
    this.from = 0,
    this.size = 10,
    List<Filter>? andFilters,
    List<Filter>? orFilters,
    List<RangeFilter>? rangeFilters,
    List<Sort>? sortFields,
    this.queryString,
  })  : andFilters = andFilters ?? [],
        orFilters = orFilters ?? [],
        rangeFilters = rangeFilters ?? [],
        sortFields = sortFields ?? [];
}

class Filter {
  String field;
  List<String> values;
  String? condition;

  Filter({required this.field, required this.values, this.condition});
}

class RangeFilter {
  String field;
  Map<String, dynamic> conditions;

  RangeFilter({required this.field, required this.conditions});
}

class Sort {
  String field;
  String order;

  Sort({required this.field, required this.order});
}

class QueryHelper {
  static Map<String, dynamic> getEsQuery(Params params) {
    // Building the query
    Map<String, dynamic> boolQuery = {};

    if (params.andFilters.isNotEmpty || params.rangeFilters.isNotEmpty) {
      boolQuery["must"] = [
        ...params.andFilters.expand((filter) => filter.values.map((value) => {
              "match": {filter.field: value}
            })),
        ...params.rangeFilters.map((filter) => {
              "range": {filter.field: filter.conditions}
            }),
      ];
    }

    if (params.orFilters.isNotEmpty) {
      boolQuery["should"] = params.orFilters
          .expand((filter) => filter.values.map((value) => {
                "match": {filter.field: value}
              }))
          .toList();
      boolQuery["minimum_should_match"] = 1;
    }

    // Add query_string if it exists
    if (params.queryString != null && params.queryString!.isNotEmpty) {
      boolQuery["must"] = [
        ...(boolQuery["must"] ?? []),
        {
          "query_string": {
            "query": params.queryString,
            "fields": ["*"]
          }
        }
      ];
    }

    Map<String, dynamic> query = {
      "from": params.from,
      "size": params.size,
      if (boolQuery.isNotEmpty) "query": {"bool": boolQuery},
      if (params.sortFields.isNotEmpty)
        "sort": params.sortFields
            .map((sortField) => {
                  sortField.field: {"order": sortField.order}
                })
            .toList(),
    };

    return query;
  }

  static String buildUrlFromParams(Params params) {
    List<String> queryParams = [];

    // Convert AND filters to `@nestjsx/crud` query parameters (using 'filter' keyword)
    for (Filter filter in params.andFilters) {
      String condition;
      if (filter.values.length > 1) {
        condition = 'in'; // Use 'in' if there are multiple values
        queryParams.add(
            'filter=${filter.field}||$condition||${filter.values.join(",")}');
      } else {
        condition = filter.condition ??
            'eq'; // Use 'eq' if there is only one value or default condition
        queryParams
            .add('filter=${filter.field}||$condition||${filter.values.first}');
      }
    }

    // Convert OR filters (using 'or' keyword in `@nestjsx/crud`)
    for (Filter filter in params.orFilters) {
      String condition;
      if (filter.values.length > 1) {
        condition = 'in'; // Use 'in' if there are multiple values
        queryParams
            .add('or=${filter.field}||$condition||${filter.values.join(",")}');
      } else {
        condition = filter.condition ?? 'eq';
        queryParams
            .add('or=${filter.field}||$condition||${filter.values.first}');
      }
    }

    // Handle range filters (using 'gt', 'lt', 'gte', 'lte' for `@nestjsx/crud`)
    for (RangeFilter rangeFilter in params.rangeFilters) {
      rangeFilter.conditions.forEach((key, value) {
        String operator;
        if (key == 'gte') {
          operator = 'ge'; // 'ge' is 'greater than or equal to'
        } else if (key == 'lte') {
          operator = 'le'; // 'le' is 'less than or equal to'
        } else {
          operator = key; // For any custom operators
        }
        queryParams.add('filter=${rangeFilter.field}||$operator||$value');
      });
    }

    // Add sorting parameters for `@nestjsx/crud`
    for (Sort sort in params.sortFields) {
      String order = sort.order.toUpperCase() == 'DESC' ? 'DESC' : 'ASC';
      queryParams.add('sort=${sort.field},$order');
    }

    // Pagination for `@nestjsx/crud` (limit and page)
    queryParams.add('limit=${params.size}');
    if (params.from != null && params.size != null) {
      int page = (params.from! ~/ params.size!) + 1;
      queryParams.add('page=$page');
    }

    // Construct the final query string
    String queryString = queryParams.join('&');
    return '?$queryString';
  }
}
