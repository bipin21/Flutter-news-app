class ApiUtil{
//  static const String MAIN_API_URL = 'http://bipi-news.loc/api';
  static const String MAIN_API_URL = 'https://bipi-news.herokuapp.com/api';
  static const String MAIN_APP_URL = 'https://bipi-news.herokuapp.com/';

  static const String ALL_CATEGORIES = '/categories';

  static const String CATEGORY_POSTS = '/categories/';
  static const String RECENT_POSTS = '/posts';

  static String categoryPosts(String categoryID){
    return MAIN_API_URL + ALL_CATEGORIES + '/' + categoryID + '/posts';
  }

}