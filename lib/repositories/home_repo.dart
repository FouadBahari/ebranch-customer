
import 'package:e_branch_customer/repositories/public_repo.dart';

class HomeRepositories{
  static Future<Map<dynamic,dynamic>> getCategories() async {
    return await PublicRopository.repo("services","get");
  }
  static Future<Map> getMarkets(id) async {
    return await PublicRopository.repo("vendors/$id","get");
  }

  static Future<Map> getShippingPrices() async {
    return await PublicRopository.repo("get_settings","get");
  }

  static Future<Map> getMarketSliders(id) async {
    return await PublicRopository.repo("sliders/$id","get");
  }

  static Future<Map> searchVendors(name) async {
    return await PublicRopository.repo("searchvendors/$name","get");
  }

  static Future<Map> getMarketOffers(id) async {
    return await PublicRopository.repo("offers/$id","get");
  }

  static Future<Map> getNotification() async {
    return await PublicRopository.repo("notifications","get");
  }

  static Future<Map> getProducts(id) async {
    return await PublicRopository.repo("products-vendor/$id","get");
  }

  static Future<Map> getMarketCategories(id) async {
    return await PublicRopository.repo("categories/$id","get");
  }


  static Future<Map> getRandomProducts() async {
    return await PublicRopository.repo("products","get");
  }

  static Future<Map> getCartData() async {
    return await PublicRopository.repo("All-in-cart","get");
  }

  static Future<Map> removeCartItem(id) async {
    return await PublicRopository.repo("Remove-from-cart/$id","get");
  }

  static Future<Map> cancelOrder(id) async {
    return await PublicRopository.repo("cancel-order/$id","get");
  }


  static Future<Map> addToCart(formData) async {
    return await PublicRopository.repo("Add-to-cart/${formData['product_id']}","post",formData: formData);
  }


  static Future<Map> getMarketsWithLocation(lat,lang) async {
    return await PublicRopository.repo("allvendors","get");
  }

  static Future<Map> makeOrder(formData) async {
    return await PublicRopository.repo("make-order","post",formData: formData);
  }

  static Future<Map> rateOrder(formData) async {
    return await PublicRopository.repo("rate-order","post",formData: formData);
  }

  static Future<Map> sendMsg(formData) async {
    return await PublicRopository.repo("send-message","post",formData: formData);
  }

  static Future<Map> getCurrentOrders(endPoint) async {
    return await PublicRopository.repo(endPoint,"get");
  }

  static Future<Map> getBestSeller(id) async {
    return await PublicRopository.repo("bestselles/$id","get");
  }

  static Future<Map> getPreviousOrders(endPoint) async {
    return await PublicRopository.repo(endPoint,"get");
  }

  static Future<Map> getChatsList() async {
    return await PublicRopository.repo("All-chats","get");
  }

  static Future<Map> getChat(id) async {
    return await PublicRopository.repo("chats/$id","get");
  }

  static Future<Map> seenChat(id) async {
    return await PublicRopository.repo("Seen-chat/$id","get");
  }

  static Future<Map> contactUs(formData) async {
    return await PublicRopository.repo("contact-us","post",formData: formData);
  }

  static Future<Map> terms(type) async {
    return await PublicRopository.repo("terms/$type","get");
  }

}
