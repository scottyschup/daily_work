Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $toyLi = $('<li class=toy-list-item data-toy-id=' + toy.get('id') +
    ' data-pokemon-id=' + toy.get('pokemon_id') + '>')
    .append(toy.get('name') + ' ')
    .append(toy.get('happiness') + ' ')
    .append(toy.get('price'));
  $('ul.toys').append($toyLi);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $toyDetailDiv = $('<div class=detail>');
  $toyDetailDiv.append($('<img src=' + toy.get('image_url') + '>'));
  var $toyDetailUl = $('<ul>');

  $toyDetailDiv.append($toyDetailUl);
  for (var attribute in toy.attributes) {
    var $newDetailsLi = $('<li>');
    $newDetailsLi.append(toy.get(attribute));
    $toyDetailUl.append($newDetailsLi);
  }

  this.$toyDetail.html($toyDetailDiv);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var pokeId = $(event.currentTarget).data('pokemon-id');
  var toyId = $(event.currentTarget).data('toy-id');
  var pokemon = this.pokes.findWhere({ id: pokeId });
  var toy = pokemon.toys().findWhere({ id: toyId });
  this.renderToyDetail(toy);
};
