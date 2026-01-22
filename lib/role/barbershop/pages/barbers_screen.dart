import 'package:crown_cuts/role/barbershop/barbers/logic/barbers_provider.dart';
import 'package:crown_cuts/role/barbershop/pages/create_barber_screen.dart';
import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:crown_cuts/role/barbershop/widget/barber_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarbersScreen extends StatefulWidget {
  const BarbersScreen({super.key});

  @override
  State<BarbersScreen> createState() => _BarbersScreenState();
}

class _BarbersScreenState extends State<BarbersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BarbersProvider>().fetchMyBarbers();
    });
  }

  Future<void> _navigateToCreateBarber() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const CreateBarberScreen()),
    );

    // Refresh list if a barber was created
    if (result == true && mounted) {
      context.read<BarbersProvider>().fetchMyBarbers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BarbershopTheme.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: BarbershopTheme.heroGradient,
              ),
            ),
          ),
          Positioned(
            top: -30,
            right: -20,
            child:
                _blurCircle(BarbershopTheme.accent.withValues(alpha: 0.22)),
          ),
          Positioned(
            bottom: -40,
            left: -10,
            child: _blurCircle(BarbershopTheme.sea.withValues(alpha: 0.18)),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your Team',
                                style: BarbershopTheme.display()),
                            Text('Manage barbers and services',
                                style: BarbershopTheme.body()),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _navigateToCreateBarber(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: BarbershopTheme.forest,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Text('Add Barber',
                                  style: BarbershopTheme.body(
                                      color: Colors.white)),
                              const SizedBox(width: 6),
                              const Icon(Icons.add,
                                  color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: BarbershopTheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: BarbershopTheme.line),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: BarbershopTheme.muted),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search barbers, services...",
                              hintStyle: BarbershopTheme.body(),
                              border: InputBorder.none,
                            ),
                            style: BarbershopTheme.body(
                                color: BarbershopTheme.ink),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: BarbershopTheme.chip,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.tune,
                              color: BarbershopTheme.ink, size: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _chip('All'),
                      _chip('Top rated'),
                      _chip('Available'),
                      _chip('New talent'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Consumer<BarbersProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: BarbershopTheme.forest,
                          ),
                        );
                      }

                      if (provider.errorMessage != null) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: BarbershopTheme.muted,
                                  size: 48,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  provider.errorMessage!,
                                  style: BarbershopTheme.body(),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => provider.fetchMyBarbers(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: BarbershopTheme.forest,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Retry',
                                      style: BarbershopTheme.body(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (provider.barbers.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.people_outline,
                                color: BarbershopTheme.muted,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No barbers yet',
                                style: BarbershopTheme.title(),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Add your first barber to get started',
                                style: BarbershopTheme.body(),
                              ),
                            ],
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () => provider.fetchMyBarbers(),
                        color: BarbershopTheme.forest,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: provider.barbers.length,
                          itemBuilder: (context, index) {
                            return BarberCard(
                              barber: provider.barbers[index],
                              index: index,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: BarbershopTheme.chip,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(label, style: BarbershopTheme.body()),
    );
  }

  Widget _blurCircle(Color color) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}