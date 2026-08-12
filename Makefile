.PHONY: syntax lint placeholders

syntax:
	ansible-playbook --syntax-check -i 'localhost,' -c local deploy.yml

lint:
	ansible-lint deploy.yml roles/
	yamllint .

placeholders:
	@grep -R "REPLACE_BEFORE\|REPLACE_WITH" --exclude-dir=.git . || true
