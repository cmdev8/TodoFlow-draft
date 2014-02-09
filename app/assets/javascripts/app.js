function register_event_handlers() {
    $(".new-task-button").unbind();
    $(".new-task-button").click(function(){
    var list_id = $(this).data("list-id");
    var form = $("#new_task_form_"+list_id);
    if(form.css("display") == "none") {
      form.show();
    } else {
      form.hide();
    }
  });

  $(".new-task-submit-button").unbind();
  $(".new-task-submit-button").click(function() {
    var list_id = $(this).data("list-id");
    var form = $("#new_task_form_"+list_id);
    var content_field = $("#new_task_content_"+list_id);
    var container = $("#list-"+list_id);

    form.html("Loading..");

    data = {
      list: list_id,
      content: content_field.val()
    };

    $.post("/list_items", data, function(response){
      container.html(response);
      register_event_handlers();
    });
  });

  $(".task-done-button").unbind();
  $(".task-done-button").click(function(){
    event.preventDefault();
    var list_id = $(this).data("list-id");
    var item_id = $(this).data("item-id");
    var container = $("#list-"+list_id);
    $.get("/list_items/"+item_id+"/done", function(response){
      $(".top-list-item-"+item_id).remove();
      container.html(response);
      register_event_handlers();
    });
  });

  $(".deadline-button").unbind();
  $(".deadline-button").click(function(){
    event.preventDefault();
    var item_id = $(this).data("item-id");
    $("#list_item_deadline_"+item_id).show();
  });

  $(".task-deadline-submit-button").unbind();
  $(".task-deadline-submit-button").click(function(){
    event.preventDefault();
    var item_id = $(this).data("item-id");
    $.get("/list_items/"+item_id+"/set_deadline", {deadline: $(this).prev().val()}, function(response){
      document.location = document.location
      // $("#list_item_deadline_"+item_id).hide();
    });
  });

  $(".start-button").unbind();
  $(".start-button").click(function(){
    event.preventDefault();
    var item_id = $(this).data("item-id");
    $.get("/list_items/"+item_id+"/start", {deadline: $(this).prev().val()}, function(response){
      document.location = document.location
    });
  });

  $(".timer-start-button").unbind();
  $(".timer-start-button").click(function(){
    event.preventDefault();
    var item_id = $(this).data("item-id");
    $.get("/list_items/"+item_id+"/timer_start", function(response){
      $(".timer-start-"+item_id).hide();
      $(".timer-stop-"+item_id).show();
    });
  });

  $(".timer-stop-button").unbind();
  $(".timer-stop-button").click(function(){
    event.preventDefault();
    var item_id = $(this).data("item-id");
    $.get("/list_items/"+item_id+"/timer_stop", function(response){
      $(".timer-stop-"+item_id).hide();
      $(".timer-start-"+item_id).show();
    });
  });  

  $(".datepicker").datepicker({
    format: "yyyy-mm-dd",
    todayBtn: "linked",
    language: "hu"
  });
}

$(document).ready(function(){
  register_event_handlers();
});