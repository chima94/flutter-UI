
class HotelListData{

  HotelListData({
    this.imagePath = "",
    this.titleTxt = "",
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180
});

  String imagePath;
  String titleTxt;
  String subTxt;
  double rating;
  double dist;
  int reviews;
  int perNight;

  static List<HotelListData> hotelList = [
    HotelListData(
      imagePath: 'assets/hotel/hotel_1',
      titleTxt: 'Sharaton Hotel',
      subTxt: 'FCT Abuja',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 180
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_2',
      titleTxt: 'Eko Hotel',
      subTxt: 'Lekki Lagos state',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 200
    ),

    HotelListData(
      imagePath: 'assets/hotel/hotel_3',
      titleTxt: 'Nicon Luxury',
      subTxt: 'FCT Abuja',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 160
    ),

    HotelListData(
      imagePath: 'assets/hotel/hotel_4',
      titleTxt: 'Nicon Luxury',
      subTxt: 'FCT Abuja',
      dist: 2.0,
      reviews: 50,
      perNight: 100
    ),

    HotelListData(
      imagePath: 'assets/hotel/hotel_5',
      titleTxt: 'DNA Barcelona Hotel',
      subTxt: 'FCT Abuja',
      dist: 3.0,
      reviews: 80,
      perNight: 250
    )
  ];
}