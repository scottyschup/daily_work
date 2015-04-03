Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li.poke-list-item": "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    this.$el.append(JST['pokemonListItem']({ pokemon: pokemon} ));
  },

  refreshPokemon: function (callback, options) {
    var that = this;
    this.collection.fetch({
      success: function () {
        that.render();
        callback && callback();
      }
    });

    return this.collection;
  },

  render: function () {
    var that = this;
    this.$el.empty();
    this.collection.each(function (pokemon) {
      that.addPokemonToList(pokemon);
    });

    return this;
  },

  selectPokemonFromList: function (event) {
    event.preventDefault();
    var pokeId = $(event.currentTarget).data('id');
    Backbone.history.navigate("pokemon/" + pokeId, { trigger: true });

    // var pokemon = this.collection.findWhere({id: pokeId});
    // var pokemonDetail = new Pokedex.Views.PokemonDetail({ model: pokemon });
    // $("#pokedex .pokemon-detail").html(pokemonDetail.$el);
    // pokemonDetail.refreshPokemon();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click li.toy-list-item": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    var that = this;
    options.model.fetch({
      success: function () {
        that.render();
        options.success && options.success();
      }
    });
  },

  render: function () {
    var that = this;
    this.$el.empty();
    this.$el.html(JST["pokemonDetail"]({ pokemon: this.model }));
    this.model.toys().each(function (toy) {
      that.$el.append(JST['toyListItem']({ toy: toy }));
    });

    return this;
  },

  selectToyFromList: function (event) {
    event.preventDefault();
    var toyId = $(event.currentTarget).data("id");
    // var toy = this.model.toys().findWhere({ id: toyId });
    // var toyDetail = new Pokedex.Views.ToyDetail({ model: toy });
    // $("#pokedex .toy-detail").html(toyDetail.$el);
    // toyDetail.render();

    var pokemonId = $(event.currentTarget).data("pokemon-id");

    Backbone.history.navigate("pokemon/" + pokemonId + "/toys/" + toyId , {trigger: true});
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    this.$el.empty();
    this.$el.html(JST['toyDetail']({ toy: this.model, pokes: [] }));

    return this;
  }
});

// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
