import 'package:rickmorty/domain/entities/character.dart';
import 'package:rickmorty/domain/repositories/character_repository.dart';

class GetAllCharacters {
  GetAllCharacters({
    required CharacterRepository repository,
  }) : _repository = repository;

  final CharacterRepository _repository;

  Future<List<Character>> call({int page = 0, bool forceReload = false}) async {
    final list = await _repository.getCharacters(page: page, forceReload: forceReload);
    return list;
  }
}
