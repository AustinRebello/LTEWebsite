// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

console.log("Hello World APPLICATIONS");


function determineFillCounties(democrat, republican) {
    gap = democrat-republican;
    if(gap >= 15){
        return "#0047FF";
    } else if (gap >= 7.5){
        return "#5F85FF";
    } else if (gap >= 3){
        return "#9FB5FF";
    } else if (gap > 0){
        return "#B2B8D1";
    } else if (gap = 0){
        return "#8f96a3";
    } else if (gap > -3){
        return "#CFAAA2";
    } else if (gap > -7.5){
        return "#FFA9B6";
    } else if (gap > -15){
        return "#FF7392";
    } else {
        return "#FF0052";
    }
};

function determineFillRace(democrat, republican, called) {
    gap = democrat-republican;
    console.log("Hello World APPLICATIONS");
    if(gap >= 15){
        return "#0047FF";
    } else if (gap >= 7.5){
        return "#5F85FF";
    } else if (gap >= 3){
        return "#9FB5FF";
    } else if (gap > 0){
        return "#B2B8D1";
    } else if (gap = 0){
        return "#8f96a3";
    } else if (gap > -3){
        return "#CFAAA2";
    } else if (gap > -7.5){
        return "#FFA9B6";
    } else if (gap > -15){
        return "#FF7392";
    } else {
        return "#FF0052";
    };
};