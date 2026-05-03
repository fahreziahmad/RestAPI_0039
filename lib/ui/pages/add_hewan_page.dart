import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapi_0039/logic/bloc/hewan/hewan_bloc.dart';
import 'package:restapi_0039/logic/bloc/hewan/hewan_event.dart';
import 'package:restapi_0039/logic/bloc/hewan/hewan_state.dart';

class AddHewanPage extends StatefulWidget {
  const AddHewanPage({super.key});

  @override
  State<AddHewanPage> createState() => _AddHewanPageState();
}

class _AddHewanPageState extends State<AddHewanPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jenisController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _hargaController = TextEditingController();
  final _statusController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _jenisController.dispose();
    _tanggalController.dispose();
    _hargaController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Tambah Hewan Baru",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A237E), Color(0xFFAD1457)],
              ),
            ),
          ),
          SafeArea(
            child: BlocListener<HewanBloc, HewanState>(
              listener: (context, state) {
                if (state is HewanCreatedSuccess) {
                  Navigator.pop(context);
                } else if (state is HewanError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                  );
                }
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.5),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Informasi Hewan",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25),
                            _buildGlassField(
                              controller: _namaController,
                              label: "Nama Hewan",
                              icon: Icons.pets,
                              validator: (v) => v!.isEmpty ? "Nama tidak boleh kosong" : null,
                            ),
                            const SizedBox(height: 15),
                            _buildGlassField(
                              controller: _jenisController,
                              label: "Jenis",
                              icon: Icons.category,
                              validator: (v) => v!.isEmpty ? "Jenis tidak boleh kosong" : null,
                            ),
                            const SizedBox(height: 15),
                            _buildGlassField(
                              controller: _tanggalController,
                              label: "Tanggal Lahir (YYYY-MM-DD)",
                              icon: Icons.calendar_today,
                              validator: (v) => v!.isEmpty ? "Tanggal tidak boleh kosong" : null,
                            ),
                            const SizedBox(height: 15),
                            _buildGlassField(
                              controller: _hargaController,
                              label: "Harga",
                              icon: Icons.attach_money,
                              keyboardType: TextInputType.number,
                              validator: (v) => v!.isEmpty ? "Harga tidak boleh kosong" : null,
                            ),
                            const SizedBox(height: 15),
                            _buildGlassField(
                              controller: _statusController,
                              label: "Status",
                              icon: Icons.info_outline,
                              validator: (v) => v!.isEmpty ? "Status tidak boleh kosong" : null,
                            ),
                            const SizedBox(height: 35),
                            BlocBuilder<HewanBloc, HewanState>(
                              builder: (context, state) {
                                if (state is HewanLoading) {
                                  return const Center(child: CircularProgressIndicator(color: Colors.white));
                                }
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<HewanBloc>().add(
                                              CreateHewan({
                                                'nama': _namaController.text,
                                                'jenis': _jenisController.text,
                                                'tanggal_lahir': _tanggalController.text,
                                                'harga': int.parse(_hargaController.text),
                                                'status': _statusController.text,
                                              }),
                                            );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(color: Colors.white24),
                                      ),
                                    ),
                                    child: const Text(
                                      "SIMPAN DATA",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white38),
        ),
        errorStyle: const TextStyle(color: Colors.yellowAccent),
      ),
    );
  }
}
