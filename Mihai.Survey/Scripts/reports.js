
// Total Chart
$(function () {

    $.plot($("#flot-total-chart"), [totalData], {
        series: {
            bars: {
                show: true,
                barWidth: 0.6,
                align: "center",
                label: {
                    show: true
                }
            }
        },
        legend: {
            show: false
        },
        xaxis: {
            mode: "categories",
            tickLength: 0
        }
    });
});


//Pie Charts
$(function () {

    var pieOptions = {
        series: {
            pie: {
                show: true,
                radius: 1,
                label: {
                    show: true,
                    radius: 2 / 3,
                    formatter: function (label, series) {
                        return '<div style="font-size:12pt;text-align:center;padding:2px;color:white;">' + series.data[0][1] + '</div>';
                    },
                    threshold: 0.1
                }
            }
        },
        legend: {
            show: true
        }
    }
 
    for (i = 0; i < reportsData.length; i++)
    {
        var control = $("#flot_chart_" + reportsData[i].QuestionId);
        var localData = reportsData[i].Answers;

        if (reportsData[i].QuestionType == 3)
        {
            reportsData[i].Answers[0].data = reportsData[i].CommentsCount;
        }
        
        $.plot(control, localData, pieOptions);
        
    }
});
