sampleCron = ()->
  console.log "Cron jOb executind"

SyncedCron.add
  name: 'Crunch some important numbers for the marketing department'
  schedule: (parser) ->
    # parser is a later.parse object
    parser.text 'every 2 seconds'
  job: ->
    numbersCrunched = sampleCron()
    numbersCrunched

