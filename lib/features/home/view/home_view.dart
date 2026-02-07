import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjar/features/home/cubit/product_cubit.dart';
import 'package:matjar/features/home/cubit/product_state.dart';
import 'package:matjar/features/home/data/product_model.dart';
import 'package:matjar/features/home/data/product_repo.dart';
import 'package:matjar/features/home/view/product_details_view.dart';
import 'package:matjar/features/home/widget/card_item.dart';
import 'package:matjar/features/home/widget/user_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(ProductRepo())..getProducts(),
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  // state is Loading
                  if (state is ProductLoading) {
                    return const Center(
                      child: CupertinoActivityIndicator(radius: 15),
                    );
                  }
                  // state is Error
                  if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }
                  // state is Loaded
                  if (state is ProductLoaded) {
                    final products = state.products;
                    return Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 55,
                          ),
                          child: const Column(children: [UserHeader()]),
                        ),
                        // Grid Section
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.70,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return GestureDetector(
                                onTap: () {
                                  final currentCubit = context
                                      .read<ProductCubit>();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                        value: currentCubit,
                                        child: ProductDetailsView(
                                          product: product,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: CardItem(
                                  image: product.images!.first,
                                  text: product.title ?? "No Title",
                                  desc: product.description ?? "",
                                  price: "\$${product.price}",
                                  onDeleteTap: () {
                                    deleteDialog(context, product);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> deleteDialog(BuildContext context, ProductModel product) {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete Product"),
        content: const Text("Are you sure you want to delete this item?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ProductCubit>().deleteProduct(product.id!);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
