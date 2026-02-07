import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjar/features/home/data/product_model.dart';
import 'package:matjar/features/home/data/product_repo.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo productRepo;

  ProductCubit(this.productRepo) : super(ProductInitial());
  Future<void> getProducts() async {
    emit(ProductLoading());

    try {
      final products = await productRepo.getProducts();
      if (products.isEmpty) {
        emit(ProductError("No products found or connection error"));
      } else {
        emit(ProductLoaded(products));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> updateProduct(int id, {String? title, int? price}) async {
    try {
      final Map<String, dynamic> body = {};
      if (title != null) body['title'] = title;
      if (price != null) body['price'] = price;

      await productRepo.updateProduct(id, body);

      if (state is ProductLoaded) {
        final oldProducts = (state as ProductLoaded).products;

        final newProducts = oldProducts.map((p) {
          if (p.id == id) {
            return ProductModel(
              id: p.id,
              title: title ?? p.title, // الاسم الجديد أو القديم
              price: price ?? p.price, // السعر الجديد أو القديم
              description: p.description,
              images: p.images,
            );
          }
          return p;
        }).toList();
        emit(ProductLoaded(newProducts));
      } else {
        await getProducts();
      }
    } catch (e) {
      emit(ProductError(e.toString()));
      await getProducts();
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      if (state is ProductLoaded) {
        final currentList = (state as ProductLoaded).products;
        final newList = currentList
            .where((product) => product.id != id)
            .toList();
        emit(ProductLoaded(newList));
        await productRepo.deleteProduct(id);
      }
    } catch (e) {
      await getProducts();
    }
  }
}
