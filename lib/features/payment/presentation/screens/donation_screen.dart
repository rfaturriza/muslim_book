import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:quranku/core/components/loading_screen.dart';
import 'package:quranku/core/components/spacer.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';
import 'package:quranku/features/payment/presentation/bloc/in_app_purchase/in_app_purchase_bloc.dart';
import 'package:quranku/features/payment/presentation/bloc/midtrans/midtrans_bloc.dart';
import 'package:quranku/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/components/button_drawer.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../injection.dart';
import '../../../quran/presentation/screens/components/app_bar_detail_screen.dart';

class DonationPaymentScreen extends StatelessWidget {
  const DonationPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<MidtransBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<InAppPurchaseBloc>()
              ..add(const InAppPurchaseEvent.initialize()),
          ),
        ],
        child: const _DonationPaymentScreen(),
      ),
    );
  }
}

class _DonationPaymentScreen extends StatelessWidget {
  const _DonationPaymentScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailScreen(title: LocaleKeys.supportUs.tr()),
      body: BlocConsumer<InAppPurchaseBloc, InAppPurchaseState>(
        listener: (context, state) {
          if (state.purchaseStatus.isSuccess) {
            context.showInfoToast(LocaleKeys.thankYouForYourSupport.tr());
          } else if (state.purchaseStatus.isFailure) {
            context.showErrorToast(LocaleKeys.donationFailedMessage.tr());
          } else if (state.purchaseStatus.isInProgress) {
            context.showInfoToast(LocaleKeys.donationInProgressMessage.tr());
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ButtonDrawer(
            title: LocaleKeys.sincerelyDonation.tr(),
            onTap: () {
              showBottomSheet(context);
            },
            icon: Icons.payments_rounded,
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      useSafeArea: true,
      backgroundColor: defaultColor.shade500,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      barrierColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<MidtransBloc>(),
        child: const _InputAmountForm(),
      ),
    );
  }
}

class _InputAmountForm extends StatelessWidget {
  const _InputAmountForm();

  @override
  Widget build(BuildContext context) {
    final amountController = TextEditingController();
    return BlocProvider(
      create: (context) => sl<MidtransBloc>(),
      child: BlocListener<MidtransBloc, MidtransState>(
        listenWhen: (p, c) => p.transaction != c.transaction,
        listener: (context, state) {
          if (state.transaction?.isRight() == true) {
            final transaction = state.transaction?.asRight();
            if (transaction != null) {
              launchUrl(
                Uri.parse(transaction.redirectUrl),
                mode: LaunchMode.inAppBrowserView,
              );
            } else {
              context.showErrorToast(LocaleKeys.donationFailedMessage.tr());
            }
          } else if (state.transaction?.isLeft() == true) {
            context.showErrorToast(LocaleKeys.donationFailedMessage.tr());
          }
        },
        child: BlocBuilder<MidtransBloc, MidtransState>(
          builder: (context, state) {
            if (state.status.isInProgress) {
              return const LoadingScreen();
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.amountDonation.tr(),
                      hintText: LocaleKeys.enterAmountDonation.tr(),
                      labelStyle: context.textTheme.bodyMedium?.copyWith(
                        color: defaultColor.shade50,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: defaultColor.shade50,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          amountController.clear();
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: defaultColor,
                        ),
                      ),
                      hintStyle: context.textTheme.bodyMedium?.copyWith(
                        color: defaultColor.shade50,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const VSpacer(),
                  ButtonDrawer(
                    title: LocaleKeys.donate.tr(),
                    onTap: () {
                      final amount =
                          int.tryParse(amountController.text) ?? 100000;
                      context.read<MidtransBloc>().add(
                            MidtransEvent.purchaseEvent(amount),
                          );
                    },
                    icon: Icons.payments_rounded,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
