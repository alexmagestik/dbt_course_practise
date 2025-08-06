{% docs aircrafts_description %}
# Самолеты

'''sql
CREATE TABLE daircrafts (
	aircraft_code char(3) NOT NULL PRIMARY KEY,
	model text NOT NULL,
	range integer NOT NULL
);

SELECT aircraft_code, model, range
FROM demo_src.aircrafts;
'''

{% enddocs %}