$(document).ready(function() {
  var default_params = {};

  if ($("body").data("lang") == "ru") {
    default_params["language"] = {
      url: "//cdn.datatables.net/plug-ins/1.10.19/i18n/Russian.json"
    };
  }

  $("#currencies").DataTable(
    Object.assign({}, default_params, {
      paging: false,
      searching: false
    })
  );

  $("table[data-currency]").each(function() {
    $(this).DataTable(
      Object.assign({}, default_params, {
        searching: false,
        ordering: false,
        pagingType: "full",
        order: [[3, "desc"]]
      })
    );
  });

  $("#currencies tr[data-currency]").click(function() {
    $(".currencies_list").hide();
    $(".currency_info#" + $(this).data("currency")).show();
  });

  $("button[data-back]").click(function(e) {
    e.preventDefault();
    $(".currencies_list").show();
    $(".currency_info#" + $(this).data("back")).hide();
  });

  $("form[data-currency]").submit(function(e) {
    e.preventDefault();
    var self = this;
    var data = {
      currency_id: $(this).data("currency"),
      price: $(this)
        .find("[name=price]")
        .val(),
      supply: $(this)
        .find("[name=supply]")
        .val()
    };

    $(self)
      .find("button[type=submit]")
      .addClass("loading");

    $(self)
      .find(".message")
      .addClass("hidden");

    $.ajax({
      url: "/",
      type: "POST",
      data: JSON.stringify(data),
      contentType: "application/json; charset=utf-8",
      dataType: "json"
    })
      .done(function() {
        window.location.reload();
      })
      .fail(function() {
        $(self)
          .find(".message")
          .removeClass("hidden");
      })
      .always(function() {
        $(self)
          .find("button[type=submit]")
          .removeClass("loading");
      });
  });

  $("div[data-chart]").each(function() {
    var data = JSON.parse(
      $(this)
        .find(".hidden")
        .text()
    );

    new Chart($(this).find("canvas"), {
      type: "line",
      data: {
        labels: new Array(data.length),
        datasets: [
          {
            label: "Price",
            data: data
          }
        ]
      },
      options: {
        labels: { display: false },
        legend: { display: false },
        scales: {
          yAxes: [
            {
              ticks: {
                display: false
              }
            }
          ],
          xAxes: [
            {
              ticks: {
                display: false
              }
            }
          ]
        }
      }
    });
  });
});
