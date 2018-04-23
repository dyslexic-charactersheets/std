help:
	@echo "  $$ make setup"
	@echo "  $$ make validate-character file=filename.json"

setup:
	npm install

validate-character:
	@nodejs node_modules/.bin/ajv -d $(file) -s character-schema/character-schema-v0.json

validate-game-data:
	@nodejs node_modules/.bin/ajv -d $(file) -s game-data-schema/game-data-schema-v0.json