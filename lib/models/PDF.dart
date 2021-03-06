
class PDFs {

  String pdfURL;
  String name;
  DateTime uploadDate;
  String user;
  String category;

  PDFs(
      this.pdfURL,
      this.name,
      this.uploadDate,
      this.user,
      this.category,
      );

  PDFs.empty();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> book = Map();
    book['pdfURL'] = pdfURL;
    book['name'] = name;
    book['uploadDate'] = uploadDate;
    book['user'] = user;
    book['category'] =  category;
    return book;
  }

  PDFs.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.pdfURL = map['pdfURL'];
    this.name = map['name'];
    this.uploadDate = map['uploadDate'];
    this.user = map['user'];
    this.category = map['category'];
  }
}