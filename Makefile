.PHONY: vagrant-up test test-in-vagrant run-tests clean

test-in-vagrant: vagrant-up
	vagrant ssh -c 'cd vagrant; make run-tests'
	@echo "Tests successful\nIf you're done with it, you can shut down & reset the vagrant VM with:\nmake clean"

run-tests:
	brew --version
	brew audit --strict --online --formula Formula/*
	env JAVA_HOME=/usr/local/opt/openjdk brew install --HEAD --formula Formula/flureedb.rb
	brew uninstall flureedb
	env JAVA_HOME=/usr/local/opt/openjdk brew install --formula Formula/flureedb.rb

test:
ifdef GITHUB_ACTIONS
	$(MAKE) run-tests
else
	$(MAKE) test-in-vagrant
endif

vagrant-up: Vagrantfile
	./ensure-vagrant.sh

clean:
	vagrant destroy -f
