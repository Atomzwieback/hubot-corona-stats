module.exports = (robot) ->
  robot.hear /coronastatsaug/i, (res) ->
    robot.http("https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?f=json&where=GEN%3D%27Augsburg%27&outFields=OBJECTID%2Cdeath_rate%2Ccases%2Cdeaths%2Ccases_per_100k%2Ccases_per_population%2Ccounty%2Clast_update%2>
    .get() (err, response, body) ->
      if response.statusCode isnt 200
          res.send "Request didn't come back HTTP 200 :("
          return
      data = JSON.parse body

      answer = "Die aktuellen Coronazahlen für Augsburg lauten wie folgt:\n\nGilt für: " + data.features[0].attributes.county + "\n\n Gesamt Erkrankungen: " + data.features[0].attributes.cases.toFixed(2) + "\n Gesamt Tode: " + data.features[0].attributes.deaths.toFixed(2>
      "\n Fälle auf 100.000 Einwohner der letzen 7 Tage: " + data.features[0].attributes.cases7_per_100k.toFixed(2) + "\n Fälle auf 100.000 Einwohner der letzen 7 Tage Bayern Durschnitt: " +  data.features[0].attributes.cases7_bl_per_100k.toFixed(2) + "\n Todesrate auf 1>
      "\n\nGilt für: " + data.features[1].attributes.county + "\n\n Gesamt Erkrankungen: " + data.features[1].attributes.cases.toFixed(2) + "\n Gesamt Tode: " + data.features[1].attributes.deaths.toFixed(2) + "\n Fälle auf 100.000 Einwohner gesamt: " + data.features[1].a>
      "\n Fälle auf 100.000 Einwohner der letzen 7 Tage: " + data.features[1].attributes.cases7_per_100k.toFixed(2) + "\n Fälle auf 100.000 Einwohner der letzen 7 Tage Bayern Durschnitt: " +  data.features[1].attributes.cases7_bl_per_100k.toFixed(2) + "\n Todesrate auf 1>
      "\n\n\n Alle hier angezeigten Daten stammen vom RKI (Robert Koch Institut)."
      res.send answer
