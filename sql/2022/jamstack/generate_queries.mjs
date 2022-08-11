// The queries in r1_jamstackishness_over_time are all very similar
// This script generated them from a template
// But the generated files are also checked in

import fs from 'node:fs/promises'
import { exit } from 'node:process'
import { DateTime } from 'luxon'

let inputFile = process.argv[2]
let dateArg = process.argv[3]
let setArg = process.argv[4]

if(!inputFile) {
    console.error("Must specify an input file")
    exit(-1)
}

let template
try {
    template = await fs.readFile(inputFile,{encoding:"utf8"})
} catch (e) {
    console.error(`Failed to read input file ${inputFile}`)
    exit(-1)
}

let dt
if (!dateArg) {
    console.error("Must specify date argument")
    exit(-1)
} else {
    dt = DateTime.fromISO(dateArg)
    if(!dt.isValid) {
        console.error(`${dateArg} was not a valid date argument`)
        exit(-1)
    }
}

if (!setArg) {
    console.error("Must specify a dataset, 'mobile' or 'desktop'")
    exit(-1)
} else {
    if (setArg != 'mobile' && setArg != 'desktop') {
        console.error(`${setArg} is not a valid dataset, specify 'mobile' or 'desktop'`)
        exit(-1)
    }
}

// everything's cool
let tableName = `${dt.toFormat('yyyy_MM_dd')}_${setArg}`
let output = template.replaceAll("{{ SAMPLE_MONTH }}",tableName)

console.log(output)
