class ResultCandidate {

    constructor(firstName, lastName, imageUrl, party, color, votes){
        this.firstName = firstName;
        this.lastName = lastName;
        this.party = party;
        this.imageUrl = imageUrl;

        this.color = color;
        this.votes = votes;
    }

}

class ResultMapData {

    constructor(){
        // UNIMPLEMENTED
    }

}

class ResultData {
    constructor(raceName, totalVotes, pctReporting, projectedWinner){

        this.raceName = raceName;
        this.totalVotes = totalVotes;
        this.pctReporting = pctReporting;
        this.projectedWinner = projectedWinner;

    }
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

const DEFAULT_COLOR = "#202020";

function populateResults(element, candidates, data, mapData){

    var element = $(element);

    // Do the header
    populateResultsHeader(element, data);
    populateResultsCandidates(element, candidates, data);
    populateResultsReportingBar(element, data);

}

function populateResultsReportingBar(element, data){

    var reportingElem = $(element).find(".results-bar");

    var pctReporting = data.pctReporting;
    reportingElem.find(".results-reporting-progress").css("width", pctReporting+"%");
    reportingElem.find(".results-reporting-bar span").text(`${Math.round(pctReporting)}% Reporting`);

    var expectedVotes = Math.round((data.totalVotes / pctReporting) * 100)

    expectedVotes = Math.round(expectedVotes/100)*100
    // TODO: Add timestamp
    reportingElem.find("p[data-type='expectedVotes']").text(`~${numberWithCommas(expectedVotes)} votes expected`);
}

function populateResultsCandidates(element, candidates, data){

    var table = $(element).find(".results-table");

    // Remove existing entries
    table.find("tr.results-candidateTable").remove();

    candidates = candidates.sort((a, b) => {
        if(a.votes < b.votes) return 1;
        if(a.votes > b.votes) return -1;
        return 0;
    })

    for(var candidate of candidates){

        var percent = ((candidate.votes / data.totalVotes)*100).toFixed(2) + "%";
        var votes = numberWithCommas(candidate.votes);

        $(`<tr class='results-candidateTable' style='background-color: ${candidate.color}'>
            <td></td>
            <td data-type='name'>
                <span>${candidate.firstName} ${candidate.lastName}</span><br/>
                <span><i>${candidate.party}</i></span>
            </td>
            <td data-type='percent'>${percent}</td>
            <td data-type='votes'>${votes}</td>
        </tr>
        `).appendTo(table);

    }



}

function populateResultsHeader(element, data){
    var header = $(element).find(".results-header");

    var headerBgColor = DEFAULT_COLOR;
    var headerName = "Not Called",
        headerText = "This race has not been called yet.",
        headerPct = "",
        headerImage = "https://imagedelivery.net/ilUJ6Cy8nNz2i8r1DPuCPg/e9b30734-2df1-4072-0668-817972697d00/public";
        headerVotes = "";

    if(data.projectedWinner){
        headerBgColor = data.projectedWinner.color;
        headerName = data.projectedWinner.lastName;
        headerText = "Projected Winner";
        headerImage = data.projectedWinner.imageUrl;
        
        headerPct = `${((data.projectedWinner.votes / data.totalVotes)*100).toFixed(2)}%`;
        headerVotes = numberWithCommas(data.projectedWinner.votes);

    }

    header.css("background", `linear-gradient(45deg, #111111 0%, ${headerBgColor} 100%)`);
    header.find("img").attr("src", headerImage);

    var candNameElem = header.find(".results-candidate-name");
    candNameElem.find("h2").text(headerName);
    candNameElem.find("p").text(headerText);

    var candTotalsElem = header.find(".results-candidate-totals");
    candTotalsElem.find("h2").text(headerPct);
    candTotalsElem.find("p").text(headerVotes);
}