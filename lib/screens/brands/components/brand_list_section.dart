
import 'package:admin/utility/extensions.dart';
import 'package:intl/intl.dart';
import '../../../core/data/data_provider.dart';
import 'add_brand_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../../models/brand.dart';

class BrandListSection extends StatelessWidget {
  const BrandListSection({Key? key}) : super(key: key);

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
            "All Brands",
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
              final brands = List<Brand>.from(dataProvider.brands);

              brands.sort((a, b) {
                final aDate = _parseDate(a.createdAt);
                final bDate = _parseDate(b.createdAt);

                if (aDate == null && bDate == null) return 0;
                if (aDate == null) return 1;
                if (bDate == null) return -1;
                return bDate.compareTo(aDate); // mais recente primeiro
              });

              if (brands.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Text(
                      'No Brands available.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              }

              return Column(
                children: List.generate(brands.length, (index) {
                  final brand = brands[index];
                  return _buildSubcategoryRow(
                    context,
                    brand: brand,
                    onEdit: () => showBrandForm(context, brand),
                    onDelete: () =>
                        context.brandProvider.deleteBrand(brand),
                    index: index + 1,
                  );
                }),
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
            child: Text(
              "Brands Name",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Sub Category",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Added Date",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              "Edit",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubcategoryRow(
      BuildContext context, {
        required Brand brand,
        required VoidCallback onEdit,
        required VoidCallback onDelete,
        required int index,
      }) {
    // ---- Formatação da data + hora ----
    String createdAtStr = '';
    final createdAtVal = brand.createdAt;

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
          Container(
            height: 24,
            width: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors[index % colors.length],
              shape: BoxShape.circle,
            ),
            child: Text(
              index.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              brand.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              brand.subcategoryId?.name ?? '',
              style: const TextStyle(color: Colors.black54),
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
                tooltip: "Edit Brand",
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
                tooltip: "Delete Brand",
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
