import '../../../core/data/data_provider.dart';
import '../../../models/product.dart';
import 'add_product_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';

class ProductListSection extends StatelessWidget {
  const ProductListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Products",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                return DataTable(
                  columnSpacing: defaultPadding * 1.5,
                  horizontalMargin: defaultPadding,
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade100),
                  columns: [
                    DataColumn(label: Text("Product Name")),
                    DataColumn(label: Text("Category")),
                    DataColumn(label: Text("Sub Category")),
                    DataColumn(label: Text("Price")),
                    DataColumn(label: Text("Edit")),
                    DataColumn(label: Text("Delete")),
                  ],
                  rows: List.generate(
                    dataProvider.products.length,
                        (index) => productDataRow(
                      dataProvider.products[index],
                      edit: () {
                        showAddProductForm(context, dataProvider.products[index]);
                      },
                      delete: () {
// TODO: should complete call deleteProduct
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow productDataRow(Product productInfo, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                productInfo.images?.first.url ?? '',
                height: 30,
                width: 30,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Icon(Icons.broken_image, color: Colors.grey);
                },
              ),
            ),
            SizedBox(width: defaultPadding),
            Flexible(
              child: Text(
                productInfo.name ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(productInfo.proCategoryId?.name ?? '-')),
      DataCell(Text(productInfo.proSubCategoryId?.name ?? '-')),
      DataCell(Text('${productInfo.price}')),
      DataCell(
        IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(Icons.edit, color: Colors.blue),
        ),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(Icons.delete, color: Colors.redAccent),
        ),
      ),
    ],
  );
}