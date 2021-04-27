import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_vendor/modals/categorymodal.dart';
import 'package:db_vendor/modals/modals.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProductController extends GetxController {
  var firestore = FirebaseFirestore.instance;
  RxList<Products> products = <Products>[].obs;
  RxList<Products> allProducts = <Products>[].obs;
  RxList<Products> allProductsByCat = <Products>[].obs;
  RxList<CategoryModal> categories = <CategoryModal>[].obs;
  List<List<QueryDocumentSnapshot>> documentList = [];
  final fetching = false.obs;
  final currentProductPage = 0.obs;
  @override
  void onInit() {
    getTopProducts();
    getCategories();
    //getAllProducts();
    super.onInit();
  }

  getTopProducts() async {
    firestore.collection('products').limit(20).snapshots().listen((event) {
      products.clear();
      for (var product in event.docChanges) {
        var newProduct = new Products.fromJson(product.doc.data());
        if (!products.any((element) => element.id == newProduct.id))
          products.add(newProduct);
      }
    });
  }

  getCategories() async {
    firestore.collection('categories').snapshots().listen((event) {
      for (var product in event.docChanges) {
        categories.add(new CategoryModal.fromJson(product.doc.data()));
      }
    });
  }

  getProductBYCategory(String catId) {
    firestore
        .collection('products')
        .where('catId', isEqualTo: catId)
        .snapshots()
        .listen((event) {
      allProducts.clear();
      for (var product in event.docChanges) {
        var newProduct = new Products.fromJson(product.doc.data());
        if (!allProducts.any((element) => element.id == newProduct.id)) {
          allProducts.add(newProduct);
        }
      }
    });
  }

  getAllProducts() async {
    fetching.value = true;
    var localDocumentList = await firestore
        .collection('products')
        .limit(2)
        .orderBy('id')
        .get()
        .then((value) => value.docs);
    if (localDocumentList.length > 0) {
      documentList.add(localDocumentList);
      allProducts.clear();
      for (var product in localDocumentList) {
        var newProduct = new Products.fromJson(product.data());
        allProducts.add(newProduct);
      }
    }
    fetching.value = false;
  }

  getNextProducts() async {
    try {
      fetching.value = true;
      if (!(documentList[currentProductPage.value + 1].length > 0)) {
        var newDocumentList = await firestore
            .collection('products')
            .orderBy('id')
            .startAfterDocument(documentList[currentProductPage.value]
                [documentList[currentProductPage.value].length - 1])
            .limit(2)
            .get()
            .then(
              (value) => value.docs,
            );
        if (newDocumentList.length > 0) {
          documentList.add(newDocumentList);
          allProducts.clear();
          for (var product in newDocumentList) {
            var newProduct = new Products.fromJson(product.data());
            allProducts.add(newProduct);
          }
          currentProductPage.value++;
        }
      } else {
        var newDocumentList = documentList[currentProductPage.value + 1];
        if (newDocumentList.length > 0) {
          documentList.add(newDocumentList);
          allProducts.clear();
          for (var product in newDocumentList) {
            var newProduct = new Products.fromJson(product.data());
            allProducts.add(newProduct);
          }
          currentProductPage.value++;
        }
      }
    } catch (e) {} finally {
      fetching.value = false;
    }
  }

  getPreviousProducts() async {
    fetching.value = true;
    if (!(currentProductPage.value <= 0)) {
      var dlist = documentList[currentProductPage.value - 1];
      allProducts.clear();
      if (dlist.length > 0) {
        for (var product in dlist) {
          var newProduct = new Products.fromJson(product.data());
          allProducts.add(newProduct);
        }
        currentProductPage.value--;
      }
    }
    fetching.value = false;
  }

  getALlCategories() {}
}
