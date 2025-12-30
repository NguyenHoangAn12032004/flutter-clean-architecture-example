import 'package:mocktail/mocktail.dart';
import 'package:rickmorty/domain/entities/character.dart';
import 'package:rickmorty/domain/repositories/character_repository.dart';
import 'package:rickmorty/domain/usecases/get_all_characters.dart';
import 'package:test/test.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late GetAllCharacters getAllCharacters;
  late MockCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    getAllCharacters = GetAllCharacters(repository: mockCharacterRepository);
  });

  group('GetAllCharacters', () {
    test('call should return a list of characters', () async {
      const page = 0;
      final characters = [
        Character(id: 1, name: 'Rick Sanchez'),
        Character(id: 2, name: 'Morty Smith'),
      ];

      when(() => mockCharacterRepository.getCharacters(page: page))
          .thenAnswer((_) async => characters);

      final result = await getAllCharacters.call(page: page);

      expect(result, equals(characters));

      verify(() => mockCharacterRepository.getCharacters(page: page)).called(1);
      verifyNoMoreInteractions(mockCharacterRepository);
    });
  });
}
