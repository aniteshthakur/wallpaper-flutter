import 'package:my_app/models/categorie_model.dart';

String apiKEY = "563492ad6f9170000100000175082feb94064987b4405bd251664a70";

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = new List();
  CategoryModel categorieModel = new CategoryModel();

  categorieModel.imgUrl =
      "https://images.pexels.com/photos/4101555/pexels-photo-4101555.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categoryName = "Nature";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();
  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/3977529/pexels-photo-3977529.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categoryName = "Street Art";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/2302802/pexels-photo-2302802.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categoryName = "Wild Life";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/1191377/pexels-photo-1191377.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categoryName = "City";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/3763878/pexels-photo-3763878.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categoryName = "Motivation";

  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/1413412/pexels-photo-1413412.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categoryName = "Bikes";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/733745/pexels-photo-733745.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categoryName = "Cars";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  return categories;
}
