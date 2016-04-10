declare namespace ns = "http://www.oecd.org/ns/lambda/schema#api-response";

(
xdmp:add-response-header("Access-Control-Allow-Origin", "*"),
xdmp:add-response-header("Access-Control-Request-Method", "GET"),
xdmp:add-response-header("Access-Control-Request-Credentials", "true")
,
(: 

returns an array containing two items:
    1) array of objects
        {
            "yAxis": 0,
            "name":  "manifestation",
            "data": [number of objects for each day]

    2) array of epoch seconds (corresponds to the days)

:)

xdmp:to-json((
    xdmp:to-json(
        (: returns an array of objects to be used by the series object :)
        
        for $j at $pos in ("work", "expression", "manifestation")
          let $m := map:entry("name", $j)
          let $_ := map:put($m, "yAxis", $pos - 1)
          let $_ := map:put($m, "data",
            for $i in /ns:response/ns:data/collection[@name=$j]/@count
              order by string-join(tokenize(xdmp:node-uri($i), "-")[2 to 4], "-")
              return number($i)
          )
          return $m
    ),

    (: returns an array containing the epoch seconds for the corresponding dates, to be used by the categories object:)
    
    xdmp:to-json(
    for $i in /ns:response/ns:data
      let $d := 
       (xs:dateTime(string-join(tokenize(xdmp:node-uri($i), "-")[2 to 4], "-") || "T00:00:00-00:00")
         -
       xs:dateTime("1970-01-01T00:00:00-00:00"))
         div
       xs:dayTimeDuration('PT0.001S')
        order by $d
        return $d
    )
))

)