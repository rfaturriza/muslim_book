import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quranku/features/quran/domain/entities/verses.codegen.dart';
import 'package:quranku/features/quran/presentation/bloc/audioVerse/audio_verse_bloc.dart';
import 'package:quranku/features/quran/presentation/bloc/lastRead/last_read_cubit.dart';
import 'package:quranku/features/quran/presentation/screens/components/verses_list.dart';
import 'package:quranku/features/quran/presentation/utils/tajweed_word.dart';
import 'package:quranku/features/setting/presentation/bloc/language_setting/language_setting_bloc.dart';
import 'package:quranku/features/setting/presentation/bloc/styling_setting/styling_setting_bloc.dart';

import 'verses_list_test.mocks.dart';

@GenerateMocks([
  AudioVerseBloc, 
  StylingSettingBloc, 
  LanguageSettingBloc, 
  LastReadCubit
])
void main() {
  late MockAudioVerseBloc mockAudioVerseBloc;
  late MockStylingSettingBloc mockStylingSettingBloc;
  late MockLanguageSettingBloc mockLanguageSettingBloc;
  late MockLastReadCubit mockLastReadCubit;

  setUp(() {
    mockAudioVerseBloc = MockAudioVerseBloc();
    mockStylingSettingBloc = MockStylingSettingBloc();
    mockLanguageSettingBloc = MockLanguageSettingBloc();
    mockLastReadCubit = MockLastReadCubit();

    // Setup default states
    when(mockStylingSettingBloc.state).thenReturn(const StylingSettingState());
    when(mockLanguageSettingBloc.state).thenReturn(const LanguageSettingState());
    when(mockAudioVerseBloc.state).thenReturn(const AudioVerseState());
    when(mockStylingSettingBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockLanguageSettingBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockAudioVerseBloc.stream).thenAnswer((_) => Stream.empty());
  });

  testWidgets('VersesList adds bottom padding when audio player is visible', (WidgetTester tester) async {
    // Arrange
    final audioStateWithPlayer = const AudioVerseState().copyWith(isShowBottomNavPlayer: true);
    when(mockAudioVerseBloc.state).thenReturn(audioStateWithPlayer);
    
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AudioVerseBloc>.value(value: mockAudioVerseBloc),
            BlocProvider<StylingSettingBloc>.value(value: mockStylingSettingBloc),
            BlocProvider<LanguageSettingBloc>.value(value: mockLanguageSettingBloc),
            BlocProvider<LastReadCubit>.value(value: mockLastReadCubit),
          ],
          child: Scaffold(
            body: VersesList(
              view: ViewMode.surah,
              listVerses: const [],
              tajweedWords: const [],
            ),
          ),
        ),
      ),
    );
    
    // Assert
    final scrollablePositionedList = find.byType(ScrollablePositionedList);
    expect(scrollablePositionedList, findsOneWidget);
    
    // Find the padding widget that contains bottom padding
    final paddingFinder = find.descendant(
      of: scrollablePositionedList,
      matching: find.byType(Padding),
    );
    
    // Verify that padding is applied when audio player is visible
    expect(paddingFinder, findsWidgets);
    
    // Check for the specific padding value (120.0)
    final paddingWidget = tester.widget<ScrollablePositionedList>(scrollablePositionedList);
    expect(paddingWidget.padding, isA<EdgeInsets>());
    expect((paddingWidget.padding as EdgeInsets).bottom, 120.0);
  });

  testWidgets('VersesList has no bottom padding when audio player is not visible', (WidgetTester tester) async {
    // Arrange
    final audioStateWithoutPlayer = const AudioVerseState().copyWith(isShowBottomNavPlayer: false);
    when(mockAudioVerseBloc.state).thenReturn(audioStateWithoutPlayer);
    
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AudioVerseBloc>.value(value: mockAudioVerseBloc),
            BlocProvider<StylingSettingBloc>.value(value: mockStylingSettingBloc),
            BlocProvider<LanguageSettingBloc>.value(value: mockLanguageSettingBloc),
            BlocProvider<LastReadCubit>.value(value: mockLastReadCubit),
          ],
          child: Scaffold(
            body: VersesList(
              view: ViewMode.surah,
              listVerses: const [],
              tajweedWords: const [],
            ),
          ),
        ),
      ),
    );
    
    // Assert
    final scrollablePositionedList = find.byType(ScrollablePositionedList);
    expect(scrollablePositionedList, findsOneWidget);
    
    // Check that there's no bottom padding when audio player is not visible
    final paddingWidget = tester.widget<ScrollablePositionedList>(scrollablePositionedList);
    expect(paddingWidget.padding, isA<EdgeInsets>());
    expect((paddingWidget.padding as EdgeInsets).bottom, 0.0);
  });
}