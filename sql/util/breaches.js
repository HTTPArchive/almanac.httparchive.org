// breachs.js - Paul Calvano
// Download the breaches data file from https://haveibeenpwned.com/api/v2/breaches
// 
// Usage:  wget https://haveibeenpwned.com/api/v2/breaches; node breaches.js  > breaches.tsv

const fs = require("fs");

var almanacDate = '2021-07-01';

fs.readFile("breaches", function(err, data) {
    if (err) throw err;
    const breaches = JSON.parse(data);

    console.log('date\tName\tTitle\tDomain\tBreachDate\tAddedDate\tModifiedDate\tPwnCount\tDescription\t'
    						+ 'LogoPath\tIsVerified\tIsFabricated\tIsSensitive\tIsRetired\tIsSpamList\tDataClasses');

    for (var i in breaches) {
    	console.log(
    		almanacDate
    		+ '\t' + breaches[i].Name
    		+ '\t' + breaches[i].Title
    		+ '\t' + breaches[i].Domain
    		+ '\t' + breaches[i].BreachDate
    		+ '\t' + breaches[i].AddedDate
    		+ '\t' + breaches[i].ModifiedDate
    		+ '\t' + breaches[i].PwnCount
    		+ '\t' + breaches[i].Description
    		+ '\t' + breaches[i].LogoPath
    		+ '\t' + breaches[i].IsVerified
    		+ '\t' + breaches[i].IsFabricated
    		+ '\t' + breaches[i].IsSensitive
    		+ '\t' + breaches[i].IsRetired
    		+ '\t' + breaches[i].IsSpamList
    		+ '\t' + JSON.stringify(breaches[i].DataClasses)
    	);
    }
});
