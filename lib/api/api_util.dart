class ApiUtil{
//  static const String MAIN_API_URL = 'http://bipi-news.loc/api';
  static const String MAIN_API_URL = 'https://bipi-news.herokuapp.com/api';

  static const String ALL_CATEGORIES = '/categories';

  static const String CATEGORY_POSTS = '/categories/';

  static String categoryPosts(String categoryID){
    return MAIN_API_URL + ALL_CATEGORIES + '/' + categoryID + '/posts';
  }

}