db = db.getSiblingDB('devdb-45');
db.createUser({
  user: 'appuser-snraoisnr4',
  pwd: 'apppass-aoeursn45s',
  roles: [ { role: 'readWrite', db: 'devdb-45' } ]
});
