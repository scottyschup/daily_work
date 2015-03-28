$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $("<div id='content-tabs'>");
  this.$el.attr("data-content-tabs", "#content-tabs");
  this.$el.after(this.$contentTabs);
  this.addInitialTabs();
  this.setupHandlers();
};

$.extend($.Tabs.prototype, {
  addInitialTabs: function(){
    this.addTab("Eskimo Dog", "The Standard American Eskimo Dog is an intelligent, energetic, playful, and affectionate companion dog. They are excellent watchdogs, and take their watchdog duties very seriously. They are naturally protective of their homes and families. They are wary of strangers and will bark to announce their arrival. However, sometimes Eskies get carried away with their barking.");
    this.addTab("Corgi", "The Pembroke Welsh Corgi is an intelligent herding breed, yet 'Pems,' as they are sometimes called, make excellent companions and family dogs as well. They are people-oriented and like to be part of family life. Playful, gentle and friendly, they are great with well-mannered young children, though they might try to herd them by nipping at their heels. The Pembroke Welsh Corgi is so intelligent, and is such a quick learner, that he really needs a job to do.");
    this.addTab("Pharaoh Hound", "The Pharaoh Hound is an active, athletic, and agile hunting hound who also makes a devoted family pet. He is friendly, playful, outgoing, and affectionate with his family, though not as demonstrative as some breeds. He is aloof but peaceful with strangers. He loves children. He gets along well with other dogs and with cats, but will chase after animals that he views as prey.");
    var breedId = "corgi";
    this.$activeTab = this.$contentTabs.find('#'+breedId).addClass("active");
    this.$el.find('li a[href=#'+breedId+']').addClass("active");
  },

  addTab: function(breed, breedInfo){
    var breedId = breed.toLowerCase().replace(/ /g,'');
    var tabDiv = $("<div class='tab-pane' id='"+breedId+"'>");
    this.$contentTabs.append(tabDiv);
    tabDiv.append("<p>"+breedInfo+"</p>");
    var listItem = $("<li><a href='#" + breedId + "'>" + breed + "</a></li>");
    this.$el.append(listItem);
  },

  activate: function(breedId) {
    var $activeParts = $('.active');
    var that = this;
    $activeParts.addClass("transitioning").removeClass("active");
    this.$el.find('li a[href=#'+breedId+']').addClass("active");

    $activeParts.one('transitionend', function(){
      $activeParts.removeClass('transitioning');
      that.$activeTab = that.$contentTabs.find('#'+breedId).addClass("active transitioning");
      setTimeout(function() {
        that.$activeTab.removeClass("transitioning");
      }, 0);
    });

  },

  clickTab: function(ev) {
    ev.preventDefault();
    var breedId = $(ev.currentTarget).attr('href').slice(1);
    this.activate(breedId);
  },

  setupHandlers: function() {
    this.$el.on('click', 'a', this.clickTab.bind(this));
  }
});

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
