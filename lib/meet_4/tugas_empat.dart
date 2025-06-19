import 'package:flutter/material.dart';

class TugasEmpat extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  TugasEmpat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //menggunakan leading untuk menampilkan tombol kembali, dan Navigation.pop untuk kembali ke halaman sebelumnya
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Kembali ke halaman sebelumnya
        ),
        title: Text(
          "Formulir & Daftar Produk",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1A1A2E),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PROFIL",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1A1A2E),
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 16),
              _buildModernTextField(
                controller: namaController,
                label: "Nama",
                icon: Icons.person_outline,
              ),
              SizedBox(height: 16),
              _buildModernTextField(
                controller: emailController,
                label: "Email",
                icon: Icons.email_outlined,
              ),
              SizedBox(height: 16),
              _buildModernTextField(
                controller: hpController,
                label: "No. HP",
                icon: Icons.phone_iphone_outlined,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              _buildModernTextField(
                controller: deskripsiController,
                label: "Deskripsi",
                icon: Icons.description_outlined,
                maxLines: 3,
              ),
              SizedBox(height: 24),
              Text(
                "PRODUK",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xff1A1A2E),
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 16),
              _buildProductList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Color(0xff1A1A2E)),
        filled: true,
        fillColor: Colors.grey[50],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xff1A1A2E), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }

  Widget _buildProductList() {
    return Column(
      children: [
        _buildProductItem(
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuSqcpgonute3gy7lCOzd1zkqArqtG1iR0zQ&s',
          name: "Nike Air Max 90",
          price: "Rp. 1.900.000",
        ),
        SizedBox(height: 12),
        _buildProductItem(
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHUVGyd6BChWYb1-dPkiBCK8RTevzGb8zcmQ&s',
          name: "iPhone 16 ProMax",
          price: "Rp. 16.000.000",
        ),
        SizedBox(height: 12),
        _buildProductItem(
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc7LwH9rhDFkq3N3MGqqXtxpArYcyxpFwSoA&s',
          name: "Samsung Galaxy Tab S10",
          price: "Rp. 19.000.000",
        ),
        SizedBox(height: 12),
        _buildProductItem(
          imageUrl:
              'https://down-id.img.susercontent.com/file/id-11134207-7r98t-m05b8qu5b9ekc3',
          name: "Mossdoom Backpack",
          price: "Rp. 199.000",
        ),
        SizedBox(height: 12),
        _buildProductItem(
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXHHzyAhteN_fnPvzlS-HGoOprPut5Vtgspw&s',
          name: "Asus ROG Zephyrus",
          price: "Rp. 29.000.000",
        ),
        SizedBox(height: 12),
        _buildProductItem(
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXHHzyAhteN_fnPvzlS-HGoOprPut5Vtgspw&s',
          name: "Asus ROG Strix",
          price: "Rp. 25.000.000",
        ),
      ],
    );
  }

  Widget _buildProductItem({
    required String imageUrl,
    required String name,
    required String price,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xff1A1A2E),
          ),
        ),
        subtitle: Text(
          price,
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xff1A1A2E).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Color(0xff1A1A2E),
            size: 20,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
