String baseUrl = 'http://192.168.1.6:5001';

//AUTH
String urlRegister = '$baseUrl/user/register';
String urlLogin = '$baseUrl/user/login';

//Crud sepatu
String inputSepatu = '$baseUrl/sepatu/create';
String editSepatu = '$baseUrl/sepatu/edit';
String getAllSepatu = '$baseUrl/sepatu/getAll';
String hapusSepatu = '$baseUrl/sepatu/hapus';
String getByIdSepatu = '$baseUrl/sepatu/getbyid';

//Transaksi
String createTransaksi = '$baseUrl/transaksi/create';
String getTransaksiUser = '$baseUrl/transaksi/getbyiduser';
String getTransaksiUserLimit = '$baseUrl/transaksi/getbyiduserlimit';
String uploadBuktiPembayaran = '$baseUrl/transaksi/upload-bukti';
