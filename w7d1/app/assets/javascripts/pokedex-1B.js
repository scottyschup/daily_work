Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $pokeDetailDiv = $('<div class=detail>');
  $pokeDetailDiv.append($('<img src=' + pokemon.get('image_url') + '>'));
  var $pokeDetailUl = $('<ul>');

  $pokeDetailDiv.append($pokeDetailUl);
  for (var attribute in pokemon.attributes) {
    var $newDetailsLi = $('<li>');
    $newDetailsLi.append(pokemon.get(attribute));
    $pokeDetailUl.append($newDetailsLi);
  }

  var $pokeToysUl = $('<ul class="toys">');

  this.$pokeDetail.html($pokeDetailDiv);
  this.$pokeDetail.append($pokeToysUl);

  pokemon.toys().each( function (toy) {
    this.addToyToList(toy);
  }.bind(this));
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var pokeId = $(event.currentTarget).data('id');
  var pokemon = this.pokes.findWhere({ id: pokeId });
  var that = this;
  pokemon.fetch({
    success: function () {
      that.renderPokemonDetail(pokemon);
    }
  });
};
