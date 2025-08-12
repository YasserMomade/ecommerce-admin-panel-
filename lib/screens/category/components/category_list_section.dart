import 'package:admin/utility/extensions.dart';
import 'package:intl/intl.dart';

import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../models/category.dart';
import 'add_category_form.dart';

class CategoryListSection extends StatelessWidget {
  const CategoryListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueGrey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Categories",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF11182C),
            ),
          ),
          const SizedBox(height: defaultPadding),
          _buildTableHeader(),
          const SizedBox(height: 8),
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              final categories = dataProvider.categories;
              if (categories.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Text(
                      'No categories available.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              }

              return Column(
                children: List.generate(
                  categories.length,
                      (index) => _buildCategoryRow(
                    context,
                    category: categories[index],
                    onEdit: () {
                      showAddCategoryForm(context, categories[index]);
                    },
                    onDelete: () {
                      context.categoryProvider.deleteCategory(categories[index]);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A4DA3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text("Category Name",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text("Added Date",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("Edit",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("Delete",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(
      BuildContext context, {
        required Category category,
        required VoidCallback onEdit,
        required VoidCallback onDelete,
      }) {

    // ---- Formatação da data + hora ----
    String createdAtStr = '';
    final createdAtVal = category.createdAt;

    if (createdAtVal == null) {
      createdAtStr = '';
    } else if (createdAtVal is DateTime) {
      createdAtStr = DateFormat('dd/MM/yyyy HH:mm')
          .format((createdAtVal as DateTime).toLocal());
    } else if (createdAtVal is int) {
      createdAtStr = DateFormat('dd/MM/yyyy HH:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(createdAtVal as int).toLocal());
    } else {
      final parsed = DateTime.tryParse(createdAtVal.toString());
      if (parsed != null) {
        createdAtStr = DateFormat('dd/MM/yyyy HH:mm').format(parsed.toLocal());
      } else {
        createdAtStr = createdAtVal.toString();
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueGrey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    category.image ?? '',
                    height: 36,
                    width: 36,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  category.name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              createdAtStr,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Expanded(
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.indigo),
                onPressed: onEdit,
                tooltip: "Edit category",
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
                tooltip: "Delete category",
              ),
            ),
          ),
        ],
      ),
    );
  }
  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value.toLocal();
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value).toLocal();
    }
    final parsed = DateTime.tryParse(value.toString());
    return parsed?.toLocal();
  }

}
