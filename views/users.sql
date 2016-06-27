CREATE OR REPLACE VIEW users AS
	SELECT vusers.id as vuser_id, vusers.name as username, vdomains.name as domain, vusers.password FROM vusers
	LEFT JOIN vdomain_vusers ON vdomain_vusers.vuser_id=vusers.id
	LEFT JOIN vdomains ON vdomains.id=vdomain_vusers.vdomain_id;