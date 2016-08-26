CREATE OR REPLACE VIEW aliases AS
	SELECT DISTINCT users.username || '@' || users.domain AS destination, valiases.source || '@' || vdomains.name AS source FROM valiases
	LEFT JOIN users ON users.id=valiases.vuser_id
	LEFT JOIN vdomains ON valiases.vdomain_id=vdomains.id;
