enum AdType { image, video }

class AdInfo {
  String description;
  AdType mediaType;
  String docId;
  String media;
  String category;
  String subCategory;
  String price;
  bool isMessage;
  bool isCall;
  bool isLiked;
  String title;
  String user;
  String address;

  AdInfo(
      {this.description,
      this.docId,
      this.mediaType,
      this.media,
      this.category,
      this.address,
      this.isCall,
      this.isLiked,
      this.isMessage,
      this.price,
      this.subCategory,
      this.title,
      this.user});
}
