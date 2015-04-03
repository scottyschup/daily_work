Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var newPoke = new Pokedex.Models.Pokemon(attrs);
  var that = this;
  newPoke.save({}, {
    success: function () {
      that.pokes.add(newPoke);
      that.addPokemonToList(newPoke);
      callback(newPoke);
    },
    error: function () {
      alert("FAIL");
    }
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var attrs = $(event.currentTarget).serializeJSON();
  this.createPokemon(attrs.pokemon, this.renderPokemonDetail.bind(this));
};
