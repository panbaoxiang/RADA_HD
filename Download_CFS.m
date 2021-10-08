var={"prmsl", "q925", "q850", "q500", "z1000", "z850", "tmp2m","prate"};
day={"05","10","15","20","25","30"};
hour={"00","06","12","18"};
year=Map[ToString,Range[2011,2020]];
month={"01","02","03","04","05","06","07","08","09","10","11","12"};

script=Flatten[Table[{"wget -nc https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/first-look/6-hourly-time-series-9-month/tmp2m/200407/tmp2m.200407"<>day[[i]]<>hour[[j]]<>".time.grb2",
"wget -nc https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/first-look/6-hourly-time-series-9-month/prate/200407/prate.200407"<>day[[i]]<>hour[[j]]<>".time.grb2",
"wget -nc https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/high-prioroty-subset/time-series-9-month/2004/200407/prmsl.200407"<>day[[i]]<>hour[[j]]<>".time.grb2",
"wget -nc https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/high-prioroty-subset/time-series-9-month/2004/200407/q925.200407"<>day[[i]]<>hour[[j]]<>".time.grb2",
"wget -nc https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/high-prioroty-subset/time-series-9-month/2004/200407/q850.200407"<>day[[i]]<>hour[[j]]<>".time.grb2",
"wget -nc https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/high-prioroty-subset/time-series-9-month/2004/200407/q500.200407"<>day[[i]]<>hour[[j]]<>".time.grb2",
"wget -nc https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/high-prioroty-subset/time-series-9-month/2004/200407/z1000.200407"<>day[[i]]<>hour[[j]]<>".time.grb2",
"wget -nc https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/high-prioroty-subset/time-series-9-month/2004/200407/z850.200407"<>day[[i]]<>hour[[j]]<>".time.grb2"},
{i,Length[day]},{j,Length[hour]}]];

Export["/Users/pan11/Documents/SADAN/Data/Forecast/forecast_realtime.sh",script,"Table"]



years=Range[1982,2011];
time=Flatten[Table[Block[{tempt=Flatten[Map[Table[DatePlus[#,{h,"Hour"}],{h,{0,6,12,18}}]&,Table[DatePlus[{year,1,1,0},day*5],{day,0,72}]],1]},
	If[LeapYearQ[{year,1,1}],Map[If[#[[2]]>2,DatePlus[#,1],#]&,tempt],tempt]],{year,years}],1];
 
script=Flatten[Table[DateString[time[[t]],
{"wget -nc https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/high-prioroty-subset/time-series-9-month/",
"Year","/","Year","Month","/",var[[k]]<>".","Year","Month","Day","Hour",".time.grb2"}],{t,Length[time]},{k,Length[var]-2}]];

Export["/Users/pan11/Documents/SADAN/forecast_historical_prognostic.sh",script,"Table"]

script=Flatten[Table[DateString[time[[t]],
{"wget -nc https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/first-look/6-hourly-time-series-9-month/",
var[[k]]<>"/","Year","Month","/",var[[k]]<>".","Year","Month","Day","Hour",".time.grb2"}],{t,Length[time]},{k,{-2,-1}}]];
Export["/Users/pan11/Documents/SADAN/forecast_historical_diagnostic.sh",script,"Table"]
