// TEMP: Populate ".sotr-states"
const RaceLean = Object.freeze({
    TILT: 0,
    LEAN: 1,
    LIKELY: 2,
    SAFE: 3
});

class SotrCandidate {
    constructor(lastName, colors, index, imageUrl){
        this.lastName = lastName;
        this.colors = colors;
        this.index = index;
        this.imageUrl = imageUrl;

        this.votes = 0;
    }
    getLeans(){
        return this.colors;
    }
    getLean(num){
        return this.colors[num];
    }
}

class SotrState {
    constructor(postalCode, electoralVotes, candidate, lean, smallText){
        this.postalCode = postalCode;
        this.electoralVotes = electoralVotes;
        this.candidate = candidate;
        this.lean = lean;
        this.smallText = smallText | false;
    }
}

function populateSotr(sotr, candidates, states){

    states.sort(function(a,b) {
        // Sort by candidate
        if(a.candidate.index < b.candidate.index){
            return -1;
        } else if (a.candidate.index > b.candidate.index){
            return 1;
        }

        // If we are on the first candidate, all sort orders are reversed.
        var m = a.candidate.index == 0 ? -1 : 1;

        // Sort by lean
        if(a.lean < b.lean){
            return -1*m;
        } else if (a.lean > b.lean){
            return 1*m;
        }

        // Sort by size
        if(a.electoralVotes < b.electoralVotes){
            return -1*m;
        } else if (a.electoralVotes > b.electoralVotes){
            return 1*m;
        }

        return 0;
    });

    for(var state of states){
        var candidate = state.candidate;

        var object = $(`
        <div class='sotr-state' data-sotrState='${state.postalCode}' style='background-color: ${candidate.getLean(state.lean)}'>

            <span>${state.postalCode}</span>

        </div>
        `);

        if(state.smallText){
            object.addClass("sotr-small");
        }

        object.appendTo($(sotr).find(".sotr-states"));

        candidate.votes += state.electoralVotes;
    }

    $(sotr).find(".sotr-candidate:nth-of-type(1) .sotr-background").append(
        `<img src='${CANDIDATES[0].imageUrl}'/>`
    );

    $(sotr).find(".sotr-candidate:nth-of-type(3) .sotr-background").append(
        `<img src='${CANDIDATES[2].imageUrl}'/>`
    );

    // Set candidate texts
    [candidates[0], candidates[2]].forEach((candidate) => {

        var object = $(sotr).find(`.sotr-candidate:nth-of-type(${candidate.index+1})`);

        object.find(".sotr-candName").text(candidate.lastName);
        object.find(".sotr-candVotes").text(candidate.votes);

        if(candidate.votes > 270){
            // Look through the states to find the tipping point. If we are on the candidate on the right, look from the end of the list
            // to the start. If we are on the left, look from the left to the end.

            var start = candidate.index == 0 ? 0 : states.length-1;
            var end = states.length-1 - start;
            var inc = candidate.index == 0 ? 1 : -1;

            var v = 0;
            for(var i = start; i != end; i += inc){
                var state = states[i];
                v += state.electoralVotes;

                if (v >= 270){
                    $(sotr).find(`div[data-sotrState='${state.postalCode}']`).addClass("sotr-tipping")
                    break;
                }
            }

        }

    });

    setupBar(sotr, candidates, states);

}

function setupBar(sotr, candidates, states){

    var bar = $(sotr).find(".sotr-bar");

    var barColors = {};
    //var colorOrder = [];
    var total = 0;

    for(var state of states){

        var candidate = state.candidate;
        var color = candidate.getLean(state.lean);

        if(!(color in barColors)) barColors[color] = 0;
        barColors[color] += state.electoralVotes;
        total += state.electoralVotes;

        //if(!(colorOrder.includes(color))) colorOrder.push(color);

    }
    var totalPct = 0;
    var strings = [];
    for(var color in barColors){

        // Push left half of this bar
        strings.push(`${color} ${totalPct*100}%`);

        // Calculate the new total percent of the bar we have reached
        totalPct = (barColors[color] / total) + totalPct;
        barColors[color] = totalPct;

        // Push right half of this bar
        strings.push(`${color} ${totalPct*100}%`);
    }

    // Set the background
    bar.css("background", `linear-gradient(to right, ${strings.join(', ')})`)

}