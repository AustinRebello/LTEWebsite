$(function(){
    fetch(' https://scrape.spoticord.workers.dev/?url=https://static01.nyt.com/elections-assets/pages/data/2024-02-13/results-new-york-us-house-3-special.json') 
    .then(response => response.json()) 
    .then(data => console.log(data)) 
    .catch(error => console.error(error)  );
});