$(document).ready(function() {
  $(".add_field_button").change(function(e){ //on add input button click
    e.preventDefault();
      if($(".add_field_button").val() === "Add an Artist") {
        $(".input_fields_wrap").append('<div><input type="text" class="remove_wrap" name="artist_name" id="btn_admin" placeholder="new artist"/></div>');
      } else {
        $(".remove_wrap").remove();
      }
    });

  $(".add_field_category").change(function(e){ //on add input button click
    e.preventDefault();
      if($(".add_field_category").val() === "Add a Category") {
        $(".input_fields_category_wrap").append('<div><input type="text" class="remove_category" name="category_name" id="btn_admin" placeholder="new category"/></div>');
      } else {
        $(".remove_category").remove();
      }
    });

    $(".add_field_venue").change(function(e){ //on add input button click
      e.preventDefault();
        if($(".add_field_venue").val() === "Add a Venue") {
          $(".input_fields_venue_wrap").append('<div><input type="text" class="remove_venue" name="venue_name" id="btn_admin" placeholder="new venue name"/></div>'
            +
          '<div><input type="text" class="remove_venue" name="venue_address" id="btn_admin" placeholder="new venue address"/></div>'
            +
          '<div><input type="text" class="remove_venue" name="venue_image" id="btn_admin" placeholder="new venue image url"/></div>'
            +
          '<div><input type="hidden" name="yo" id="yo" value=2/></div>'
        );

        } else {
          $(".remove_venue").remove();
        }
      });
  })
