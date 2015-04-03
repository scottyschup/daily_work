Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var newPoke = $('<li class=poke-list-item data-id=' + pokemon.get('id') + '>')
    .append(pokemon.get('name'))
    .append(': ' + pokemon.get('poke_type'));
  this.$pokeList.append(newPoke);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var that = this;

  this.pokes.fetch({
    success: function (pokes) {
      pokes.each(function (poke) {
        that.addPokemonToList(poke);
      });
    }
  });
};
