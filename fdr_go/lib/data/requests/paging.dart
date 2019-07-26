class Paging {
  int pageNumber;
  int pageSize;
  int totalPages;
  int totalItems;
  String nextPageUrl;
  bool existNextPage;
  bool existPreviusPage;

  Paging({
    this.pageNumber,
    this.pageSize,
    this.totalPages,
    this.totalItems,
    this.nextPageUrl,
    this.existNextPage,
    this.existPreviusPage,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => new Paging(
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    totalPages: json["totalPages"],
    totalItems: json["totalItems"],
    nextPageUrl: json["nextPageUrl"],
    existNextPage: json["existNextPage"],
    existPreviusPage: json["existPreviusPage"],
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "totalPages": totalPages,
    "totalItems": totalItems,
    "nextPageUrl": nextPageUrl,
    "existNextPage": existNextPage,
    "existPreviusPage": existPreviusPage,
  };
}