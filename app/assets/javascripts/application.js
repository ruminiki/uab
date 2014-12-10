// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require autocomplete-rails
//= require jquery.maskedinput.min.js

/*

require turbolinks
require bootstrap-sprockets
require bootstrap
require_tree .

*/


jQuery(function($){
	$(".phone_number").mask("(999) 9999-9999");
	$(".date").mask("99/99/9999");
	$(".rg").mask("9.999.999-9");
	$(".cpf").mask("999.999.999-99");
	$('.dropdown-toggle').dropdown();
});

