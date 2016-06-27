/*
Postfix just accepts one destination for an alias => we use a window-function to just return one domain from a user
*/
CREATE OR REPLACE VIEW aliases AS
	SELECT DISTINCT users.username || '@' || users.domain AS destination, valiases.source || '@' || vdomains.name AS source FROM valiases
	LEFT JOIN (SELECT username, vuser_id, first_value(domain) OVER () AS domain FROM users) AS users ON users.vuser_id=valiases.vuser_id
	LEFT JOIN vdomains ON valiases.vdomain_id=vdomains.id;
