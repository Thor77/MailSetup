CREATE OR REPLACE VIEW users AS
	SELECT vusers.id, vusers.name as username, vdomains.name as domain, vusers.password FROM vusers
	LEFT JOIN vdomains on vdomains.id=vusers.vdomain_id
