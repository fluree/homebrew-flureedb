.PHONY: vagrant-up test test-in-vagrant run-tests clean

test-in-vagrant: vagrant-up
	vagrant ssh -c 'cd vagrant; make run-tests'
	@echo "Tests successful\nIf you're done with it, you can shut down & reset the vagrant VM with:\nmake clean"

run-tests:
	brew --version
	brew uninstall flureedb || true
	HOMEBREW_NO_INSTALL_FROM_API=1 JAVA_HOME=/usr/local/opt/openjdk brew install --formula Formula/flureedb.rb
	brew audit --strict --online fluree/flureedb/flureedb
	brew test flureedb
	brew uninstall flureedb
	HOMEBREW_NO_INSTALL_FROM_API=1 env JAVA_HOME=/usr/local/opt/openjdk brew install --HEAD --formula Formula/flureedb.rb
	brew test flureedb
	brew uninstall flureedb

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
