import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:quranku/core/components/loading_screen.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/payment/presentation/bloc/in_app_purchase/in_app_purchase_bloc.dart';

import '../../../../injection.dart';

class DonationPaymentScreen extends StatelessWidget {
  const DonationPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => sl<InAppPurchaseBloc>()
            ..add(const InAppPurchaseEvent.initialize()),
          child: const _DonationPaymentScreen()),
    );
  }
}

class _DonationPaymentScreen extends StatelessWidget {
  const _DonationPaymentScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Us'),
      ),
      body: BlocConsumer<InAppPurchaseBloc, InAppPurchaseState>(
        listener: (context, state) {
          if (state.purchaseStatus.isSuccess) {
            context.showInfoToast("Thank you for your donation");
          } else if (state.purchaseStatus.isFailure) {
            context.showErrorToast("Your donation is failed");
          } else if (state.purchaseStatus.isInProgress) {
            context.showInfoToast("Your donation is in progress");
          }
        },
        builder: (context, state) {
          if (state.purchaseStatus.isInProgress) {
            return const LoadingScreen();
          }
          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: state.products
                .map(
                  (e) => ListTile(
                    title: Text(e.title),
                    subtitle: Text(e.description),
                    trailing: Text(e.price),
                    onTap: () {
                      context
                          .read<InAppPurchaseBloc>()
                          .add(InAppPurchaseEvent.purchaseNonConsumable(e));
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
