.PHONY: vagrant-up test clean

test: vagrant-up
	vagrant ssh -c 'brew --version'
	vagrant ssh -c 'cd vagrant; brew audit --strict --online --formula flureedb.rb'
	vagrant ssh -c 'cd vagrant; env JAVA_HOME=/usr/local/opt/openjdk brew install --HEAD --formula flureedb.rb'
	vagrant ssh -c 'brew uninstall flureedb'
	vagrant ssh -c 'cd vagrant; env JAVA_HOME=/usr/local/opt/openjdk brew install --formula flureedb.rb'
	@echo "Tests successful\nIf you're done with it, you can shut down & reset the vagrant VM with:\nmake clean"

vagrant-up: Vagrantfile
	./ensure-vagrant.sh

clean:
	vagrant destroy -f
