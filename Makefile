dev_build_env:
	python setup.py develop > /dev/null
	pip install -r requirements/devel.txt > /dev/null
	
dev_run_tests:
	py.test --cov=keepass_http --cov-report=term-missing
	
dev_test:	dev_build_env	dev_run_tests
	
show_html_coverage:	dev_test
	rm -rf coverage_html_report/
	coverage html
	xdg-open coverage_html_report/index.html
	
style:
	@echo "Autopep8..."
	autopep8 --aggressive --max-line-length=100 --indent-size=4 \
		 --in-place -r scripts/* tests/* keepass_http/*
	@echo "Formatting python imports..."
	isort -rc .	
	@echo "Pyflakes..."
	find . -name "*.py" -exec pyflakes {} \;
	
clean:
	find . -name __pycache__ -type d -exec rm -rf {} \;
	find . -name "*.pyc" -delete
