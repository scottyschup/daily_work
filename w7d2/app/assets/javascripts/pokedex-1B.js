Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {

  var content = JST["pokemonDetail"] ({ pokemon: pokemon });
  // // Show the image
  // $detail.append('<img src="' + pokemon.get('image_url') + '"><br>');
  // // Show the attributes
  // for (var attr in pokemon.attributes) {
  //   if (pokemon.get(attr) && attr !== 'id' && attr !== 'image_url') {
  //     $detail.append(
  //       '<span style="font-weight:bold;">' + attr + ':</span> ' +
  //         pokemon.get(attr) + '<br>'
  //     );
  //   }
  // }

  this.$pokeDetail.html(content);
  var $toyList = $('ul.toys');
  // fetch toys
  pokemon.fetch( {
    success: function () {
      var toys = pokemon.toys()
      toys.each(function(toy) {
        $toyList.append(JST["toyListItem"]({ toy: toy}));
      });
    }
  });



  // Phase 2C.
  // this.$pokeDetail.append(
  //   '<span style="font-weight: bold;">Toys:</span><br>'
  // );
  // var $toys = $('<ul class="toys"></ul>');
  // this.$pokeDetail.append($toys);
  //
  // pokemon.fetch({
  //   success: (function() {
  //     this.renderToysList(pokemon.toys());
  //   }).bind(this)
  // });
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  // Phase II
  this.$toyDetail.empty();

  // Phase IB
  var $target = $(event.currentTarget);

  var pokeId = $target.data('id');
  var pokemon = this.pokes.get(pokeId);

  this.renderPokemonDetail(pokemon);
};
